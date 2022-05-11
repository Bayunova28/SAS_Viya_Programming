/*Create neighbourhood avg price */
PROC SORT DATA=TRAIN_ADJ; BY neighbourhood_cleansed; RUN;
PROC MEANS DATA=TRAIN_ADJ;
	VAR PRICE;
	BY neighbourhood_cleansed;
	OUTPUT OUT=neigh;
RUN;

DATA neigh; SET neigh; WHERE _STAT_ = 'MEAN'; neigh_avg_price = price;
DROP price _FREQ_ _TYPE_ _STAT_; RUN;

PROC SQL;
	CREATE TABLE AVG AS
	SELECT *
	FROM TRAIN_ADJ AS a
	LEFT JOIN neigh AS b
		ON a.neighbourhood_cleansed = b.neighbourhood_cleansed
			WHERE a.neighbourhood_cleansed IS NOT NULL;
QUIT;


DATA AVG;
	SET AVG;

/*Create global avg price as baseline */
	base_avg = (price - 139.26);
	
/*Create neighbourhood_group price as second baseline */
	IF neighbourhood_group_cleansed = 'Bronx	' then neigh_price = 84.93 ; else
	IF neighbourhood_group_cleansed = 'Brooklyn	' then neigh_price = 115.82 ; else
	IF neighbourhood_group_cleansed = 'Manhattan' then neigh_price = 173.52 ; else
	IF neighbourhood_group_cleansed = 'Queens	' then neigh_price = 94.18 ; else
	IF neighbourhood_group_cleansed = 'Staten Is' then neigh_price = 92.72 ; else
	
	neigh_group_avg = (price - neigh_avg_price)**2;
	
	neigh_avg = (price - neigh_avg_price)**2;
RUN;

PROC SUMMARY DATA=AVG;
	VAR base_avg neigh_group_avg neigh_avg_price;
	OUTPUT OUT=sum_out SUM=;
RUN;
	