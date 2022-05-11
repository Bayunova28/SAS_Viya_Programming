/*Create global variables for numeric variables*/
PROC CONTENTS NOPRINT DATA=TRAIN_ADJ (KEEP=_NUMERIC_ DROP=id host_id
	price price_log)
	OUT=VAR3 (KEEP=name);
RUN;

PROC SQL NOPRINT;
	SELECT name INTO: tree_num separated by " " FROM VAR3;
QUIT;

%PUT &tree_num;

/*Create global variables for character variables*/
PROC CONTENTS NOPRINT DATA=TRAIN_ADJ (KEEP=_CHARACTER_
	DROP=Property_CAT)
	OUT=VAR4 (KEEP=name);
RUN;

PROC SQL NOPRINT;
	SELECT name INTO: tree_char separated by " " FROM VAR4;
QUIT;

%PUT &tree_char;

ods graphics on;

PROC HPSPLIT DATA=WORK.TRAIN_ADJ seed=42;
	CLASS &tree_char.;
	MODEL price = &tree_char. &tree_num.;
	OUTPUT OUT=hpsplout;
	CODE FILE='/home/u61270967/my_shared_file_links/hpsplexc1.sas';
run;

DATA TEST_SCORED;
	SET TEST_ADJ;
	%INCLUDE '/home/u61270967/my_shared_file_links/hpsplexc1.sas';
RUN;
	
