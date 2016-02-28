--Creating a table that takes the average scores for the condition “Emergency Department” in each state and sorts the states by these average scores in descending order.
DROP TABLE SEMR_AVG;
CREATE TABLE SEMR_AVG AS
SELECT state, AVG(score) AS emr_avg_score FROM ER_time_effec WHERE condition = 'Emergency Department'
GROUP BY state
ORDER BY emr_avg_score DESC;

--Creating a table that takes the average scores for the condition “Surgical Care Improvement” in each state and sorts the states by these average scores in descending order.
DROP TABLE SSCI_AVG;
CREATE TABLE SSCI_AVG AS
SELECT state, AVG(score) AS sci_avg_score FROM ER_time_effec WHERE condition = 'Surgical Care Improvement Project'
GROUP BY state
ORDER BY sci_avg_score DESC;

--Creating a table that takes the average scores for the condition “Children’s Asthma” in each state and sorts the states by these average scores in descending order.
DROP TABLE SASTH_AVG;
CREATE TABLE SASTH_AVG AS
SELECT state, AVG(score) AS asth_avg_score FROM ER_time_effec WHERE meas_id = 'CAC_3'
GROUP BY state
ORDER BY asth_avg_score DESC;

--Creating a table that takes the average scores for the condition “Heart Failure” in each state and sorts the states by these average scores in descending order.
DROP TABLE SHF_AVG;
CREATE TABLE SHF_AVG AS
SELECT state, AVG(score) AS hf_avg_score FROM ER_time_effec WHERE condition = 'Heart Failure'
GROUP BY state
ORDER BY hf_avg_score DESC;

--Creating a table that takes the average scores for the condition “Stroke Care” in each state and sorts the states by these average scores in descending order.
DROP TABLE SSC_AVG;
CREATE TABLE SSC_AVG AS
SELECT state, AVG(score) AS sc_avg_score FROM ER_time_effec WHERE condition = 'Stroke Care'
GROUP BY state
ORDER BY sc_avg_score DESC;

--Creating a table that takes the average scores for the condition “Pneumonia” in each state and sorts the states by these average scores in descending order.
DROP TABLE SPNEU_AVG;
CREATE TABLE SPNEU_AVG AS
SELECT state, AVG(score) AS pneu_avg_score FROM ER_time_effec WHERE condition = 'Pneumonia'
GROUP BY state
ORDER BY pneu_avg_score DESC;

--Creating a table that takes the average scores for the condition “Preventive Care” in each state and sorts the states by these average scores in descending order.
DROP TABLE SPREV_AVG;
CREATE TABLE SPREV_AVG AS
SELECT state, AVG(score) AS prev_avg_score FROM ER_time_effec WHERE condition = 'Preventive Care'
GROUP BY state
ORDER BY prev_avg_score DESC;

--Creating a table that takes the average scores for the condition “Blood Clot Prevention and Treatment” in each state and sorts the states by these average scores in descending order.
DROP TABLE SBC_AVG;
CREATE TABLE SBC_AVG AS
SELECT state, AVG(score) AS bc_avg_score FROM ER_time_effec WHERE condition = 'Blood Clot Prevention and Treatment'
GROUP BY state
ORDER BY bc_avg_score DESC;

--Creating a table that takes the average scores for the condition “Heart Attack or Chest Pain” at each state and sorts the states by these average scores in descending order.
DROP TABLE SHEART_AVG;
CREATE TABLE SHEART_AVG AS
SELECT state, AVG(score) AS heart_avg_score FROM ER_time_effec WHERE condition = 'Heart Attack or Chest Pain'
GROUP BY state
ORDER BY heart_avg_score DESC;

--Creating a table that takes the average scores for the condition “Pregnancy and Delivery Care” at each state and sorts the states by these average scores in descending order.
DROP TABLE SPREG_AVG;
CREATE TABLE SPREG_AVG AS
SELECT state, AVG(score) AS preg_avg_score FROM ER_time_effec WHERE condition = 'Pregnancy and Delivery Care'
GROUP BY state
ORDER BY preg_avg_score DESC;

--Joining the table with the average Emergency Department score by state with the average Surgical Care Improvement score by state.
DROP TABLE SJOIN1;
CREATE TABLE SJOIN1 AS
SELECT SEMR_AVG.state, SEMR_AVG.emr_avg_score, SSCI_AVG.sci_avg_score
FROM SEMR_AVG
INNER JOIN SSCI_AVG
ON SEMR_AVG.state = SSCI_AVG.state;

--Joining the table with the average Emergency Department score and the average Surgical Care Improvement score by state with the average Children’s Asthma Scores by state table.
DROP TABLE SJOIN2;
CREATE TABLE SJOIN2 AS
SELECT SASTH_AVG.state, SASTH_AVG.asth_avg_score, SJOIN1.emr_avg_score, SJOIN1.sci_avg_score
FROM SASTH_AVG
INNER JOIN SJOIN1
ON SJOIN1.state = SASTH_AVG.state;

--Joining the table with the average Emergency Department score, the average Surgical Care Improvement score, and the average Children’s Asthma scores by state with the table containing the average Heart Failure scores by state.
DROP TABLE SJOIN3;
CREATE TABLE SJOIN3 AS
SELECT SHF_AVG.state, SHF_AVG.hf_avg_score, SJOIN2.emr_avg_score, SJOIN2.sci_avg_score, SJOIN2.asth_avg_score
FROM SHF_AVG
INNER JOIN SJOIN2
ON SJOIN2.state = SHF_AVG.state;

--Joining the table with the average Emergency Department score, the average Surgical Care Improvement score, the average Children’s Asthma scores, and the average Heart Failure scores by state with the average Stroke Care score by state table.
DROP TABLE SJOIN4;
CREATE TABLE SJOIN4 AS
SELECT SSC_AVG.state, SSC_AVG.sc_avg_score, SJOIN3.emr_avg_score, SJOIN3.sci_avg_score, SJOIN3.asth_avg_score, SJOIN3.hf_avg_score
FROM SSC_AVG
INNER JOIN SJOIN3
ON SJOIN3.state = SSC_AVG.state;

--Joining the table with the average Emergency Department score, the average Surgical Care Improvement score, the average Children’s Asthma scores, the average Heart Failure scores and the average Stroke Care score by state table with the average Pneumonia score by state table.
DROP TABLE SJOIN5;
CREATE TABLE SJOIN5 AS
SELECT SPNEU_AVG.state, SPNEU_AVG.pneu_avg_score, SJOIN4.emr_avg_score, SJOIN4.sci_avg_score, SJOIN4.asth_avg_score, SJOIN4.hf_avg_score, SJOIN4.sc_avg_score
FROM SPNEU_AVG
INNER JOIN SJOIN4
ON SJOIN4.state = SPNEU_AVG.state;

--Joining the table with the average Emergency Department score, the average Surgical Care Improvement score, the average Children’s Asthma scores, the average Heart Failure scores, the average Stroke Care score and the average Pneumonia score with the average Preventive score by state table.
DROP TABLE SJOIN6;
CREATE TABLE SJOIN6 AS
SELECT SPREV_AVG.state, SPREV_AVG.prev_avg_score, SJOIN5.emr_avg_score, SJOIN5.sci_avg_score, SJOIN5.asth_avg_score, SJOIN5.hf_avg_score, SJOIN5.sc_avg_score, SJOIN5.pneu_avg_score
FROM SPREV_AVG
INNER JOIN SJOIN5
ON SJOIN5.state = SPREV_AVG.state;

--Joining the table with the average Emergency Department score, the average Surgical Care Improvement score, the average Children’s Asthma scores, the average Heart Failure scores, the average Stroke Care score, the average Pneumonia score and the average Preventive score with the average Blood Clot Prevention and Treatment score by state table.
DROP TABLE SJOIN7;
CREATE TABLE SJOIN7 AS
SELECT SBC_AVG.state, SBC_AVG.bc_avg_score, SJOIN6.emr_avg_score, SJOIN6.sci_avg_score, SJOIN6.asth_avg_score, SJOIN6.hf_avg_score, SJOIN6.sc_avg_score, SJOIN6.pneu_avg_score, SJOIN6.prev_avg_score
FROM SBC_AVG
INNER JOIN SJOIN6
ON SJOIN6.state = SBC_AVG.state;

--Joining the table with the average Emergency Department score, the average Surgical Care Improvement score, the average Children’s Asthma scores, the average Heart Failure scores, the average Stroke Care score, the average Pneumonia score, the average Preventive score and the average Blood Clot Prevention and Treatment score with the average Heart Attack or Chest Pain score by state table.
DROP TABLE SJOIN8;
CREATE TABLE SJOIN8 AS
SELECT SHEART_AVG.state, SHEART_AVG.heart_avg_score, SJOIN7.emr_avg_score, SJOIN7.sci_avg_score, SJOIN7.asth_avg_score, SJOIN7.hf_avg_score, SJOIN7.sc_avg_score, SJOIN7.pneu_avg_score, SJOIN7.prev_avg_score, SJOIN7.BC_avg_score
FROM SHEART_AVG
INNER JOIN SJOIN7
ON SJOIN7.state = SHEART_AVG.state;

--Joining the table with the average Emergency Department score, the average Surgical Care Improvement score, the average Children’s Asthma scores, the average Heart Failure scores, the average Stroke Care score, the average Pneumonia score, the average Preventive score, the average Blood Clot Prevention and Treatment score, the average Heart Attack or Chest Pain score with the average Pregnancy and Delivery score by state table.
DROP TABLE SJOIN9;
CREATE TABLE SJOIN9 AS
SELECT SPREG_AVG.state, SPREG_AVG.preg_avg_score, SJOIN8.emr_avg_score, SJOIN8.sci_avg_score, SJOIN8.asth_avg_score, SJOIN8.hf_avg_score, SJOIN8.sc_avg_score, SJOIN8.pneu_avg_score, SJOIN8.prev_avg_score, SJOIN8.BC_avg_score, SJOIN8.heart_avg_score
FROM SPREG_AVG
INNER JOIN SJOIN8
ON SJOIN8.state = SPREG_AVG.state;

--Creating a table THAT ranks each of the first five columns from the table with all the average scores above (SJOIN9) - average Emergency Department score, the average Surgical Care Improvement score, the average Children’s Asthma scores, the average Heart Failure scores and the average Stroke Care score.
DROP TABLE STIME_1ST5_RANK;
CREATE TABLE STIME_1ST5_RANK AS
SELECT state,
RANK() OVER (ORDER BY emr_avg_score DESC) AS emr_rank,
RANK() OVER (ORDER BY sci_avg_score DESC) AS sci_rank,
RANK() OVER (ORDER BY asth_avg_score DESC) AS asth_rank,
RANK() OVER (ORDER BY hf_avg_score DESC) AS hf_rank,
RANK() OVER (ORDER BY sc_avg_score DESC) AS sc_rank
FROM SJOIN9;

-- Creating a table that ranks each of the second five columns from the table with all the average scores above (SJOIN9) - average Pneumonia score, the average Preventive score, the average Blood Clot Prevention and Treatment score, the average Heart Attack or Chest Pain and the Pregnancy and Delivery Score table.
DROP TABLE STIME_2ND5_RANK;
CREATE TABLE STIME_2ND5_RANK AS
SELECT state,
RANK() OVER (ORDER BY pneu_avg_score DESC) AS pneu_rank,
RANK() OVER (ORDER BY prev_avg_score DESC) AS prev_rank,
RANK() OVER (ORDER BY BC_avg_score DESC) AS BC_rank,
RANK() OVER (ORDER BY heart_avg_score DESC) AS heart_rank,
RANK() OVER (ORDER BY preg_avg_score DESC) AS preg_rank
FROM SJOIN9;

--Joining the two table with the average scores ranked in each column.
DROP TABLE STIME_EFEC_TOT;
CREATE TABLE STIME_EFEC_TOT AS
SELECT STIME_1ST5_RANK.state, STIME_1ST5_RANK.emr_rank, STIME_1ST5_RANK.sci_rank, STIME_1ST5_RANK.asth_rank, STIME_1ST5_RANK.hf_rank, STIME_1ST5_RANK.sc_rank, STIME_2ND5_RANK.pneu_rank, STIME_2ND5_RANK.prev_rank, STIME_2ND5_RANK.BC_rank, STIME_2ND5_RANK.heart_rank, STIME_2ND5_RANK.preg_rank
FROM STIME_1ST5_RANK
INNER JOIN STIME_2ND5_RANK
ON STIME_1ST5_RANK.state = STIME_2ND5_RANK.state;

--Finding the average rank of conditions across each state in order to find the best states.
DROP TABLE SEFFEC_FIN;
CREATE TABLE SEFFEC_FIN AS
SELECT state, emr_rank, sci_rank, asth_rank, hf_rank, sc_rank, pneu_rank, prev_rank, BC_rank, heart_rank, preg_rank,
(emr_rank + sci_rank + asth_rank + hf_rank + sc_rank + pneu_rank + prev_rank + BC_rank + heart_rank + preg_rank)/10 AS test_avg
FROM STIME_EFEC_TOT
ORDER BY test_avg ASC;

--Finding the average overall score for all measures by state from the Readmissions and Deaths table.
DROP TABLE SREAD_AVG;
CREATE TABLE SREAD_AVG AS
SELECT state, AVG(score) AS read_avg_score FROM ER_read_deaths
GROUP BY state
ORDER BY read_avg_score DESC;

--Joining the average score from the Readmissions and Deaths table with the table which contains the average rank of conditions across each state to ensure that the ranks from the Timely and Effective Care table are consistent with the Readmissions and Deaths scores.
DROP TABLE SHOSP_QUAL_JOINS;
CREATE TABLE SHOSP_QUAL_JOINS AS
SELECT SEFFEC_FIN.state, SEFFEC_FIN.test_avg, SREAD_AVG.read_avg_score
FROM SEFFEC_FIN
INNER JOIN SREAD_AVG
ON SEFFEC_FIN.state = SREAD_AVG.state
ORDER BY SEFFEC_FIN.test_avg;

--The top 10 states ordered by ranking. This table also includes the average score for each of the states from the Readmissions and Deaths table.
SELECT * FROM SHOSP_QUAL_JOINS LIMIT 10;
