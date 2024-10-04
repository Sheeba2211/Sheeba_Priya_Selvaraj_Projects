/*Creating Schemas*/
CREATE SCHEMA "Meternal_Core"
    AUTHORIZATION postgres;
	
/*Table -1 Creating Patient Demographics*/

 create Table "Meternal_Core".Patient_Demographics AS (
	select case_id,
age_years_old,
color_ethnicity,
gestational_age_at_inclusion,
maternal_weight_at_inclusion,
hight_at_inclusion,
current_bmi,
current_bmi_according_who
	from public.maternal_table_stage)
	
	
/*Table 2 Creating  Patient History*/
	
	create table "Meternal_Core".Patient_History as ( select case_id,
hypertension_past_reported,
hypertension_past_treatment,
diabetes_mellitus_dm_reported,
diabetes_mellitus_disease_gap,
diabetes_mellitus_treatment,
tobacco_use,
tobacco_use_in_months,
tobacco_quantity_by_day,
alcohol_use,
alcohol_quantity_milliliters,
alcohol_preference,
drugs_preference,
drugs_years_use,
drugs_during_pregnancy,
past_pregnancies_number,
miscarriage,
prepregnant_weight,
prepregnant_bmi,
bmi_according_who,
breakfast_meal,
morning_snack,
lunch_meal,
afternoon_snack,
meal_dinner,
supper_meal,
bean, fruits, vegetables, embedded_food,cookies
from public.maternal_table_stage)

/*Table -3 Past_Delivery_Details*/

create table "Meternal_Core".Past_Delivery_Details as 
(
	select case_id
past_newborn_1_weight,
gestational_age_past_newborn_1,
past_newborn_2_weight,
gestational_age_past_newborn_2,
past_newborn_3_weight,
gestational_age_past_newborn_3,
past_newborn_4_weight
from public.maternal_table_stage)

/* Table -4 Lab Results */

create table "Meternal_Core".Lab_Results as (select case_id,
first_trimester_hematocrit,
firt_trimester_hemoglobin,
first_tri_fasting_blood_glucose,
first_hour_ogtt75_first_tri,
second_hour_ogtt_1tri,
hiv_1tri,
syphilis_1tri,
c_hepatitis_1tri,
current_maternal_weight_first_tri,
second_trimester_hematocrit,
second_trimester_hemoglobin,
second_tri_fasting_blood_glucose,
first_hour_ogtt75_2tri,
second_hour_ogtt75_2tri,
current_maternal_weight_second_tri,
third_trimester_hematocrit,
third_trimester_hemoglobin,
third_tri_fasting_blood_glucose,
first_hour_ogtt75_3tri,
second_hour_ogtt_3tri,
current_maternal_weight_3rd_tri,
ultrasound_gestational_age,
right_systolic_blood_pressure,
right_diastolic_blood_pressure,
left_systolic_blood_pressure,
left_diastolic_blood_pressure
from public.maternal_table_stage)

/*Table _5 BODY FAT ANALYSIS*/

create table "Meternal_Core".BODY_FAT_ANALYSIS as (select maternal_brachial_circumference,
circumference_maternal_calf,
maternal_neck_circumference,
maternal_hip_circumference,
maternal_waist_circumference,
mean_tricciptal_skinfold,
mean_subscapular_skinfold,
mean_supra_iliac_skin_fold,
periumbilical_subcutanous_fat,
periumbilical_visceral_fat,
periumbilical_total_fat,
preperitoneal_subcutaneous_fat,
preperitoneal_visceral_fat,
case_id from public.maternal_table_stage)


/*Table 6 Labour_Birth*/

create table "Meternal_Core".Labour_Birth as (select case_id,
gestational_age_at_birth,
prepartum_maternal_weight,
prepartum_maternal_heigh,
delivery_mode,
cesarean_section_reason,
hospital_systolic_blood_pressure,
hospital_diastolic_blood_pressure,
hospital_hypertension,
preeclampsia_record_pregnancy,
gestational_diabetes_mellitus,
chronic_diabetes,
chronic_diseases,
disease_diagnose_during_pregnancy,
treatment_disease_pregnancy,
number_prenatal_appointments,
mothers_hospital_stay,
meconium_labor from public.maternal_table_stage)

/*Table 7  Infant_History */

create table "Meternal_Core".Infant_History as (select case_id,
expected_weight_for_the_newborn,
newborn_weight,
newborn_height,
newborn_head_circumference,
thoracic_perimeter_newborn,
apgar_first_min,
apgar_5th_min,
pediatric_resuscitation_maneuvers,
newborn_intubation,
newborn_airway_aspiration,
fetal_weight_at_ultrasound,
weight_fetal_percentile 
 from public.maternal_table_stage)								

	
	
