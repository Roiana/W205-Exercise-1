--Calculating the range of the condition scores across hospitals.
DROP TABLE RANGE_FT;
CREATE TABLE RANGE_FT
(HOSP_VAR STRING,
RANGE INT)
AS
SELECT 'EMR', MAX(emr_avg_score)- MIN(emr_avg_score) from JOIN9
UNION SELECT 'SCI', MAX(sci_avg_score)- MIN(sci_avg_score) from JOIN9
UNION SELECT 'ASTH', MAX(asth_avg_score) - MIN(asth_avg_score) from JOIN9
UNION SELECT 'HF', MAX(hf_avg_score) - MIN(hf_avg_score) from JOIN9
UNION SELECT 'SC', MAX(sc_avg_score) - MIN(sc_avg_score) from JOIN9
UNION SELECT 'PNEU', MAX(pneu_avg_score) - MIN(pneu_avg_score) from JOIN9
UNION SELECT 'PREV', MAX(prev_avg_score) - MIN(prev_avg_score) from JOIN9
UNION SELECT 'BC', MAX(BC_avg_score) - MIN(BC_avg_score) from JOIN9
UNION SELECT 'HEART', MAX(heart_avg_score) - MIN(heart_avg_score) from JOIN9
UNION SELECT 'PREG', MAX(preg_avg_score)- MIN(preg_avg_score) from JOIN9;

--Calculating the maximum of the condition scores across hospitals.
DROP TABLE MAX_F;
CREATE TABLE MAX_F
(HOSP_VAR STRING,
MAX INT)
AS
SELECT 'EMR', MAX(emr_avg_score) from JOIN9
UNION SELECT 'SCI', MAX(sci_avg_score) from JOIN9
UNION SELECT 'ASTH', MAX(asth_avg_score) from JOIN9
UNION SELECT 'HF', MAX(hf_avg_score) from JOIN9
UNION SELECT 'SC', MAX(sc_avg_score) from JOIN9
UNION SELECT 'PNEU', MAX(pneu_avg_score) from JOIN9
UNION SELECT 'PREV', MAX(prev_avg_score) from JOIN9
UNION SELECT 'BC', MAX(BC_avg_score) from JOIN9
UNION SELECT 'HEART', MAX(heart_avg_score) from JOIN9
UNION SELECT 'PREG', MAX(preg_avg_score)from JOIN9;

--Calculating the minimum of the condition scores across hospitals.
DROP TABLE MIN_FT;
CREATE TABLE MIN_FT
(HOSP_VAR STRING,
MIN INT)
AS
SELECT 'EMR', MIN(emr_avg_score) from JOIN9
UNION SELECT 'SCI', MIN(sci_avg_score) from JOIN9
UNION SELECT 'ASTH', MIN(asth_avg_score) from JOIN9
UNION SELECT 'HF', MIN(hf_avg_score) from JOIN9
UNION SELECT 'SC', MIN(sc_avg_score) from JOIN9
UNION SELECT 'PNEU', MIN(pneu_avg_score) from JOIN9
UNION SELECT 'PREV', MIN(prev_avg_score) from JOIN9
UNION SELECT 'BC', MIN(BC_avg_score) from JOIN9
UNION SELECT 'HEART', MIN(heart_avg_score) from JOIN9
UNION SELECT 'PREG', MIN(preg_avg_score) from JOIN9;

--Calculating the average of the condition scores across hospitals.
DROP TABLE AVG_FT;
CREATE TABLE AVG_FT
(HOSP_VAR STRING,
AVG INT)
AS
SELECT 'EMR', AVG(emr_avg_score) from JOIN9
UNION SELECT 'SCI', AVG(sci_avg_score) from JOIN9
UNION SELECT 'ASTH', AVG(asth_avg_score) from JOIN9
UNION SELECT 'HF', AVG(hf_avg_score) from JOIN9
UNION SELECT 'SC', AVG(sc_avg_score) from JOIN9
UNION SELECT 'PNEU', AVG(pneu_avg_score) from JOIN9
UNION SELECT 'PREV', AVG(prev_avg_score) from JOIN9
UNION SELECT 'BC', AVG(BC_avg_score) from JOIN9
UNION SELECT 'HEART', AVG(heart_avg_score) from JOIN9
UNION SELECT 'PREG', AVG(preg_avg_score) from JOIN9;

--Calculating the standard deviation of the condition scores across hospitals.
DROP TABLE STD_FT;
CREATE TABLE STD_FT
(HOSP_VAR STRING,
STD INT)
AS
SELECT 'EMR', STDDEV(emr_avg_score) from JOIN9
UNION SELECT 'SCI', STDDEV(sci_avg_score) from JOIN9
UNION SELECT 'ASTH', STDDEV(asth_avg_score) from JOIN9
UNION SELECT 'HF', STDDEV(hf_avg_score) from JOIN9
UNION SELECT 'SC', STDDEV(sc_avg_score) from JOIN9
UNION SELECT 'PNEU', STDDEV(pneu_avg_score) from JOIN9
UNION SELECT 'PREV', STDDEV(prev_avg_score) from JOIN9
UNION SELECT 'BC', STDDEV(BC_avg_score) from JOIN9
UNION SELECT 'HEART', STDDEV(heart_avg_score) from JOIN9
UNION SELECT 'PREG', STDDEV(preg_avg_score) from JOIN9;

--Creating a table which joins the range of the condition scores to the maximum of the condition scores.
DROP TABLE RG_MAX_JOIN;
CREATE TABLE RG_MAX_JOIN AS
SELECT RANGE_FT.hosp_var, RANGE, MAX
FROM RANGE_FT
INNER JOIN MAX_F
ON RANGE_FT.hosp_var = MAX_F.hosp_var;

--Creating a table which joins the range of the condition scores and the maximum of the condition scores to the minimum of the condition scores.
DROP TABLE RG_MAX_MIN_JOIN;
CREATE TABLE RG_MAX_MIN_JOIN AS
SELECT RG_MAX_JOIN.hosp_var, RANGE, MAX, MIN
FROM RG_MAX_JOIN
INNER JOIN MIN_FT
ON RG_MAX_JOIN.hosp_var = MIN_FT.hosp_var;

--Creating a table which joins the range of the condition scores, the maximum of the condition scores and the minimum of the condition scores to average of the condition scores.
DROP TABLE RG_MAX_MIN_AVG_JOIN;
CREATE TABLE RG_MAX_MIN_AVG_JOIN AS
SELECT RG_MAX_MIN_JOIN.hosp_var, RANGE, MAX, MIN, AVG
FROM RG_MAX_MIN_JOIN
INNER JOIN AVG_FT
ON RG_MAX_MIN_JOIN.hosp_var = AVG_FT.hosp_var;

--Creating a table which joins the range of the condition scores, the maximum of the condition scores, the minimum of the condition scores and the average of the condition scores to the standard deviation of the condition scores.
DROP TABLE RG_MAX_MIN_AVG_STD_FINAL;
CREATE TABLE RG_MAX_MIN_AVG_STD_FINAL AS
SELECT RG_MAX_MIN_AVG_JOIN.hosp_var, RANGE, MAX, MIN, AVG, STD
FROM RG_MAX_MIN_AVG_JOIN
INNER JOIN STD_FT
ON RG_MAX_MIN_AVG_JOIN.hosp_var = STD_FT.hosp_var
ORDER BY STD DESC;

--Table displaying the summary statistics across hospitals for each condition.
SELECT  * FROM RG_MAX_MIN_AVG_STD_FINAL;
