--Creating a table that takes the average scores for the condition “Emergency Department” at each hospital and sorts the hospitals by these average scores in descending order.
DROP TABLE EMR_AVG;
CREATE TABLE EMR_AVG AS
SELECT hospital_name, AVG(score) AS emr_avg_score FROM ER_time_effec WHERE condition = 'Emergency Department'
GROUP BY hospital_name
ORDER BY emr_avg_score DESC;

--Creating a table that takes the average scores for the condition “Surgical Care Improvement” at each hospital and sorts the hospitals by these average scores in descending order.
DROP TABLE SCI_AVG;
CREATE TABLE SCI_AVG AS
SELECT hospital_name, AVG(score) AS sci_avg_score FROM ER_time_effec WHERE condition = 'Surgical Care Improvement Project'
GROUP BY hospital_name
ORDER BY sci_avg_score DESC;

--Creating a table that takes the average scores for the condition “Children’s Asthma” at each hospital and sorts the hospitals by these average scores in descending order.
DROP TABLE ASTH_AVG;
CREATE TABLE ASTH_AVG AS
SELECT hospital_name, AVG(score) AS asth_avg_score FROM ER_time_effec WHERE meas_id = 'CAC_3'
GROUP BY hospital_name
ORDER BY asth_avg_score DESC;

--Creating a table that takes the average scores for the condition “Heart Failure” at each hospital and sorts the hospitals by these average scores in descending order.
DROP TABLE HF_AVG;
CREATE TABLE HF_AVG AS
SELECT hospital_name, AVG(score) AS hf_avg_score FROM ER_time_effec WHERE condition = 'Heart Failure'
GROUP BY hospital_name
ORDER BY hf_avg_score DESC;

--Creating a table that takes the average scores for the condition “Stroke Care” at each hospital and sorts the hospitals by these average scores in descending order.
DROP TABLE SC_AVG;
CREATE TABLE SC_AVG AS
SELECT hospital_name, AVG(score) AS sc_avg_score FROM ER_time_effec WHERE condition = 'Stroke Care'
GROUP BY hospital_name
ORDER BY sc_avg_score DESC;

--Creating a table that takes the average scores for the condition “Pneumonia” at each hospital and sorts the hospitals by these average scores in descending order.
DROP TABLE PNEU_AVG;
CREATE TABLE PNEU_AVG AS
SELECT hospital_name, AVG(score) AS pneu_avg_score FROM ER_time_effec WHERE condition = 'Pneumonia'
GROUP BY hospital_name
ORDER BY pneu_avg_score DESC;

--Creating a table that takes the average scores for the condition “Preventive Care” at each hospital and sorts the hospitals by these average scores in descending order.
DROP TABLE PREV_AVG;
CREATE TABLE PREV_AVG AS
SELECT hospital_name, AVG(score) AS prev_avg_score FROM ER_time_effec WHERE condition = 'Preventive Care'
GROUP BY hospital_name
ORDER BY prev_avg_score DESC;

--Creating a table that takes the average scores for the condition “Blood Clot Prevention and Treatment” at each hospital and sorts the hospitals by these average scores in descending order.
DROP TABLE BC_AVG;
CREATE TABLE BC_AVG AS
SELECT hospital_name, AVG(score) AS bc_avg_score FROM ER_time_effec WHERE condition = 'Blood Clot Prevention and Treatment'
GROUP BY hospital_name
ORDER BY bc_avg_score DESC;

--Creating a table that takes the average scores for the condition “Heart Attack or Chest Pain” at each hospital and sorts the hospitals by these average scores in descending order.
DROP TABLE HEART_AVG;
CREATE TABLE HEART_AVG AS
SELECT hospital_name, AVG(score) AS heart_avg_score FROM ER_time_effec WHERE condition = 'Heart Attack or Chest Pain'
GROUP BY hospital_name
ORDER BY heart_avg_score DESC;

--Creating a table that takes the average scores for the condition “Pregnancy and Delivery Care” at each hospital and sorts the hospitals by these average scores in descending order.
DROP TABLE PREG_AVG;
CREATE TABLE PREG_AVG AS
SELECT hospital_name, AVG(score) AS preg_avg_score FROM ER_time_effec WHERE condition = 'Pregnancy and Delivery Care'
GROUP BY hospital_name
ORDER BY preg_avg_score DESC;

--Joining the table with the average Emergency Department score by hospital with the average Surgical Care Improvement score by hospital.
DROP TABLE JOIN1;
CREATE TABLE JOIN1 AS
SELECT EMR_AVG.hospital_name, EMR_AVG.emr_avg_score, SCI_AVG.sci_avg_score
FROM EMR_AVG
INNER JOIN SCI_AVG
ON EMR_AVG.hospital_name = SCI_AVG.hospital_name;

--Joining the table with the average Emergency Department score and the average Surgical Care Improvement score by hospital with the average Children’s Asthma Scores by hospital table.
DROP TABLE JOIN2;
CREATE TABLE JOIN2 AS
SELECT ASTH_AVG.hospital_name, ASTH_AVG.asth_avg_score, JOIN1.emr_avg_score, JOIN1.sci_avg_score
FROM ASTH_AVG
INNER JOIN JOIN1
ON JOIN1.hospital_name = ASTH_AVG.hospital_name;

--Joining the table with the average Emergency Department score, the average Surgical Care Improvement score, and the average Children’s Asthma scores by hospital with the table containing the average Heart Failure scores by hospital.
DROP TABLE JOIN3;
CREATE TABLE JOIN3 AS
SELECT HF_AVG.hospital_name, HF_AVG.hf_avg_score, JOIN2.emr_avg_score, JOIN2.sci_avg_score, JOIN2.asth_avg_score
FROM HF_AVG
INNER JOIN JOIN2
ON JOIN2.hospital_name = HF_AVG.hospital_name;

--Joining the table with the average Emergency Department score, the average Surgical Care Improvement score, the average Children’s Asthma scores, and the average Heart Failure scores by hospital with the average Stroke Care score by hospital table.
DROP TABLE JOIN4;
CREATE TABLE JOIN4 AS
SELECT SC_AVG.hospital_name, SC_AVG.sc_avg_score, JOIN3.emr_avg_score, JOIN3.sci_avg_score, JOIN3.asth_avg_score, JOIN3.hf_avg_score
FROM SC_AVG
INNER JOIN JOIN3
ON JOIN3.hospital_name = SC_AVG.hospital_name;

--Joining the table with the average Emergency Department score, the average Surgical Care Improvement score, the average Children’s Asthma scores, the average Heart Failure scores and the average Stroke Care score by hospital table with the average Pneumonia score table.
DROP TABLE JOIN5;
CREATE TABLE JOIN5 AS
SELECT PNEU_AVG.hospital_name, PNEU_AVG.pneu_avg_score, JOIN4.emr_avg_score, JOIN4.sci_avg_score, JOIN4.asth_avg_score, JOIN4.hf_avg_score, JOIN4.sc_avg_score
FROM PNEU_AVG
INNER JOIN JOIN4
ON JOIN4.hospital_name = PNEU_AVG.hospital_name;

--Joining the table with the average Emergency Department score, the average Surgical Care Improvement score, the average Children’s Asthma scores, the average Heart Failure scores, the average Stroke Care score and the average Pneumonia score with the average Preventive score table.
DROP TABLE JOIN6;
CREATE TABLE JOIN6 AS
SELECT PREV_AVG.hospital_name, PREV_AVG.prev_avg_score, JOIN5.emr_avg_score, JOIN5.sci_avg_score, JOIN5.asth_avg_score, JOIN5.hf_avg_score, JOIN5.sc_avg_score, JOIN5.pneu_avg_score
FROM PREV_AVG
INNER JOIN JOIN5
ON JOIN5.hospital_name = PREV_AVG.hospital_name;

--Joining the table with the average Emergency Department score, the average Surgical Care Improvement score, the average Children’s Asthma scores, the average Heart Failure scores, the average Stroke Care score, the average Pneumonia score and the average Preventive score with the average Blood Clot Prevention and Treatment score table.
DROP TABLE JOIN7;
CREATE TABLE JOIN7 AS
SELECT BC_AVG.hospital_name, BC_AVG.bc_avg_score, JOIN6.emr_avg_score, JOIN6.sci_avg_score, JOIN6.asth_avg_score, JOIN6.hf_avg_score, JOIN6.sc_avg_score, JOIN6.pneu_avg_score, JOIN6.prev_avg_score
FROM BC_AVG
INNER JOIN JOIN6
ON JOIN6.hospital_name = BC_AVG.hospital_name;

--Joining the table with the average Emergency Department score, the average Surgical Care Improvement score, the average Children’s Asthma scores, the average Heart Failure scores, the average Stroke Care score, the average Pneumonia score, the average Preventive score and the average Blood Clot Prevention and Treatment score with the average Heart Attack or Chest Pain score table.
DROP TABLE JOIN8;
CREATE TABLE JOIN8 AS
SELECT HEART_AVG.hospital_name, HEART_AVG.heart_avg_score, JOIN7.emr_avg_score, JOIN7.sci_avg_score, JOIN7.asth_avg_score, JOIN7.hf_avg_score, JOIN7.sc_avg_score, JOIN7.pneu_avg_score, JOIN7.prev_avg_score, JOIN7.BC_avg_score
FROM HEART_AVG
INNER JOIN JOIN7
ON JOIN7.hospital_name = HEART_AVG.hospital_name;

--Joining the table with the average Emergency Department score, the average Surgical Care Improvement score, the average Children’s Asthma scores, the average Heart Failure scores, the average Stroke Care score, the average Pneumonia score, the average Preventive score, the average Blood Clot Prevention and Treatment score, the average Heart Attack or Chest Pain score with the average Pregnancy and Delivery score table.
DROP TABLE JOIN9;
CREATE TABLE JOIN9 AS
SELECT PREG_AVG.hospital_name, PREG_AVG.preg_avg_score, JOIN8.emr_avg_score, JOIN8.sci_avg_score, JOIN8.asth_avg_score, JOIN8.hf_avg_score, JOIN8.sc_avg_score, JOIN8.pneu_avg_score, JOIN8.prev_avg_score, JOIN8.BC_avg_score, JOIN8.heart_avg_score
FROM PREG_AVG
INNER JOIN JOIN8
ON JOIN8.hospital_name = PREG_AVG.hospital_name;

--Creating a table THAT ranks each of the first five columns from the table with all the average scores above (JOIN9) - average Emergency Department score, the average Surgical Care Improvement score, the average Children’s Asthma scores, the average Heart Failure scores and the average Stroke Care score.
DROP TABLE TIME_1ST5_RANK;
CREATE TABLE TIME_1ST5_RANK AS
SELECT hospital_name,
RANK() OVER (ORDER BY emr_avg_score DESC) AS emr_rank,
RANK() OVER (ORDER BY sci_avg_score DESC) AS sci_rank,
RANK() OVER (ORDER BY asth_avg_score DESC) AS asth_rank,
RANK() OVER (ORDER BY hf_avg_score DESC) AS hf_rank,
RANK() OVER (ORDER BY sc_avg_score DESC) AS sc_rank
FROM JOIN9;

-- Creating a table that ranks each of the last five columns from the table with all the average scores above (JOIN9) - average Pneumonia score, the average Preventive score, the average Blood Clot Prevention and Treatment score, the average Heart Attack or Chest Pain and the Pregnancy and Delivery Score table.
DROP TABLE TIME_2ND5_RANK;
CREATE TABLE TIME_2ND5_RANK AS
SELECT hospital_name,
RANK() OVER (ORDER BY pneu_avg_score DESC) AS pneu_rank,
RANK() OVER (ORDER BY prev_avg_score DESC) AS prev_rank,
RANK() OVER (ORDER BY BC_avg_score DESC) AS BC_rank,
RANK() OVER (ORDER BY heart_avg_score DESC) AS heart_rank,
RANK() OVER (ORDER BY preg_avg_score DESC) AS preg_rank
FROM JOIN9;

--Joining the two tables with the average scores ranked in each column.
DROP TABLE TIME_EFEC_TOT;
CREATE TABLE TIME_EFEC_TOT AS
SELECT TIME_1ST5_RANK.hospital_name, TIME_1ST5_RANK.emr_rank, TIME_1ST5_RANK.sci_rank, TIME_1ST5_RANK.asth_rank, TIME_1ST5_RANK.hf_rank, TIME_1ST5_RANK.sc_rank, TIME_2ND5_RANK.pneu_rank, TIME_2ND5_RANK.prev_rank, TIME_2ND5_RANK.BC_rank, TIME_2ND5_RANK.heart_rank, TIME_2ND5_RANK.preg_rank
FROM TIME_1ST5_RANK
INNER JOIN TIME_2ND5_RANK
ON TIME_1ST5_RANK.hospital_name = TIME_2ND5_RANK.hospital_name;

--Finding the average rank of conditions across each hospital in order to find the best hospitals.
DROP TABLE EFFEC_FIN;
CREATE TABLE EFFEC_FIN AS
SELECT hospital_name, emr_rank, sci_rank, asth_rank, hf_rank, sc_rank, pneu_rank, prev_rank, BC_rank, heart_rank, preg_rank,
(emr_rank + sci_rank + asth_rank + hf_rank + sc_rank + pneu_rank + prev_rank + BC_rank + heart_rank + preg_rank)/10 AS test_avg
FROM TIME_EFEC_TOT
ORDER BY test_avg ASC;

--Finding the average overall score for all measures by hospital from the Readmissions and Deaths table.
DROP TABLE READ_AVG;
CREATE TABLE READ_AVG AS
SELECT hospital_name, AVG(score) AS read_avg_score FROM ER_read_deaths
GROUP BY hospital_name
ORDER BY read_avg_score DESC;

--Joining the average score from the Readmissions and Deaths table with the table which contains the average rank of conditions across each hospital to ensure that the ranks from the Timely and Effective Care table are consistent with the Readmissions and Deaths scores.
DROP TABLE HOSP_QUAL_JOINS;
CREATE TABLE HOSP_QUAL_JOINS AS
SELECT EFFEC_FIN.hospital_name, EFFEC_FIN.test_avg, READ_AVG.read_avg_score
FROM EFFEC_FIN
INNER JOIN READ_AVG
ON EFFEC_FIN.hospital_name = READ_AVG.hospital_name
ORDER BY EFFEC_FIN.test_avg;

--The top 10 hospitals ordered by ranking. This table also includes the average score for each of the hospital from the Readmissions and Deaths table.
SELECT * FROM HOSP_QUAL_JOINS LIMIT 10;
