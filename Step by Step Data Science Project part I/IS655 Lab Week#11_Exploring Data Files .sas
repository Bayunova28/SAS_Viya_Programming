/* Explore the target variable */
PROC UNIVARIATE DATA=TRAIN; VAR Price; HISTOGRAM ; RUN;


/* Eliminate outliers and create log transformed price variable */
DATA Price;
   SET TRAIN;
   WHERE 30 le Price le 750;
   Price_Log = LOG(Price);
RUN;


PROC UNIVARIATE DATA=WORK.Price; 
   VAR Price; 
   HISTOGRAM; 
RUN;

PROC UNIVARIATE DATA=WORK.Price; VAR Price_Log; HISTOGRAM; RUN;


PROC MEANS DATA=Price (KEEP = _NUMERIC_) N NMISS MIN MAX MEAN MEDIAN STD; RUN;