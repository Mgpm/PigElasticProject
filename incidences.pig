DEFINE date_by_month `date_by_month.py` SHIP('/home/malloc/PigRep/incidenceSecurity/date_by_month.py');

inc = LOAD '/home/malloc/PigRep/incidenceSecurity/incidents-securite.csv' USING PigStorage(',') AS (date,location,ers, type);

data = STREAM inc through date_by_month;

store data into 'inc';
