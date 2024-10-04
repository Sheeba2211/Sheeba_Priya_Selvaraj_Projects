--list all the users in the DB.
select usesysid as user_id,
       usename as username,
       usesuper as is_superuser,
       passwd as password_md5,
       valuntil as password_expiration
from pg_shadow
order by usename;

--patients names who have the same last name.
SELECT "Firstname", "Lastname" FROM
(SELECT "Firstname", "Lastname",
count(*) over (partition by "Lastname") AS name_count
FROM "Patients" ) nc
WHERE name_count >1;

-- the tables where column Patient_ID is present
SELECT ordinal_position,t.table_name
FROM information_schema.tables t
INNER JOIN information_schema.columns c ON c.table_name = t.table_name 
WHERE c.column_name = 'Patient_ID';

--the first name and Last name of patients whose Race is Latino.
SELECT CONCAT(p."Firstname",'  ', p."Lastname") AS patient_fullname,r."Race" 
FROM "Patients" p
JOIN "Race" r
ON p."Race_ID"=r."Race_ID"
WHERE "Race"='Latino';

--birth year ranges using common table expressions and case statements
WITH BYR AS (
	SELECT "Patient_ID", "Firstname"||' '|| "Lastname" AS "Patient_Name",
	(EXTRACT(YEAR FROM "Visit_Date")- "Age") AS "Birth_Year"
	FROM "Patients")  -- Birth_Year: MIN 1928, MAX 1955

SELECT "Patient_ID", "Patient_Name", "Birth_Year",  
	CASE WHEN "Birth_Year" BETWEEN 1925 AND 1930 THEN '1925-1930'
		WHEN  "Birth_Year" BETWEEN 1931 AND 1935 THEN '1931-1935'
		WHEN  "Birth_Year" BETWEEN 1936 AND 1940 THEN '1936-1940'
		WHEN  "Birth_Year" BETWEEN 1941 AND 1945 THEN '1941-1945'
		WHEN  "Birth_Year" BETWEEN 1946 AND 1950 THEN '1946-1950'
		WHEN  "Birth_Year" BETWEEN 1951 AND 1955 THEN '1951-1955'
	END AS "Birth_Year_Range"
   FROM BYR;
   
--Calculating the patient's current age
SELECT "Patient_ID", CONCAT("Firstname",' ',"Lastname") AS "Patient_Name", "Visit_Date", "Age",
(EXTRACT( YEAR FROM AGE(CURRENT_DATE,"Visit_Date"))+"Age") AS "Current_Age" FROM "Patients";

--get a patient name who has a chance to have kidney disease with Albumin.
SELECT u."Urine_ID", CONCAT( p."Firstname",' ', p."Lastname") AS "Patient_Name", u."Albumin"
FROM "Urine_Test" u
INNER JOIN "Link_Reference" l USING ("Urine_ID")
INNER JOIN "Patients" p USING ("Link_Reference_ID")
WHERE u."Albumin" < 3.4 OR u."Albumin" > 5.4;
			 --Alternate query using uCAR
SELECT "Urine_ID","Patient_Name", "Albumin", "Creatinine", "uCAR" FROM
(SELECT u."Urine_ID", CONCAT( p."Firstname",' ', p."Lastname") AS "Patient_Name", u."Albumin",u."Creatinine", round ("Albumin"/("Creatinine"*0.001))::INTEGER AS "uCAR"
FROM "Urine_Test" u
INNER JOIN "Link_Reference" l
ON u."Urine_ID" = l."Urine_ID"
INNER JOIN "Patients" p
ON l."Link_Reference_ID" = p."Link_Reference_ID") as uc
WHERE "uCAR">=30;

--patient's name who has a max speed.
SELECT w."Patient_ID", CONCAT( p."Firstname",' ', p."Lastname") AS "Patient_Name", 
w."Gait_DT_Speed" AS "Max_Gait_DT_Speed"
FROM "Walking_Test" w
INNER JOIN "Patients" p
ON w."Patient_ID" = p."Patient_ID"
WHERE w."Gait_DT_Speed" = (select MAX("Gait_DT_Speed") from "Walking_Test");

--the percentage of Lab visits by Lab names.
SELECT "Lab_names", 
round(COUNT(*)*100 / SUM(COUNT(*)) OVER(),2) AS "Percentage_of_Visits"
FROM "Lab_Visit"
GROUP BY "Lab_names";

--materialized view with no data, to display no of male and female patients. 
CREATE MATERIALIZED VIEW IF NOT EXISTS gender_count_mview AS 
	SELECT "Gender", COUNT("Patient_ID")
	FROM "Patients" 
	JOIN "Gender" USING ("Gender_ID")
	GROUP BY "Gender"
WITH NO DATA;

SELECT * FROM gender_count_mview; –--returns ERROR 

			--— Refresh gender_count_mview  to get data:
REFRESH MATERIALIZED VIEW gender_count_mview; 

			--REFRESH MATERIALIZED VIEW CONCURRENTLY gender_count_mview;

SELECT * FROM gender_count_mview;

--create an Index on table Verbal_Cognitive by selecting a column and also write the query drop the same index.
CREATE INDEX "Verbal_PS"
    ON public."Verbal_Cognitive" ("Patient_ID","DS")
    TABLESPACE pg_default;
	
DROP INDEX "Verbal_PS";

-- race having the maximum number of Diabetic patients.
SELECT "Race", COUNT("Patients"."Patient_ID") AS number_of_diabetic_patients FROM "Patients" 
JOIN "Link_Reference" USING ("Link_Reference_ID")
JOIN "Lab_Test" USING ("Lab_ID")
JOIN "Race" USING ("Race_ID")
WHERE "Hb_A1C" >= 6.5 OR "Fasting_Glucose" >= 120
GROUP BY "Race"
ORDER BY number_of_diabetic_patients DESC 
LIMIT 1;

--patient who has the most damage in the eyes
WITH opth AS ( SELECT op."Opthal_ID" FROM "Opthalmology" AS op
 WHERE "Diabetic_Retinopathy" IN (
 SELECT MAX("Diabetic_Retinopathy") FROM "Opthalmology"))
SELECT pt."Firstname" || ' ' || pt."Lastname" AS "full_name" from "Patients" AS pt 
 INNER JOIN opth on opth."Opthal_ID" = pt."Opthal_ID"

--patient count by Gender and Race combination.
SELECT "Gender", "Race", COUNT(*) AS "PatientCount" 
FROM "Patients"
INNER JOIN "Gender" USING ("Gender_ID")
INNER JOIN "Race" USING ("Race_ID")
GROUP BY "Race", "Gender"
ORDER BY "PatientCount" DESC;

-- 10 random DM patients
SELECT "Firstname"||' '||"Lastname" AS "Patient_Name" FROM "Patients" pt 
INNER JOIN "Group" gp USING ("Group_ID")
WHERE gp."Group" = 'DM'
ORDER BY random() LIMIT 10;

--list of Patient IDs and their Group whose diabetes duration is greater than 10 years.
SELECT "Patient_ID","Group" 
FROM "Patients" as pt
INNER JOIN "Group" as gp USING ("Group_ID")
WHERE "Diabetes_Duration" >10;

--the number of patients above age 50 in each group.
SELECT count("Patient_ID") as No_of_Patients,"Group"
FROM public."Patients" as p
inner join public."Group" as g USING ("Group_ID")
where p."Age" > 50
group by "Group";

--the number of patients visited each month.
SELECT TO_CHAR(p."Visit_Date",'Month') as "Month_name",
COUNT("Patient_ID") AS "NO_OF_PATIENTS"
FROM public."Patients" AS p
GROUP by "Month_name",EXTRACT(Month FROM p."Visit_Date")
ORDER BY EXTRACT(Month FROM p."Visit_Date");

-- list male patient ids and their names who are above 40 years of age and less than 60 years 
-----and have Day BloodPressureSystolic above 120 and Day BloodPressureDiastolic above 80.
SELECT pt."Patient_ID",pt."Firstname",pt."Lastname"
FROM "Patients" AS pt 
INNER JOIN "Blood_Pressure" AS bp USING ("Patient_ID")
INNER JOIN "Gender" AS g USING ("Gender_ID")
WHERE ("Gender" like 'Male') AND ("Age">40 AND "Age"<60) 
	AND ("24Hr_Day_SBP">120 AND "24Hr_Day_DBP">80);
	
--the number of patients whose urine creatinine is in a normal range (Gender wise).
SELECT "Gender", count(*) AS "Count_with_Normal_Creatinine"
FROM "Patients" p
INNER JOIN "Link_Reference" l
ON p."Link_Reference_ID" = l."Link_Reference_ID"
INNER JOIN "Urine_Test" u USING ("Urine_ID")
INNER JOIN "Gender" g USING ("Gender_ID")
WHERE ("Creatinine" BETWEEN 65.4 AND 119.3 AND "Gender"='Male') 
OR ("Creatinine" BETWEEN 52.2 AND 91.9 AND "Gender"='Female')
GROUP BY "Gender";

--list of female patients who are at risk of heart diseases with the help of Fasting HDL.
SELECT p."Firstname"||' '|| p."Lastname" AS "Patient_Name","Fasting_HDL",g."Gender"
FROM public."Patients" AS p
INNER JOIN public."Lipid_Lab_Test" AS llt
ON p."Patient_ID"=llt."Patient_ID"
INNER JOIN public."Gender" AS g
ON g."Gender_ID"=p."Gender_ID"
WHERE g."Gender"= 'Female' AND "Fasting_HDL" < 50;

--the Number of Diabetic Male and Female patients who are Anemic.
SELECT  "Gender",
		COUNT(CASE WHEN ("Hgb" NOT BETWEEN 13.2 AND 16.6) AND "Gender" = 'Male' THEN '1' 
			 WHEN ("Hgb" NOT BETWEEN 11.6 AND 15) AND "Gender" = 'Female' THEN '1'
		END) AS no_of_anemic_patients
FROM "Lab_Test"  
JOIN "Link_Reference" USING ("Lab_ID")
JOIN "Patients" USING ("Link_Reference_ID")
JOIN "Gender" USING ("Gender_ID")
GROUP BY "Gender";

--the number of patients who visited each lab using the windows function.
SELECT DISTINCT "Lab_names",
	COUNT(*) OVER (PARTITION BY "Lab_names") 
			AS Number_of_Patients
FROM "Patients" 
JOIN "Link_Reference" USING ("Link_Reference_ID")
JOIN "Lab_Visit" USING ("Lab_visit_ID")
ORDER BY "Lab_names" ;


--list of patients whose RPE start is at moderate intensity
SELECT "Firstname" || ' ' || "Lastname" AS "Fullname" FROM "Patients" AS pt
INNER JOIN "Walking_Test" AS wt USING ("WalkTest_ID")
WHERE wt."Gait_RPE_Start " BETWEEN 4 AND 6;

--list of patients who are memory cognitively impaired with the GDS test and whose diabetes duration is between 5 to 30.
SELECT "Patients"."Patient_ID", CONCAT("Firstname", ' ', "Lastname") AS "Patient_Name", 
		"GDS", "Diabetes_Duration"
   FROM "Patients" 
JOIN "Link_Reference"  USING ("Link_Reference_ID")
JOIN  "Memory_Cognitive" USING ("MC_ID")
WHERE "GDS" >= 15 
	AND "Diabetes_Duration" BETWEEN 5 AND 30;

--difference between Day and night HR.
SELECT "24Hr_Day_HR", "24Hr_Night_HR", round(cast("24Hr_Day_HR" - "24Hr_Night_HR" as numeric),2)
AS day_night_difference
FROM "Blood_Pressure";

-- split the lab visit date into two different columns lab_visit_date  and lab_visit_time.
SELECT "Lab_visit_ID", DATE("Lab_Visit_Date") AS "Lab_Visit_Date", 
(CAST ("Lab_Visit_Date" AS TIME )) AS "Lab_Visit_Time" 
FROM "Lab_Visit";

--DM patient names with highest day MAP and night MAP (without using limit).
WITH MAP AS                                                  -- get MAP values for patients
	(SELECT "BP_ID", pt."Patient_ID", pt."Firstname"||' '||pt."Lastname" AS "Patient_Name",
		(1/3*("24Hr_Day_SBP"-"24Hr_Day_DBP")+"24Hr_Day_DBP") AS "24Hr_Day_MAP",
		(1/3*("24Hr_Night_SBP"-"24Hr_Night_DBP")+"24Hr_Night_DBP") AS "24Hr_Night_MAP"
	FROM "Blood_Pressure"
	JOIN "Patients"pt USING ("BP_ID")
	JOIN "Group" gp USING ("Group_ID")
	WHERE gp."Group" = 'DM'), 
	
MxMAP AS                                                    -- get day max and night max values
	(SELECT MAX("24Hr_Day_MAP") AS "Max_24Hr_Day_MAP", MAX("24Hr_Night_MAP") AS "Max_24Hr_Night_MAP"
	FROM MAP)

SELECT "Patient_Max_Day_Map", "Patient_Max_Night_Map" FROM
(SELECT "Patient_ID", "Patient_Name" AS "Patient_Max_Day_Map" FROM MAP, MxMAP WHERE "24Hr_Day_MAP" = "Max_24Hr_Day_MAP") day
JOIN ( SELECT  "Patient_ID", "Patient_Name" AS "Patient_Max_Night_Map" 
FROM MAP, MxMAP  WHERE "24Hr_Night_MAP" = "Max_24Hr_Night_MAP") night USING ("Patient_ID");

-- the number of visual/motor dementia patients who have any 2 abnormal conditions.
SELECT 
SUM(CASE WHEN vm."RCFT_IR">71 AND vm."TM">=42 THEN 1 END) AS "RCFT_AND_TM",
	 COALESCE(SUM (CASE WHEN vm."RCFT_IR">71 AND vm."Clock"<=2 THEN 1 END),0) AS "RCFT_AND_Clock",
	 COALESCE(SUM (CASE WHEN vm."TM">=42 AND vm."Clock"<=2 THEN 1 END),0) AS "TM_AND_Clock"
FROM "Patients" p
JOIN "Link_Reference" lr ON p."Link_Reference_ID"=lr."Link_Reference_ID"
JOIN "Visual/Motor_Cog" vm ON lr."VM_ID"=vm."VM_ID";

-- Patient IDs for verbally cognitively impaired who satisfy any 2 conditions. 
WITH Verb AS (
	SELECT "Patients"."Patient_ID", 
   (COALESCE(CASE WHEN "HVLT" < 14 AND "VF" < 42  THEN TRUE END , FALSE)) AS "HVLT_VF",
	 COALESCE(CASE WHEN "HVLT" < 14 AND "WTAR" <= 20  THEN TRUE END, FALSE) AS "HVLT_WTAR",
	 COALESCE(CASE WHEN "VF" < 42 AND "WTAR" <= 20 THEN TRUE END, FALSE) AS "VF_WTAR"
FROM "Patients" 
JOIN "Link_Reference" USING ("Link_Reference_ID")
JOIN "Verbal_Cognitive" USING("VC_ID")
) 
SELECT * FROM Verb 
WHERE "HVLT_VF" =TRUE OR "HVLT_WTAR" = TRUE OR "VF_WTAR" = TRUE; 


--Creating view on table Lab Test
CREATE VIEW Diabetic_Patient AS
SELECT "Lab_ID","Patient_ID","Hb_A1C","Fasting_Glucose","Insulin" FROM public."Lab_Test"
WHERE "Hb_A1C" > 6.5 AND "Fasting_Glucose" >126;

--the number of patients in the year 2005 in each of the Genesis and Cultivate labs.
SELECT lv."Lab_names", COUNT("Patient_ID") FROM "Patients"
JOIN "Link_Reference" AS lr USING ("Link_Reference_ID")
JOIN "Lab_Visit" AS lv USING ("Lab_visit_ID")  
WHERE lv."Lab_names" IN ('Genesis Lab','Cultivate Lab') AND EXTRACT(YEAR FROM lv."Lab_Visit_Date") = 2005
GROUP BY lv."Lab_names"

--Create an index on any table and use explain analyze to show differences if any.

  	--create a table to check differences of creating index using explain analyze 
CREATE TABLE patients (s_no INT, p_name VARCHAR(100));

INSERT INTO patients (s_no, p_name)
SELECT generate_series, LEFT (md5 (random()::text),100)
FROM generate_series (1,5000)
ORDER BY random ();

 	 -- Analyze Before Index	
EXPLAIN (ANALYZE) 
SELECT *
FROM patients  
WHERE s_no = 2500;

 	 --Create Index	
CREATE INDEX ind_pat ON patients (s_no);

 	-- Analyze After Index	
EXPLAIN (ANALYZE) 
SELECT *
FROM patients 
WHERE s_no = 2500;

 	 --Drop Index	
DROP INDEX ind_pat;

--calculate the percentage of patients according to the lab visited per month.
SELECT round(COUNT(*)*100 / SUM(COUNT(*)) OVER(),2)  AS "Percentage_Of_Patients",
lv."Lab_names",TO_CHAR(p."Visit_Date",'Month') as "Month"
FROM "Patients" AS p
INNER JOIN "Link_Reference" AS lr USING ("Link_Reference_ID")
INNER JOIN "Lab_Visit" AS lv USING ("Lab_visit_ID")
GROUP by lv."Lab_names","Month",EXTRACT(Month FROM p."Visit_Date")
ORDER BY lv."Lab_names",EXTRACT(Month FROM p."Visit_Date");

--list of patients whose lipid test value is null.
SELECT p."Firstname"||' '|| p."Lastname"
FROM "Patients" p
INNER JOIN "Lipid_Lab_Test" llt USING ("Patient_ID")
WHERE llt."Fasting_Triglyc" IS NULL
OR llt."Fasting_Cholestrol" IS NULL
OR llt."Fasting_HDL" IS NULL
OR llt."Fasting_LDL" IS NULL;

--patients that have eye damage due to diabetes.
SELECT "Firstname"||' '||"Lastname" AS Patient_Name,o."Diabetic_Retinopathy",o."Macular_Edema"
FROM "Patients" p
JOIN "Opthalmology" o USING ("Opthal_ID")
WHERE( o."Diabetic_Retinopathy" != 0
OR o."Macular_Edema" !=0) AND EXISTS (SELECT p1."Patient_ID" 
FROM "Patients" p1
JOIN "Link_Reference" USING ("Link_Reference_ID")
JOIN "Lab_Test" USING ("Lab_ID")
WHERE ( "Hb_A1C" >= 6.5 OR "Fasting_Glucose" >= 120) AND p."Patient_ID"=p1."Patient_ID") ;
						--Another Approach
SELECT "Firstname"||' '||"Lastname" AS Patient_Name,o."Diabetic_Retinopathy",o."Macular_Edema"
FROM "Patients" p
JOIN "Opthalmology" o USING ("Opthal_ID")
JOIN "Group" g USING ("Group_ID")
WHERE( o."Diabetic_Retinopathy" != 0
OR o."Macular_Edema" !=0) AND
g."Group" = 'DM'

--classifying Gait RPE End into 5 categories as per the intensity.
SELECT "Patient_ID","Gait_RPE_End ",
CASE
WHEN "Gait_RPE_End "=0 THEN 'REST'
WHEN "Gait_RPE_End ">0 AND "Gait_RPE_End "<=3 THEN 'EASY INTENSITY'
WHEN "Gait_RPE_End ">3 AND "Gait_RPE_End "<=6 THEN 'MODERATE INTENSITY'
WHEN "Gait_RPE_End ">6 AND "Gait_RPE_End "<=9 THEN 'HARD INTENSITY'
WHEN "Gait_RPE_End "=10 THEN 'MAX EFFORT INTENSITY'
END "Intensity_Level" FROM "Walking_Test";

-- DM patient names whose distance is greater than 400 and speed is greater than 1.
select w."Patient_ID","Firstname","Lastname", 
 "Gait_DT_Distance", "Gait_DT_Speed", "Group" from "Walking_Test" w
INNER JOIN "Patients" p USING ("Patient_ID")
INNER JOIN "Group" g USING ("Group_ID")
WHERE w."Gait_DT_Distance" >400 AND w."Gait_DT_Speed">1 AND g."Group" = 'DM';

-- stored procedure to make user ids for the given patient id.

							-----Create table patients_uidd
Create table Patients_UID(Patient_ID varchar(50), UID varchar(50));
SELECT * FROM Patients_UID;
							-----To drop Table
Drop table Patients_UID;
							-----Create a stored procedure to make random user id
create or replace procedure p_patients_uid(Patientid varchar(50))
language plpgsql    
as $$
begin
  	insert into Patients_UID values(Patientid,CONCAT(patientid,gen_random_uuid()));
 end
 $$;
							-----To execute the stored procedure
call  p_patients_uid('S0030');
							-----To view the result
Select * from "patients_uid";

--Creating view on patient table with check constraint condition.
CREATE OR REPLACE VIEW "Patients_View" AS 
SELECT "Patient_ID", CONCAT("Firstname",' ',"Lastname") AS "Patient_Name","Gender_ID", "Age" FROM "Patients"
WHERE "Age" > 55 AND "Gender_ID"='G001'
WITH CHECK OPTION;

--trigger to raise notice and prevent the deletion of a record from a view.
select * from "Patients_View"

CREATE OR REPLACE FUNCTION fn_del()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS 
$$
	BEGIN
		RAISE NOTICE '% ON ROWS IN %.% WONT HAPPEN', --FOR BEFORE TRIGGER
			TG_OP, TG_TABLE_SCHEMA, TG_TABLE_NAME;		
		RETURN NULL; -- CANCELS OPERATION OF TRIGGER
	END
$$

			-- create trigger to not allow deleting on Patients_view with INSTEAD OF trigger on view for DML operations
CREATE OR REPLACE TRIGGER trg_delete 
INSTEAD OF DELETE ON "Patients_View"
FOR EACH ROW
EXECUTE PROCEDURE fn_del();

			-- try to delete the row in view
DELETE FROM "Patients_View" WHERE "Patient_ID"='S0033';

--create a table to get patients’ demographic details whose birth year is 1939
CREATE TABLE "Patient_Detail" (
	Demo_sr_no SERIAL PRIMARY KEY,
	"Patient_ID" VARCHAR(250) REFERENCES public."Patients"("Patient_ID"),
	"Visit_Date" timestamp without time zone,	
	"Age" INT CHECK ((EXTRACT(YEAR FROM ("Visit_Date")) - "Age") = 1939),
	"Gender" VARCHAR(10) REFERENCES public."Gender"("Gender_ID"),
	"Height" VARCHAR(10) REFERENCES public."Patients"("Patient_ID"),
    "BMI" VARCHAR(10) REFERENCES public."Patients"("Patient_ID"),
	"Race" VARCHAR(20) REFERENCES public."Race"("Race_ID"))
 
SELECT * FROM "Patient_Detail" 

--Using the trigger after insert on the lab test table. If the patient has abnormal HbA1C and fasting glucose values.

		-- create audit table to record abnormal sugar levels and stop inserting into "Lab_Test" table
CREATE TABLE lab_test_abnormal(Lab_ID TEXT, Patient_ID TEXT, Hb_A1C REAL, Fasting_Glucose INTEGER, Insulin REAL)
---------
CREATE OR REPLACE FUNCTION lab_test_abnormal_values()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS
$$
BEGIN
	IF NEW."Hb_A1C" < 5.7 AND (NEW."Fasting_Glucose"<70 OR NEW."Fasting_Glucose" > 100) THEN 
		INSERT INTO lab_test_abnormal(lab_ID, Patient_ID, Hb_A1C, Fasting_Glucose, Insulin) 
			VALUES(NEW."Lab_ID", NEW."Patient_ID",NEW."Hb_A1C",NEW."Fasting_Glucose", NEW."Insulin");
		RAISE EXCEPTION 'THE SUGAR LEVELS ENTERED ARE ABNORMAL FOR % ROWS IN %.%',
				TG_OP, TG_TABLE_SCHEMA, TG_TABLE_NAME;
		RETURN NULL;
	END IF;
	RETURN NEW;
END
$$;

CREATE OR REPLACE TRIGGER abnormal_sugar 
AFTER INSERT
ON "Lab_Test"
FOR EACH ROW
EXECUTE PROCEDURE lab_test_abnormal_values();

-- the number of Patients whose Gait RPE start is greater than the end and vice versa(using UNION)
SELECT 'RPE_Start>End' AS "type", 
	COUNT(CASE WHEN w."Gait_RPE_Start "> w."Gait_RPE_End " THEN 1 END)
FROM "Walking_Test" w
JOIN "Patients" p
ON p."WalkTest_ID"=w."WalkTest_ID"
UNION
SELECT 'RPE_End>Start' AS "type", 
	 COALESCE(COUNT (CASE WHEN w."Gait_RPE_End ">  w."Gait_RPE_Start " THEN 1 END),0)
FROM "Walking_Test" w
JOIN "Patients" p
ON p."WalkTest_ID"=w."WalkTest_ID";





