REGISTER /usr/local/ElasticHadoop/elasticsearch-hadoop-7.5.2.jar;
DEFINE EsStorage org.elasticsearch.hadoop.pig.EsStorage();

--LOADING DATA OF THE SECURITY INCIDENCES FOR  SNCF
 
inc1 = LOAD 'inc' using PigStorage(',') as (month:int,loc:chararray,ers:chararray,typ:chararray);

--GROUP BY VARIABLE 

grouped_by_month = group inc1 by month;

grouped_by_typ = group inc1 by typ;

grouped_by_loc = group inc1 by loc;

grouped_by_ers = group inc1 by ers;

-- FREQUENCIES BY VARIABLES

frequencies_typ =   foreach grouped_by_typ GENERATE group as typ, COUNT(inc1.typ) as freq_typ;

frequencies_month = foreach grouped_by_month GENERATE group as month, COUNT(inc1.month) as freq_month;

frequencies_ers =   foreach grouped_by_ers GENERATE group as ers, COUNT(inc1.ers) as freq_ers;

frequencies_loc =   foreach grouped_by_loc GENERATE group as loc, COUNT(inc1.loc) as freq_loc;

--GROUP ALL
all_frequencies_typ = group frequencies_typ all;
all_frequencies_month = group frequencies_month all;
all_frequencies_ers = group frequencies_ers all;
all_frequencies_loc = group frequencies_loc all;

-- COMPUTE MIN, MAX, NUMBER OF VARIABLES

Number_of_frequencies_typ = FOREACH all_frequencies_typ GENERATE COUNT(frequencies_typ);

MinMax_of_frequencies_typ = FOREACH all_frequencies_typ GENERATE MIN(frequencies_typ.freq_typ), MAX(frequencies_typ.freq_typ); 

  

--EXPORT ON ELASTIC STACK

STORE inc1 INTO 'pig_incidences/security_data' USING org.elasticsearch.hadoop.pig.EsStorage();



--dump inc1;

--illustrate grouped_by_month;
--describe grouped_by_month;


