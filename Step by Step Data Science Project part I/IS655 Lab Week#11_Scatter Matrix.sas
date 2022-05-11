PROC STANDARD data=Clean Out=Stnd_Clean
 Mean=0 STD=1 REPLACE;
 VAR accommodates bathrooms bedrooms beds guests_included
   minimum_nights maximum_nights availability_30 beds_per_accom bath_per_accom
  poly_accom poly_bath poly_guests poly_min poly_max poly_avail;
  
RUN;

PROC SGSCATTER Data=Stnd_Clean;
 Title 'Scatter Plot Matrix';
 Matrix Price_log accommodates guests_included minimum_nights maximum_nights/
 Start=TOPLEFT ELLIPSE = (ALpha=0.05 TYPE= predicted) NOLEGEND;
 
 RUN;