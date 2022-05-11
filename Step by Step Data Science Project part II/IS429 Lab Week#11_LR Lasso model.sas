data train_final; 
   set train_adj;
   log_accom = log(accommodates +1);
   log_bath = log(bathrooms +1);
   log_bedrooms = log(bedrooms +1);
   log_guest = log(guests_included +1);
   log_min = log(minimum_nights +1);
   log_max = log(maximum_nights +1);
   log_avil30 = log(availability_30 +1);
   log_avil60 = log(availability_60 +1);
   log_avil90 = log(availability_90 +1);
   log_bedsper = log(beds_per_accom +1);
   IF neighbourhood_group_cleansed = 'Bronx' then n_bronx = 1; else n_bronx = 0; 
   IF neighbourhood_group_cleansed = 'Brooklyn' then n_brooklyn = 1; else n_brooklyn = 0;    
   IF neighbourhood_group_cleansed = 'Manhattan' then n_manhattan = 1; else n_manhattan = 0;    
   IF neighbourhood_group_cleansed = 'Queens' then n_queens = 1; else n_queens = 0;       
   IF neighbourhood_group_cleansed = 'Staten Is' then n_staten = 1; else n_staten = 0;
   
   IF room_type = 'Entire home/apt' then r_entire = 1; else r_entire = 0; 
   IF room_type = 'Private room' then r_private = 1; else r_private = 0;   
   IF room_type = 'Shared room' then r_shared = 1; else r_shared = 0; 
   
   IF host_is_superhost = 't' then h_super = 1; else h_super = 0;
   IF host_has_profile_pic = 't' then h_profile = 1; else h_profile = 0;
   IF host_identity_verified = 't' then h_verified = 1; else h_verified = 0;
   
   IF bed_type = 'Airbed' then b_air = 1; else b_air = 0; 
   IF bed_type = 'Couch' then b_couch = 1; else b_couch = 0; 
   IF bed_type = 'Futon' then b_futon = 1; else b_futon = 0; 
   IF bed_type = 'Pull-out Sofa' then b_pullout = 1; else b_pullout = 0;
   IF bed_type = 'Real Bed' then b_real = 1; else b_real = 0;
   
   IF instant_bookable = 't' then instant = 1; else instant = 0;
   IF require_guest_profile_picture = 't' then require_pic = 1; else require_pic = 0;
   IF require_guest_phone_verification = 't' then require_phone = 1; else require_phone = 0;
   
   IF host_count_cat = 'Level 1' then hcount_level1 = 1; else hcount_level1 = 0; 
   IF host_count_cat = 'Level 2' then hcount_level2 = 1; else hcount_level2 = 0; 
   IF host_count_cat = 'Level 3' then hcount_level3 = 1; else hcount_level3 = 0; 
   
   IF Property_CAT = 'Apartment' then p_apart = 1; else p_apart = 0; 
   IF Property_CAT = 'Condominium' then p_condo = 1; else p_condo = 0; 
   IF Property_CAT = 'Group 1' then p_group1 = 1; else p_group1 = 0; 
   IF Property_CAT = 'Group 2' then p_group2 = 1; else p_group2 = 0; 
   IF Property_CAT = 'House' then p_house = 1; else p_house = 0; 
   IF Property_CAT = 'Loft' then p_loft = 1; else p_loft = 0;  
   IF Property_CAT = 'Townhouse' then p_townhouse = 1; else p_townhouse = 0; 
   
   DROP Property_CAT host_count_cat require_guest_phone_verification require_guest_profile_picture
       instant_bookable bed_type host_identity_verified host_has_profile_pic host_is_superhost
       room_type neighbourhood_group_cleansed host_listings_count latitude longitude ;

RUN;

data test_final; 
   set test_adj;
   IF neighbourhood_group_cleansed = 'Bronx' then n_bronx = 1; else n_bronx = 0; 
   IF neighbourhood_group_cleansed = 'Brooklyn' then n_brooklyn = 1; else n_brooklyn = 0;    
   IF neighbourhood_group_cleansed = 'Manhattan' then n_manhattan = 1; else n_manhattan = 0;    
   IF neighbourhood_group_cleansed = 'Queens' then n_queens = 1; else n_queens = 0;       
   IF neighbourhood_group_cleansed = 'Staten Is' then n_staten = 1; else n_staten = 0;
   
   IF room_type = 'Entire home/apt' then r_entire = 1; else r_entire = 0; 
   IF room_type = 'Private room' then r_private = 1; else r_private = 0;   
   IF room_type = 'Shared room' then r_shared = 1; else r_shared = 0; 
   
   IF host_is_superhost = 't' then h_super = 1; else h_super = 0;
   IF host_has_profile_pic = 't' then h_profile = 1; else h_profile = 0;
   IF host_identity_verified = 't' then h_verified = 1; else h_verified = 0;
   
   IF bed_type = 'Airbed' then b_air = 1; else b_air = 0; 
   IF bed_type = 'Couch' then b_couch = 1; else b_couch = 0; 
   IF bed_type = 'Futon' then b_futon = 1; else b_futon = 0; 
   IF bed_type = 'Pull-out Sofa' then b_pullout = 1; else b_pullout = 0;
   IF bed_type = 'Real Bed' then b_real = 1; else b_real = 0;
   
   IF instant_bookable = 't' then instant = 1; else instant = 0;
   IF require_guest_profile_picture = 't' then require_pic = 1; else require_pic = 0;
   IF require_guest_phone_verification = 't' then require_phone = 1; else require_phone = 0;
   
   IF host_count_cat = 'Level 1' then hcount_level1 = 1; else hcount_level1 = 0; 
   IF host_count_cat = 'Level 2' then hcount_level2 = 1; else hcount_level2 = 0; 
   IF host_count_cat = 'Level 3' then hcount_level3 = 1; else hcount_level3 = 0; 
   
   IF Property_CAT = 'Apartment' then p_apart = 1; else p_apart = 0; 
   IF Property_CAT = 'Condominium' then p_condo = 1; else p_condo = 0; 
   IF Property_CAT = 'Group 1' then p_group1 = 1; else p_group1 = 0; 
   IF Property_CAT = 'Group 2' then p_group2 = 1; else p_group2 = 0; 
   IF Property_CAT = 'House' then p_house = 1; else p_house = 0; 
   IF Property_CAT = 'Loft' then p_loft = 1; else p_loft = 0;  
   IF Property_CAT = 'Townhouse' then p_townhouse = 1; else p_townhouse = 0;  
   
   DROP Property_CAT host_count_cat require_guest_phone_verification require_guest_profile_picture
       instant_bookable bed_type host_identity_verified host_has_profile_pic host_is_superhost
       room_type neighbourhood_group_cleansed
       host_listings_count latitude longitude ;

RUN;  
  

*************************************************;
/* GLM Linear Regression MODEL */
*************************************************;

%let lasso_var = log_accom log_bath log_guest log_min log_max log_avil30 log_bedsper
n_bronx n_brooklyn n_manhattan n_queens r_entire r_private h_super h_profile h_verified
b_couch b_futon b_pullout b_real instant require_pic require_phone
hcount_level1 hcount_level2 hcount_level3 p_apart p_condo p_group2 p_house p_loft
p_townhouse n_staten r_shared b_air p_group1 poly_accom poly_bath poly_guests poly_min
poly_max poly_avail;

%macro doglm;
%do k=3 %to 5;
PROC GLMSELECT DATA=WORK.TRAIN_FINAL OUTDESIGN(ADDINPUTVARS)=Work.reg_design
	PLOTS(stepaxis=normb)=all;
	MODEL Price_Log=&lasso_var. / selection=lasso(stop=&k choose=SBC);
	OUTPUT OUT = train_score;
	SCORE DATA=TEST_FINAL PREDICTED RESIDUAL OUT=test_score;
run;
%end;
%mend;
%doglm;

ODS GRAPHICS ON;

PROC GLMSELECT DATA=WORK.TRAIN_FINAL OUTDESIGN(ADDINPUTVARS)=Work.reg_design
	PLOTS(stepaxis=normb)=all;
	MODEL Price_Log=&lasso_var. / selection=lasso(stop=none choose=sbc);
	OUTPUT OUT = train_score;
	SCORE DATA=TEST_FINAL PREDICTED RESIDUAL OUT=test_score;
run;