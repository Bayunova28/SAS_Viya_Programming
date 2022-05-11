/* PROC UNIVARIATE data=CLEAN; VAR Bedrooms bathrooms beds; run; */

PROC FREQ DATA= Clean; TABLES host_count_cat; RUN;

PROC MEANS DATA=Clean;
 CLASS host_count_cat;
 VAR Price price_log;
RUN;

/* Create global numeric variables */
PROC CONTENTS NOPRINT DATA=Clean (KEEP=_NUMERIC_ DROP=id host_id
latitude longitude Price Price_Log) OUT=var1 (KEEP=name);
RUN;

PROC SQL NOPRINT;
 SELECT name INTO:varx separated by " " FROM var1;
 QUIT;
 
 %PUT &varx;
 
 /*CREATE Correlation analysis */
 
 PROC CORR DATA=Clean;
 VAR &varx.;
 RUN;