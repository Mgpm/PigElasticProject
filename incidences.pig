incidences = LOAD 'incidences'  USING PigStorage(',') AS (Date, Location,ERS, Type);
dump incidences;
