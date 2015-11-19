

in_data = LOAD 'transaction_record.csv' USING PigStorage(',') AS (merchant_id,cust_id);

--removes multiple transactions by a single cm at a given se
in_data = DISTINCT in_data;

--groups by cust_id. Schema: cust_id, {cust_id, (merchant_id, merchant_id, merchant_id, merchant_id, ...)}
gpd_data = GROUP i_d2 BY cust_id;

--joins grouped data with in_data.
jnd_data = JOIN i_d2 BY cust_id, gpd_data BY group;

part1 = FOREACH jnd_data GENERATE i_d2::merchant_id AS merchant_id, FLATTEN($3);
part2 = FOREACH part1 GENERATE merchant_id, gpd_data::i_d2::merchant_id;
part3 = GROUP part2 BY ($0,$1);
part4 = FOREACH part3 GENERATE group.$0 AS merchant_id, group.$1 AS merchant_id2, COUNT($1) AS weight;

final_out = FILTER part4 BY $0 != $1;  --removed "loops"

STORE final_out INTO 'output_path' USING PigStorage(',');
