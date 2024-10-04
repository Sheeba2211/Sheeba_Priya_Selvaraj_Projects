select * from "Meternal_Core".lab_results

/* Changing the datatype first_trimester_hematocrit to Float*/

Alter Table "Meternal_Core".lab_results
ALTER COLUMN  first_trimester_hematocrit TYPE float 
USING first_trimester_hematocrit::float;

/* Changing the datatype firt_trimester_hemoglobin to Float*/


Alter Table "Meternal_Core".lab_results
ALTER COLUMN  firt_trimester_hemoglobin TYPE float 
USING firt_trimester_hemoglobin::float;

/*Changing the Column name from firt_trimester_hemoglobin to first_trimester_hemoglobin*/

alter table "Meternal_Core".lab_results rename column firt_trimester_hemoglobin to first_trimester_hemoglobin

/* Changing the datatype first_tri_fasting_blood_glucose to int*/

Alter Table "Meternal_Core".lab_results
ALTER COLUMN  first_tri_fasting_blood_glucose TYPE int 
USING first_tri_fasting_blood_glucose::int;


/* Changing the datatype first_hour_ogtt75_first_tri to int*/

Alter Table "Meternal_Core".lab_results
ALTER COLUMN  first_hour_ogtt75_first_tri TYPE int 
USING first_hour_ogtt75_first_tri::int;

update "Meternal_Core".lab_results set first_hour_ogtt75_first_tri = null
where first_hour_ogtt75_first_tri='not_applicable'

/* Changing the datatype second_hour_ogtt_1tri to int*/

Alter Table "Meternal_Core".lab_results
ALTER COLUMN  second_hour_ogtt_1tri TYPE int 
USING second_hour_ogtt_1tri::int;

update "Meternal_Core".lab_results set second_hour_ogtt_1tri = null
where second_hour_ogtt_1tri='not_applicable'

/* Changing the datatype current_maternal_weight_first_tri to int*/

Alter Table "Meternal_Core".lab_results
ALTER COLUMN  current_maternal_weight_first_tri TYPE float 
USING current_maternal_weight_first_tri::float;

update "Meternal_Core".lab_results set current_maternal_weight_first_tri = null
where current_maternal_weight_first_tri='not_applicable'

/* Changing the datatype second_trimester_hemoglobin to int*/

Alter Table "Meternal_Core".lab_results
ALTER COLUMN  second_trimester_hemoglobin TYPE float 
USING second_trimester_hemoglobin::float;


update "Meternal_Core".lab_results set second_trimester_hemoglobin = null
where second_trimester_hemoglobin='not_applicable'

/* Changing the datatype second_tri_fasting_blood_glucose to int*/

Alter Table "Meternal_Core".lab_results
ALTER COLUMN  second_tri_fasting_blood_glucose TYPE int
USING second_tri_fasting_blood_glucose::int;

update "Meternal_Core".lab_results set second_tri_fasting_blood_glucose = null
where second_tri_fasting_blood_glucose='not_applicable'

/* Changing the datatype first_hour_ogtt75_2tri to float*/

Alter Table "Meternal_Core".lab_results
ALTER COLUMN  first_hour_ogtt75_2tri TYPE int 
USING first_hour_ogtt75_2tri::int;

update "Meternal_Core".lab_results set first_hour_ogtt75_2tri = null
where first_hour_ogtt75_2tri='not_applicable'

/* Changing the datatype  second_hour_ogtt75_2tri to float*/

Alter Table "Meternal_Core".lab_results
ALTER COLUMN  second_hour_ogtt75_2tri TYPE int 
USING second_hour_ogtt75_2tri::int;

update "Meternal_Core".lab_results set second_hour_ogtt75_2tri = null
where second_hour_ogtt75_2tri='not_applicable'


/* Changing the datatype current_maternal_weight_second_tri  to float*/

Alter Table "Meternal_Core".lab_results
ALTER COLUMN  current_maternal_weight_second_tri TYPE float 
USING current_maternal_weight_second_tri::float;

update "Meternal_Core".lab_results set current_maternal_weight_second_tri = null
where current_maternal_weight_second_tri='not_applicable'


/* Changing the datatype  third_trimester_hematocrit to float*/

Alter Table "Meternal_Core".lab_results
ALTER COLUMN  third_trimester_hematocrit TYPE float 
USING third_trimester_hematocrit::float;

update "Meternal_Core".lab_results set third_trimester_hematocrit = null
where third_trimester_hematocrit='not_applicable'

/* Changing the datatype  third_trimester_hemoglobin to float*/

Alter Table "Meternal_Core".lab_results
ALTER COLUMN  third_trimester_hemoglobin TYPE float 
USING third_trimester_hemoglobin::float;

update "Meternal_Core".lab_results set third_trimester_hemoglobin = null
where third_trimester_hemoglobin='not_applicable'

/* Changing the datatype  third_tri_fasting_blood_glucose to float*/

Alter Table "Meternal_Core".lab_results
ALTER COLUMN  third_tri_fasting_blood_glucose TYPE int 
USING third_tri_fasting_blood_glucose::int;

update "Meternal_Core".lab_results set third_tri_fasting_blood_glucose = null
where third_tri_fasting_blood_glucose='not_applicable'

/* Changing the datatype  first_hour_ogtt75_3tri to float*/

Alter Table "Meternal_Core".lab_results
ALTER COLUMN  first_hour_ogtt75_3tri TYPE int 
USING first_hour_ogtt75_3tri::int;


update "Meternal_Core".lab_results set first_hour_ogtt75_3tri = null
where first_hour_ogtt75_3tri='not_applicable'

/* Changing the datatype second_hour_ogtt_3tri  to float*/

Alter Table "Meternal_Core".lab_results
ALTER COLUMN  second_hour_ogtt_3tri TYPE int 
USING second_hour_ogtt_3tri::int;

update "Meternal_Core".lab_results set second_hour_ogtt_3tri = null
where second_hour_ogtt_3tri='not_applicable'

/* Changing the datatype  current_maternal_weight_3rd_tri to float*/

Alter Table "Meternal_Core".lab_results
ALTER COLUMN  current_maternal_weight_3rd_tri TYPE float 
USING current_maternal_weight_3rd_tri::float;


update "Meternal_Core".lab_results set current_maternal_weight_3rd_tri = null
where current_maternal_weight_3rd_tri='not_applicable'

/* Drop the Column ultrasound_gestational_age */

alter table "Meternal_Core".lab_results drop column ultrasound_gestational_age


 alter table "Meternal_Core".lab_results  add column mean_sbp int

alter table "Meternal_Core".lab_results  add column mean_dbp int

Alter Table "Meternal_Core".lab_results
ALTER COLUMN  right_systolic_blood_pressure TYPE int 
USING right_systolic_blood_pressure::int;

update "Meternal_Core".lab_results set right_systolic_blood_pressure = null
where right_systolic_blood_pressure='not_applicable'




Alter Table "Meternal_Core".lab_results
ALTER COLUMN  right_diastolic_blood_pressure TYPE int 
USING right_diastolic_blood_pressure::int;

update "Meternal_Core".lab_results set right_diastolic_blood_pressure = null
where right_diastolic_blood_pressure='not_applicable'


Alter Table "Meternal_Core".lab_results
ALTER COLUMN   left_systolic_blood_pressure TYPE int 
USING left_systolic_blood_pressure::int;

update "Meternal_Core".lab_results set left_systolic_blood_pressure = null
where left_systolic_blood_pressure='not_applicable'

Alter Table "Meternal_Core".lab_results
ALTER COLUMN left_diastolic_blood_pressure  TYPE int 
USING left_diastolic_blood_pressure::int;

update "Meternal_Core".lab_results set left_diastolic_blood_pressure = null
where left_diastolic_blood_pressure='not_applicable'


update "Meternal_Core".lab_results set mean_sbp = (right_systolic_blood_pressure + left_systolic_blood_pressure)/2

 
update "Meternal_Core".lab_results set mean_sbp =138
where case_id=196

update "Meternal_Core".lab_results set mean_sbp =109
where case_id=217



select case_id from "Meternal_Core".lab_results where mean_dbp is null


update "Meternal_Core".lab_results set mean_dbp = ( left_diastolic_blood_pressure+right_diastolic_blood_pressure )/2

update "Meternal_Core".lab_results set mean_dbp =91
where case_id=196

update "Meternal_Core".lab_results set mean_dbp =63
where case_id=217

alter table "Meternal_Core".lab_results drop column right_systolic_blood_pressure,drop column right_diastolic_blood_pressure,
drop column left_diastolic_blood_pressure,drop column left_systolic_blood_pressure


Alter Table "Meternal_Core".lab_results
ALTER COLUMN   fetal_weight_at_ultrasound TYPE float 
USING fetal_weight_at_ultrasound::float;


update "Meternal_Core".lab_results set fetal_weight_at_ultrasound = null
where fetal_weight_at_ultrasound='not_applicable'

update "Meternal_Core".lab_results set fetal_weight_at_ultrasound=replace (fetal_weight_at_ultrasound,',','')


Alter Table "Meternal_Core".lab_results
ALTER COLUMN   weight_fetal_percentile TYPE int 
USING weight_fetal_percentile::int;


update "Meternal_Core".lab_results set weight_fetal_percentile = null
where weight_fetal_percentile='not_applicable'

select * from "Meternal_Core".lab_results

