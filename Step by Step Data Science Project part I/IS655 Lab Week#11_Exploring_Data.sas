PROC CONTENTS DATA=MYDATA.Listings; RUN;

PROC FREQ DATA=MYDATA.Listings;
 TABLES neighbourhood_group_cleansed;
RUN;

PROC FREQ DATA=MYDATA.LISTINGS ORDER=FREQ;
TABLES neighbourhood_group_cleansed;
RUN;

PROC FREQ DATA=MYDATA.LISTINGS ORDER=FREQ;
 TABLES neighbourhood_group_cleansed * room_type /
 NOCOL NOROW NOPERCENT OUT=room_freg;
RUN;

PROC UNIVARIATE DATA=MYDATA.LISTINGS;
VAR Price;
HISTOGRAM;

RUN;

PROC MEANS DATA=MYDATA.LISTINGS; 
VAR price accommodates bathrooms;
RUN;

PROC MEANS DATA=MYDATA.LISTINGS N NMISS MIN MAX MEAN MEDIAN STDDEV;
CLASS room_type;
VAR price accommodates bathrooms;
OUTPUT OUT=list_stats;

RUN;

PROC SUMMARY DATA=MYDATA.LISTINGS;
VAR price accommodates bathrooms;
OUTPUT OUT=list_sum;

PROC SORT DATA=MYDATA.LISTINGS OUT=list_sort;
 BY host_id;
 RUN;
 
PROC SUMMARY DATA=list_sort;
 BY host_id;
 VAR price accommodates bathrooms;
 OUTPUT OUT=list_sum SUM=;
RUN;

DATA WORK.TEST;
 SET MYDATA.Listings;
 WHERE accommodates le 4;
RUN;

DATA WORK.TEST;
 SET MYDATA.LISTINGS;
 IF accommodates le 4;
RUN;

/* Split data into TRAIN and TEST datasets at an 80/20 split */
PROC SURVEYSELECT DATA=Mydata.listings SAMPRATE=0.20 SEED=42
OUT=Full OUTALL METHOD=SRS;
RUN;

DATA TRAIN TEST;
SET FULL;
IF SELECTED=0 THEN OUTPUT TRAIN; ELSE OUTPUT TEST;
DROP Selected;