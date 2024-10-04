----------------------------------------------------------------------------------------------------------
 /* Tranformation of patient_history*/
-----------------------------------------------------------------------------------------------------------
/* Changing the Data Type of the hypertension_past_reported */

Alter Table "Meternal_Core".patient_history
ALTER COLUMN  hypertension_past_reported TYPE int 
USING hypertension_past_reported::int;


/* Changing the Data Type of the tobacco_use */
Alter Table "Meternal_Core".patient_history 
ALTER COLUMN  tobacco_use TYPE int 
USING tobacco_use::int;

/* Updating tobacco_quantity_by_day 'not applicable' to NULL*/

update "Meternal_Core".patient_history set tobacco_quantity_by_day = null
where tobacco_quantity_by_day='not_applicable'
			  
select * from "Meternal_Core".patient_history
/*Changing the Data Type To  Float of the tobacco_quantity_by_day*/ 

Alter Table "Meternal_Core".patient_history 
ALTER COLUMN  tobacco_quantity_by_day TYPE int 
USING tobacco_quantity_by_day::int

/*Changing the Data Type To  Float of the alcohol_use */ 

Alter Table "Meternal_Core".patient_history 
ALTER COLUMN  alcohol_use TYPE int 
USING alcohol_use::int

/*Updating alcohol_quantity_milliliters Column from 'not_applicable' to null*/


update "Meternal_Core".patient_history set alcohol_quantity_milliliters = null
where alcohol_quantity_milliliters='not_applicable'

/*Updating alcohol_quantity_milliliters Column from 'no_answer' to null*/
update "Meternal_Core".patient_history set alcohol_quantity_milliliters = null
where alcohol_quantity_milliliters='no_answer'

select * from "Meternal_Core".patient_history  

/*Updating alcohol_quantity_milliliters Column Remove  ',' */

update "Meternal_Core".patient_history set alcohol_quantity_milliliters=replace (alcohol_quantity_milliliters,',','')

/*select replace (alcohol_quantity_milliliters,',','') from "Meternal_Core".patient_history*/ 

/*Changing the Data Type To  int of the  alcohol_quantity_milliliters */ 

Alter Table "Meternal_Core".patient_history 
ALTER COLUMN  alcohol_quantity_milliliters TYPE int 
USING alcohol_quantity_milliliters::int

/*Updating drugs_during_pregnancy Column from 'not_applicable' to null*/

update "Meternal_Core".patient_history set drugs_during_pregnancy = null
where drugs_during_pregnancy='not_applicable'

/*Changing the Data Type To  int of the  drugs_during_pregnancy */ 

Alter Table "Meternal_Core".patient_history 
ALTER COLUMN  drugs_during_pregnancy TYPE int 
USING drugs_during_pregnancy::int

/*Changing the Data Type To  int of the  past_pregnancies_number */ 

Alter Table "Meternal_Core".patient_history 
ALTER COLUMN  past_pregnancies_number TYPE int 
USING past_pregnancies_number::int


/*Changing the Data Type To  int of the miscarriage  */ 

Alter Table "Meternal_Core".patient_history 
ALTER COLUMN  miscarriage TYPE int 
USING miscarriage::int

/*Updating prepregnant_weight Column from 'no_answer' to null*/

update "Meternal_Core".patient_history set prepregnant_weight = null
where prepregnant_weight='no_answer'

/*Changing the Data Type To  int of the prepregnant_weight  */ 
Alter Table "Meternal_Core".patient_history 
ALTER COLUMN  prepregnant_weight TYPE float 
USING prepregnant_weight::float

/*Updating prepregnant_bmi Column from 'not_applicable' to null*/

update "Meternal_Core".patient_history set  prepregnant_bmi= null
where prepregnant_bmi='not_applicable'

/*Changing the Data Type To  int of the prepregnant_bmi  */ 

Alter Table "Meternal_Core".patient_history 
ALTER COLUMN  prepregnant_bmi TYPE float 
USING prepregnant_bmi::float



/*Changing the Data Type To  int of the breakfast_meal  */ 

Alter Table "Meternal_Core".patient_history 
ALTER COLUMN   breakfast_meal TYPE int 
USING breakfast_meal::int

/*Changing the Data Type To  int of the  morning_snack */ 

Alter Table "Meternal_Core".patient_history 
ALTER COLUMN   morning_snack TYPE int 
USING morning_snack::int

/*Changing the Data Type To  int of the lunch_meal  */ 

Alter Table "Meternal_Core".patient_history 
ALTER COLUMN   lunch_meal TYPE int 
USING lunch_meal::int

/*Changing the Data Type To  int of the  afternoon_snack */ 

Alter Table "Meternal_Core".patient_history 
ALTER COLUMN   afternoon_snack TYPE int 
USING afternoon_snack::int

/*Changing the Data Type To  int of the  meal_dinner */ 

Alter Table "Meternal_Core".patient_history 
ALTER COLUMN   meal_dinner TYPE int 
USING meal_dinner::int

/*Changing the Data Type To  int of the  supper_meal */ 

Alter Table "Meternal_Core".patient_history 
ALTER COLUMN   supper_meal TYPE int 
USING supper_meal::int

/* Adding The Column Healthy_Diet*/
alter table "Meternal_Core".patient_history add column balanced_diet INT

/*Alter table "Meternal_Core".patient_history rename Healthy_Diet to balanced_diet*/

UPDATE "Meternal_Core".patient_history  
SET balanced_diet=breakfast_meal+morning_snack+lunch_meal+afternoon_snack+meal_dinner+supper_meal

/* Alter Table  bean change the Column Dataype*/

Alter Table "Meternal_Core".patient_history
ALTER COLUMN  bean TYPE INT 
USING bean::INT;

/* Alter Table fruits change the Column Dataype*/

Alter Table "Meternal_Core".patient_history
ALTER COLUMN  fruits TYPE INT 
USING fruits::INT;

/* Alter Table vegetables change the Column Dataype*/

Alter Table "Meternal_Core".patient_history
ALTER COLUMN  vegetables TYPE INT 
USING vegetables::INT;

/* Alter Table embedded_food change the Column Dataype*/

Alter Table "Meternal_Core".patient_history
ALTER COLUMN  embedded_food TYPE INT 
USING embedded_food::INT;

/* Alter Table cookies change the Column Dataype*/

Alter Table "Meternal_Core".patient_history
ALTER COLUMN  cookies TYPE INT 
USING cookies::INT;

/* Alter Table pasta change the Column Dataype*/ 

Alter Table "Meternal_Core".patient_history
ALTER COLUMN  pasta TYPE INT 
USING pasta::INT; 

select * from "Meternal_Core".patient_history 

/* Adding the column Healthy_Diet*/

ALTER TABLE "Meternal_Core".patient_history  ADD column healthy_diet int


/*Updating the Column by giving the Score healthy_diet*/

UPDATE "Meternal_Core".patient_history  
SET healthy_diet=bean+fruits+vegetables+embedded_food


/*Adding the Column high_calorie_food*/

ALTER TABLE "Meternal_Core".patient_history  ADD column high_calorie_food int

/* Updating the Column by giving the Score high_calorie_food*/

UPDATE "Meternal_Core".patient_history  
SET high_calorie_food=cookies+pasta

/* Dropping the Columns*/

alter table  "Meternal_Core".patient_history  drop column breakfast_meal,drop column morning_snack,drop column lunch_meal,drop column afternoon_snack,
drop column meal_dinner,drop column supper_meal,drop column bean,drop column fruits,drop column vegetables,drop column embedded_food,drop column cookies,drop column pasta

/* Adding the Foriegn Key to the Table */

alter table "Meternal_Core".patient_history add constraint fk_case_id  foreign key (case_id) references "Meternal_Core".Patient_Demographics

/* Adding the Pasta  to the Table */
--alter table "Meternal_Core".patient_history  add  column pasta int

/* Changing the Datatype of the pasta column  */

Alter Table "Meternal_Core".patient_history
ALTER COLUMN  pasta TYPE int 
USING pasta::int

/* Updating  the Pasta value from the stage  Table */

update "Meternal_Core".patient_history  
set pasta=(select pasta from public.maternal_table_stage
		   where "Meternal_Core".patient_history.case_id=public.maternal_table_stage.case_id)
		   
		  

/* Changing the Datatype of the diabetes_mellitus_dm_reported column  */

Alter Table "Meternal_Core".patient_history
ALTER COLUMN diabetes_mellitus_dm_reported  TYPE int 
USING diabetes_mellitus_dm_reported::int

/* Renaming the Column from  diabetes_mellitus_dm_reported  to gdm_past_pregnancy column  */

Alter Table "Meternal_Core".patient_history rename column diabetes_mellitus_dm_reported to gdm_past_pregnancy

/* Renaming the Column from  bmi_according_who  to prepregnant_bmi_according_who column  */

alter table "Meternal_Core".patient_history  rename column bmi_according_who to prepregnant_bmi_according_who


/* Changing the Datatype of the past_newborn_1_weight column  */

Alter Table "Meternal_Core".patient_history
ALTER COLUMN  past_newborn_1_weight TYPE int 
USING past_newborn_1_weight::int

/*Updating past_newborn_1_weight Column from 'not_applicable' to null*/

update "Meternal_Core".patient_history set past_newborn_1_weight = null
where past_newborn_1_weight='not_applicable'

/*Updating past_newborn_1_weight Column from 'no_answer' to null*/

update "Meternal_Core".patient_history set past_newborn_1_weight = null
where past_newborn_1_weight='no_answer'

/*Updating past_newborn_1_weight Column from ',' to null*/

update "Meternal_Core".patient_history set past_newborn_1_weight=replace (past_newborn_1_weight,',','')


/* Changing the Datatype of the past_newborn_1_weight column  */

Alter Table "Meternal_Core".patient_history
ALTER COLUMN gestational_age_past_newborn_1  TYPE int 
USING gestational_age_past_newborn_1::int

/*Updating gestational_age_past_newborn_1 Column from 'not_applicable' to null*/

update "Meternal_Core".patient_history set gestational_age_past_newborn_1 = null
where gestational_age_past_newborn_1='not_applicable'

/*Updating gestational_age_past_newborn_1 Column from 'no_answer' to null*/

update "Meternal_Core".patient_history set gestational_age_past_newborn_1 = null
where gestational_age_past_newborn_1='no_answer'

/* Changing the Datatype of the past_newborn_1_weight column  */

Alter Table "Meternal_Core".patient_history
ALTER COLUMN gestational_age_past_newborn_1  TYPE int 
USING gestational_age_past_newborn_1::int

/* Changing the Datatype of the past_newborn_2_weight column  */

Alter Table "Meternal_Core".patient_history
ALTER COLUMN past_newborn_2_weight  TYPE int 
USING past_newborn_2_weight::int

/*Updating past_newborn_2_weight Column from 'not_applicable' to null*/

update "Meternal_Core".patient_history set past_newborn_2_weight = null
where past_newborn_2_weight='not_applicable'

/*Updating past_newborn_2_weight Column from 'no_answer' to null*/

update "Meternal_Core".patient_history set past_newborn_2_weight = null
where past_newborn_2_weight='no_answer'

/* Changing the Datatype of the gestational_age_past_newborn_2 column  */

Alter Table "Meternal_Core".patient_history
ALTER COLUMN gestational_age_past_newborn_2  TYPE int 
USING gestational_age_past_newborn_2::int


/*Updating gestational_age_past_newborn_2 Column from 'not_applicable' to null*/

update "Meternal_Core".patient_history set gestational_age_past_newborn_2 = null
where gestational_age_past_newborn_2='not_applicable'

/*Updating gestational_age_past_newborn_2 Column from 'no_answer' to null*/

update "Meternal_Core".patient_history set gestational_age_past_newborn_2 = null
where gestational_age_past_newborn_2='no_answer'

/*Updating past_newborn_1_weight Column from ',' to null*/

update "Meternal_Core".patient_history set past_newborn_2_weight=replace (past_newborn_2_weight,',','')


/* Changing the Datatype of the gestational_age_past_newborn_3 column  */


Alter Table "Meternal_Core".patient_history
ALTER COLUMN  gestational_age_past_newborn_3 TYPE int 
USING gestational_age_past_newborn_3::int

/*Updating gestational_age_past_newborn_3 Column from 'not_applicable' to null*/

update "Meternal_Core".patient_history set gestational_age_past_newborn_3 = null
where gestational_age_past_newborn_3='not_applicable'

/*Updating gestational_age_past_newborn_3 Column from 'no_answer' to null*/

update "Meternal_Core".patient_history set gestational_age_past_newborn_3 = null
where gestational_age_past_newborn_3='no_answer'

/*Updating gestational_age_past_newborn_3 Column from ',' to null*/

update "Meternal_Core".patient_history set gestational_age_past_newborn_3=replace (gestational_age_past_newborn_3,',','')


/* Changing the Datatype of the gestational_age_past_4_newborn column  */

Alter Table "Meternal_Core".patient_history
ALTER COLUMN  gestational_age_past_4_newborn TYPE int 
USING gestational_age_past_4_newborn::int


/*Updating gestational_age_past_4_newborn Column from 'not_applicable' to null*/

update "Meternal_Core".patient_history set gestational_age_past_4_newborn = null
where gestational_age_past_4_newborn='not_applicable'

/*Updating gestational_age_past_4_newborn Column from 'no_answer' to null*/


update "Meternal_Core".patient_history set gestational_age_past_4_newborn = null
where gestational_age_past_4_newborn='no_answer'

/*Updating gestational_age_past_4_newborn Column from ',' to null*/

update "Meternal_Core".patient_history set gestational_age_past_4_newborn=replace (gestational_age_past_4_newborn,',','')


/* Changing the Datatype of the past_newborn_3_weight column  */

Alter Table "Meternal_Core".patient_history
ALTER COLUMN  past_newborn_3_weight TYPE int 
USING past_newborn_3_weight::int

/* Updating past_newborn_3_weight Column from 'not_applicable' to null*/

update "Meternal_Core".patient_history set past_newborn_3_weight = null
where past_newborn_3_weight='not_applicable'

/* Updating past_newborn_3_weight Column from 'no_answer' to null*/

update "Meternal_Core".patient_history set past_newborn_3_weight = null
where past_newborn_3_weight='no_answer'

/* Updating past_newborn_3_weight Column from ',' to null*/

update "Meternal_Core".patient_history set past_newborn_3_weight=replace (past_newborn_3_weight,',','')

/* Changing the Datatype of the past_newborn_4_weight column  */

Alter Table "Meternal_Core".patient_history
ALTER COLUMN  past_newborn_4_weight TYPE int 
USING past_newborn_4_weight::int

/* Updating past_newborn_4_weight Column from 'not_applicable' to null*/


update "Meternal_Core".patient_history set past_newborn_4_weight = null
where past_newborn_4_weight='not_applicable'

/* Updating past_newborn_4_weight Column from 'no_answer' to null*/

update "Meternal_Core".patient_history set past_newborn_4_weight = null
where past_newborn_4_weight='no_answer'

/* Updating past_newborn_4_weight Column from ',' to null*/

update "Meternal_Core".patient_history set past_newborn_4_weight=replace (past_newborn_4_weight,',','')



/* Adding Column past_pregnancy_term*/

alter table "Meternal_Core".patient_history add column past_pregnancy_term int

/* Adding Column Past_newborn_weight_hist */


alter table "Meternal_Core".patient_history add column Past_newborn_weight_hist int



/* Checking the past_newborn* weight whether below 2500  and updating the Column Past_newborn_weight_hist to 1  */

update "Meternal_Core".patient_history set Past_newborn_weight_hist=1
where case_id in
(select case_id from "Meternal_Core".patient_history
where past_newborn_1_weight<2500 or past_newborn_2_weight<2500 
or past_newborn_3_weight<2500 or past_newborn_4_weight<2500)

/* Checking the past_newborn* weight whether below 4000  and updating the Column Past_newborn_weight_hist  to 2 */


update "Meternal_Core".patient_history set Past_newborn_weight_hist=2
where case_id in
(select case_id from "Meternal_Core".patient_history
where past_newborn_1_weight>4000 or past_newborn_2_weight>4000
or past_newborn_3_weight>4000 or past_newborn_4_weight>4000)

/* Checking the past_newborn* weight whether Helathy weight updating the Column Past_newborn_weight_hist  to 0 */



update "Meternal_Core".patient_history set Past_newborn_weight_hist=0
where case_id in
(select case_id from "Meternal_Core".patient_history
where past_newborn_1_weight is not  null and Past_newborn_weight_hist is null)

/* Checking the gestational_age* weight whether below Full term or pre term  and updating the Column Past_newborn_weight_hist  to 0 */


update "Meternal_Core".patient_history set past_pregnancy_term=0
where case_id in
(select case_id 
from "Meternal_Core".patient_history
where gestational_age_past_newborn_1=0 or gestational_age_past_newborn_2=0 or gestational_age_past_newborn_3=0
or gestational_age_past_4_newborn=0)

/* Checking the gestational_age* weight whether below Full term or pre term  and updating the Column Past_newborn_weight_hist  to 0 */

update "Meternal_Core".patient_history set past_pregnancy_term=0
where case_id in(
select case_id 
from "Meternal_Core".patient_history where gestational_age_past_newborn_1 is not null and 
past_pregnancy_term is null)


/* Dropping Column*/

alter table "Meternal_Core".patient_history drop column past_newborn_1_weight,drop column gestational_age_past_newborn_1,drop column past_newborn_2_weight,
drop column gestational_age_past_newborn_2,drop column past_newborn_3_weight,drop column gestational_age_past_newborn_3,
drop column past_newborn_4_weight,drop column gestational_age_past_4_newborn





																	  
																	  
																	  s





