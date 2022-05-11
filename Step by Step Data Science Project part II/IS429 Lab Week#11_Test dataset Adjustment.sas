 /* Make adjustments to the TEST dataset */
DATA TEST_2;
SET TEST_Zip;
WHERE 30 le Price le 750;
Price_Log = LOG(Price);
IF zipcode = . then zipcode = new_zip;
IF neighbourhood_cleansed = 'Civic Center' and zipcode = . THEN zipcode = 10038;
IF neighbourhood_cleansed = 'Westerleigh' and zipcode = . THEN zipcode = 10314;
zip = put(zipcode, $5.); /*Convert zipcode to character variable*/
IF security_deposit = . THEN security_deposit = 0;
IF cleaning_fee = . THEN cleaning_fee = 0;
IF bathrooms = . THEN bathrooms = 1;
IF bathrooms ge 4 then bathrooms = 4;
IF bedrooms = . THEN bedrooms = 1;
IF bedrooms ge 5 then bedrooms = 5;
IF beds = . THEN beds = 1;
IF beds ge 5 THEN beds = 5;
IF host_listings_count = . THEN host_listings_count = 1;
IF host_listings_count le 1 then host_count_cat = 'Level 1'; else
IF 2 le host_listings_count le 10 then host_count_cat = 'Level 2'; else
IF host_listings_count gt 10 then host_count_cat = 'Level 3';
IF maximum_nights gt 1125 then maximum_nights =1125;
IF minimum_nights gt 31 then minimum_nights = 31;

IF availability_30 = . then availability_30 = 0;
IF availability_60 = . then availability_60 = 0;
IF availability_90 = . then availability_90 = 0;
IF availability_365 = . then availability_365 = 0;
IF number_of_reviews = . then number_of_reviews = 0;
IF reviews_per_month = . then reviews_per_month = 0;

/* Feature Engineering */
IF beds not in (., 0) then beds_per_accom = accomodates / beds; else beds_per_accom = 0;
IF bathrooms not in (., 0) then bath_per_accom = accomodates / bathrooms; else bath_per_accom = 0;

/* Create polynomials */
poly_accom = accomodates**2;
poly_bath = bathrooms**2;
poly_guests = guests_included**2;
poly_min = minimum_nights**2;
poly_max = maximum_nights**2;
poly_avail = availability_30**2;

IF Property_Type in ('Apartment', 'House', 'Townhouse', 'Loft', 'Condominium')
	THEN Property_CAT = Property_Type; ELSE
IF Property_Type in ('Houseboat', 'Resort', 'Tent', 'Serviced ap', 'Aparthotel',
					'Hotel', 'Boat', 'Other', 'Boutique ho')
	THEN Property_CAT = 'Group 1'; ELSE Property_CAT = 'Group 2';

IF host_has_profile_pic = ' ' then host_has_profile_pic = 'f';
IF host_identity_verified = ' ' then host_identity_verified = 'f';
IF host_is_superhost = ' ' then host_is_superhost = 'f';

DROP review_scores_accuracy review_scores_checkin review_scores_cleanliness
	review_scores_communication review_scores_location review_scores_rating
	review_scores_value review_per_month number_of_reviews calculated_host_listings_count
	square_feet new_zip zipcode weekly_price monthly_price first_review last_review;

RUN;

PROC STANDARD DATA=TEST_2 OUT=TEST_ADJ
	MEAN=0 STD=1 REPLACE;
	VAR accomodates bathrooms beds guests_included
		minimum_nights maximum_nights availability_30 beds_per_accom bath_per_accom
		poly_accom poly_bath poly_guests poly_min poly_max poly_avail;

RUN;
