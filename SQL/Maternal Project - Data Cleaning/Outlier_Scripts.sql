/* Fixing the Outliers for "Meternal_Core".infant_history ,apgar_first_min  */


update "Meternal_Core".infant_history  set apgar_first_min = 10
 where case_id=176
 
 /* Fixing the Outliers for"Meternal_Core".labour_birth for cesarean_section_reason   */
 
select cesarean_section_reason from "Meternal_Core".labour_birth where cesarean_section_reason is not null

update "Meternal_Core".labour_birth set cesarean_section_reason='elective'
where case_id=74
 
 update "Meternal_Core".labour_birth set cesarean_section_reason='NRFS'
where cesarean_section_reason='Nonreassuring fetal status (NRFS)'


update "Meternal_Core".labour_birth set cesarean_section_reason='NRFS'
where cesarean_section_reason='acute fetal distress'

update "Meternal_Core".labour_birth set cesarean_section_reason=NULL
where cesarean_section_reason='8'
 

update "Meternal_Core".labour_birth set  delivery_mode=5
where delivery_mode=12

/*Fixing outliers of "Meternal_Core".body_fat_analysis*/


select case_id,periumbilical_subcutanous_fat,periumbilical_visceral_fat,periumbilical_total_fat
from "Meternal_Core".body_fat_analysis where periumbilical_total_fat is null and periumbilical_subcutanous_fat is not null
and periumbilical_visceral_fat is not null


update "Meternal_Core".body_fat_analysis set periumbilical_total_fat=periumbilical_subcutanous_fat + periumbilical_visceral_fat
where case_id in(266,
269,
275,
278,
283,
285,
273,
280,
282,
286,
287)

/*Fixing outliers of"Meternal_Core".lab_results  Replacing the missing vakues maternal_weight_at_inclusion */

update "Meternal_Core".lab_results  set  current_maternal_weight_first_tri=d.maternal_weight_at_inclusion
from "Meternal_Core".patient_demographics d  
where d.gestational_age_at_inclusion <= 12  and  "Meternal_Core".lab_results.case_id=d.case_id  and "Meternal_Core".lab_results.current_maternal_weight_first_tri is null


update "Meternal_Core".lab_results  set  current_maternal_weight_second_tri=d.maternal_weight_at_inclusion
from "Meternal_Core".patient_demographics d  
where d.gestational_age_at_inclusion >12 and d.gestational_age_at_inclusion <=27 and  "Meternal_Core".lab_results.case_id=d.case_id  and "Meternal_Core".lab_results.current_maternal_weight_second_tri is null


update "Meternal_Core".lab_results  set  current_maternal_weight_3rd_tri=d.maternal_weight_at_inclusion
from "Meternal_Core".patient_demographics d  
where d.gestational_age_at_inclusion >27  and  "Meternal_Core".lab_results.case_id=d.case_id  and "Meternal_Core".lab_results.current_maternal_weight_3rd_tri is null

/*Fixing outliers of "Meternal_Core".patient_history tobacco_quantity_by_day */


update "Meternal_Core".patient_history set tobacco_quantity_by_day=1
where case_id=47


/*Fixing Missiong values of maternal_weight_at_inclusion weight calaculation by using BMI and height  */

update "Meternal_Core".patient_demographics set maternal_weight_at_inclusion=round((maternal_bmi_at_inclusion*height_at_inclusion*height_at_inclusion)::decimal,2)
where case_id=124

select maternal_weight_at_inclusion from "Meternal_Core".patient_demographics  where case_id=124


select prepregnant_weight from "Meternal_Core".patient_history where case_id=46

update "Meternal_Core".patient_history set prepregnant_weight= round(("Meternal_Core".patient_history.prepregnant_bmi*d.height_at_inclusion*d.height_at_inclusion) ::decimal,2)
from "Meternal_Core".patient_demographics d
where "Meternal_Core".patient_history.case_id=46
