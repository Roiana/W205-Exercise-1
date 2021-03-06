#Downloading the Hospital Compare zip files
wget -O hosp.zip https://data.medicare.gov/views/bg9k-emty/files/Nqcy71p9Ss2RSBWDmP77H1DQXcyacr2khotGbDHHW_s?content_type=application%2Fzip%3B%20charset%3Dbinary&filename=Hospital_Revised_Flatfiles.zip

#Unzipping the Hospital Compare zip files
unzip hosp.zip

#Renaming the files to eliminate the spaces in the file names
tail -n+2 "Hospital General Information.csv" > "hospitals.csv"
tail -n+2 "Timely and Effective Care - Hospital.csv" > "effective_care.csv"
tail -n+2 "Readmissions and Deaths - Hospital.csv" > "readmissions.csv"
tail -n+2 "Measure Dates.csv" > "Measures.csv"
tail -n+2 "hvbp_hcahps_05_28_2015.csv" > "surveys_responses.csv"

#Creating a file in the w205 folder called hospital_compare
hdfs dfs -mkdir /user/w205/hospital_compare

#Creating a folder for each of the five files
hdfs dfs -mkdir /user/w205/hospital_compare/hosp_gen
hdfs dfs -mkdir /user/w205/hospital_compare/time_effec
hdfs dfs -mkdir /user/w205/hospital_compare/read_deaths
hdfs dfs -mkdir /user/w205/hospital_compare/meas_dates
hdfs dfs -mkdir /user/w205/hospital_compare/surv_resp

#Loading the renamed files into the five HDFS folders created above
hdfs dfs -put hospitals.csv /user/w205/hospital_compare/hosp_gen
hdfs dfs -put effective_care.csv /user/w205/hospital_compare/time_effec
hdfs dfs -put readmissions.csv /user/w205/hospital_compare/read_deaths
hdfs dfs -put Measures.csv /user/w205/hospital_compare/meas_dates
hdfs dfs -put surveys_responses.csv /user/w205/hospital_compare/surv_resp
