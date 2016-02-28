--Creating a table which looks at the average nurse dimension, doctor dimension, staff dimension, pain dimension, medicine dimension, clean and quiet dimension, discharge dimension, total achievement, total improvement and total dimension scores across hospitals.
DROP TABLE SURV_AVG_F;
CREATE TABLE SURV_AVG_F AS
SELECT hospital_name,
AVG(nur_dim) AS nur_dim_avg_score,
AVG(doc_dim) AS doc_dim_avg_score,
AVG(staff_dim) AS staff_dim_avg_score,
AVG(pain_dim) AS pain_dim_avg_score,
AVG(med_dim) AS med_dim_avg_score,
AVG(clquiet_dim) AS clquiet_dim_avg_score,
AVG(disch_dim) AS disch_dim_avg_score,
AVG(total_ac) AS total_ac_avg_score,
AVG(total_imp) AS total_imp_avg_score,
AVG(total_dim) AS tot_dim_avg_score
FROM ER_surv_resp
GROUP BY hospital_name
ORDER BY tot_dim_avg_score DESC;


--Joining the table with the 10 selected average scores from the survey responses with the table above which contains the average rank of the hospitals created for part 1.
DROP TABLE SURV_QUAL_JOIN_F;
CREATE TABLE SURV_QUAL_JOIN_F AS
SELECT EFFEC_FIN.hospital_name, EFFEC_FIN.test_avg, SURV_AVG_F.nur_dim_avg_score, SURV_AVG_F.doc_dim_avg_score, SURV_AVG_F.staff_dim_avg_score, SURV_AVG_F.pain_dim_avg_score, SURV_AVG_F.med_dim_avg_score, SURV_AVG_F.clquiet_dim_avg_score, SURV_AVG_F.disch_dim_avg_score, SURV_AVG_F.total_ac_avg_score, SURV_AVG_F.total_imp_avg_score, SURV_AVG_F.tot_dim_avg_score
FROM EFFEC_FIN
INNER JOIN SURV_AVG_F
ON EFFEC_FIN.hospital_name = SURV_AVG_F.hospital_name
ORDER BY EFFEC_FIN.test_avg;


--The table calculates the correlation between the average rank of the hospital and each of the measures used from the Survey Response table.
DROP TABLE ROW_FF;
CREATE TABLE ROW_FF
(Surv_Resp STRING,
Correlation DECIMAL(3,2))
AS
SELECT 'Cor_nur', (Avg(test_avg * nur_dim_avg_score) - Avg(test_avg) * Avg(nur_dim_avg_score)) / (Stddev(test_avg) * Stddev(nur_dim_avg_score)) FROM SURV_QUAL_JOIN_F
UNION SELECT 'Cor_doc', (Avg(test_avg * doc_dim_avg_score) - Avg(test_avg) * Avg(doc_dim_avg_score)) / (Stddev(test_avg) * Stddev(doc_dim_avg_score)) FROM SURV_QUAL_JOIN_F
UNION SELECT 'Cor_staff', (Avg(test_avg * staff_dim_avg_score) - Avg(test_avg) * Avg(staff_dim_avg_score)) / (Stddev(test_avg) * Stddev(staff_dim_avg_score)) FROM SURV_QUAL_JOIN_F
UNION SELECT 'Cor_pain', (Avg(test_avg * pain_dim_avg_score) - Avg(test_avg) * Avg(pain_dim_avg_score)) / (Stddev(test_avg) * Stddev(pain_dim_avg_score)) FROM SURV_QUAL_JOIN_F
UNION SELECT 'Cor_med', (Avg(test_avg * med_dim_avg_score) - Avg(test_avg) * Avg(med_dim_avg_score)) / (Stddev(test_avg) * Stddev(med_dim_avg_score)) FROM SURV_QUAL_JOIN_F
UNION SELECT 'Cor_clquiet', (Avg(test_avg * clquiet_dim_avg_score) - Avg(test_avg) * Avg(clquiet_dim_avg_score)) / (Stddev(test_avg) * Stddev(clquiet_dim_avg_score)) FROM SURV_QUAL_JOIN_F
UNION SELECT 'Cor_disch', (Avg(test_avg * disch_dim_avg_score) - Avg(test_avg) * Avg(disch_dim_avg_score)) / (Stddev(test_avg) * Stddev(disch_dim_avg_score)) FROM SURV_QUAL_JOIN_F
UNION SELECT 'Cor_tot_ach', (Avg(test_avg * total_ac_avg_score) - Avg(test_avg) * Avg(total_ac_avg_score)) / (Stddev(test_avg) * Stddev(total_ac_avg_score)) FROM SURV_QUAL_JOIN_F
UNION SELECT 'Cor_tot_imp', (Avg(test_avg * total_imp_avg_score) - Avg(test_avg) * Avg(total_imp_avg_score)) / (Stddev(test_avg) * Stddev(total_imp_avg_score)) FROM SURV_QUAL_JOIN_F
UNION SELECT 'Cor_tot_dim', (Avg(test_avg * tot_dim_avg_score) - Avg(test_avg) * Avg(tot_dim_avg_score)) / (Stddev(test_avg) * Stddev(tot_dim_avg_score)) FROM SURV_QUAL_JOIN_F;

--Table displaying correlations between hospital rankings and survey response variables.
SELECT * FROM ROW_FF;
