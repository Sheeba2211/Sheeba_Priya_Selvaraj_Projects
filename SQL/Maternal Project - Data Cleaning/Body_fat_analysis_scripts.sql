Alter Table "Meternal_Core".body_fat_analysis
ALTER COLUMN  maternal_brachial_circumference  TYPE float 
USING maternal_brachial_circumference::float;


Alter Table "Meternal_Core".body_fat_analysis
ALTER COLUMN   circumference_maternal_calf TYPE float 
USING circumference_maternal_calf::float;

Alter Table "Meternal_Core".body_fat_analysis
ALTER COLUMN   maternal_neck_circumference TYPE float 
USING maternal_neck_circumference::float;

Alter Table "Meternal_Core".body_fat_analysis
ALTER COLUMN   maternal_hip_circumference TYPE float 
USING maternal_hip_circumference::float;

Alter Table "Meternal_Core".body_fat_analysis
ALTER COLUMN   maternal_waist_circumference TYPE float 
USING maternal_waist_circumference::float;

Alter Table "Meternal_Core".body_fat_analysis
ALTER COLUMN   mean_tricciptal_skinfold TYPE float 
USING mean_tricciptal_skinfold::float;

Alter Table "Meternal_Core".body_fat_analysis
ALTER COLUMN   mean_subscapular_skinfold TYPE float 
USING mean_subscapular_skinfold::float;

Alter Table "Meternal_Core".body_fat_analysis
ALTER COLUMN   mean_supra_iliac_skin_fold TYPE float 
USING mean_supra_iliac_skin_fold::float;

Alter Table "Meternal_Core".body_fat_analysis
ALTER COLUMN   periumbilical_subcutanous_fat TYPE float 
USING periumbilical_subcutanous_fat::float;

update "Meternal_Core".body_fat_analysis set periumbilical_subcutanous_fat = null
where periumbilical_subcutanous_fat='not_applicable'


Alter Table "Meternal_Core".body_fat_analysis
ALTER COLUMN   periumbilical_visceral_fat TYPE float 
USING periumbilical_visceral_fat::float;

update "Meternal_Core".body_fat_analysis set periumbilical_visceral_fat = null
where periumbilical_visceral_fat='not_applicable'



Alter Table "Meternal_Core".body_fat_analysis
ALTER COLUMN   periumbilical_total_fat TYPE float 
USING periumbilical_total_fat::float;


Alter Table "Meternal_Core".body_fat_analysis
ALTER COLUMN   preperitoneal_subcutaneous_fat TYPE float 
USING preperitoneal_subcutaneous_fat::float;


Alter Table "Meternal_Core".body_fat_analysis
ALTER COLUMN   preperitoneal_visceral_fat TYPE float 
USING preperitoneal_visceral_fat::float;


select * from "Meternal_Core".body_fat_analysis


alter table  "Meternal_Core".body_fat_analysis add constraint fk_case_id  foreign key (case_id) references "Meternal_Core".Patient_Demographics

