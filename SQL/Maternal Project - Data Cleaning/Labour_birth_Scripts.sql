/*Trasforamtion for "Meternal_Core".labour_birth*/



update "Meternal_Core".labour_birth  set treatment_disease_pregnancy = null
where treatment_disease_pregnancy='not_applicable'

update "Meternal_Core".labour_birth  set treatment_disease_pregnancy = 0
where treatment_disease_pregnancy='diet'

update "Meternal_Core".labour_birth  set treatment_disease_pregnancy = 1
where treatment_disease_pregnancy  is not null and treatment_disease_pregnancy != '0'


update "Meternal_Core".labour_birth  set  disease_diagnose_during_pregnancy= null
where disease_diagnose_during_pregnancy='not_applicable'

update "Meternal_Core".labour_birth  set  disease_diagnose_during_pregnancy= null
where disease_diagnose_during_pregnancy='no_answer'


update "Meternal_Core".labour_birth  set disease_diagnose_during_pregnancy = 1
where disease_diagnose_during_pregnancy  is not null and disease_diagnose_during_pregnancy != '0'



select disease_diagnose_during_pregnancy  from "Meternal_Core".labour_birth 
where disease_diagnose_during_pregnancy is not null and disease_diagnose_during_pregnancy != '0'


Alter Table "Meternal_Core".labour_birth 
ALTER COLUMN  disease_diagnose_during_pregnancy TYPE int 
USING disease_diagnose_during_pregnancy::int


Alter Table "Meternal_Core".labour_birth 
ALTER COLUMN  treatment_disease_pregnancy TYPE int 
USING treatment_disease_pregnancy::int


select * from "Meternal_Core".labour_birth


alter table "Meternal_Core".labour_birth drop column chronic_diseases


alter table "Meternal_Core".labour_birth rename column disease_diagnose_during_pregnancy to disease_diagnose


select chronic_diabetes from "Meternal_Core".labour_birth where case_id=118



Alter Table "Meternal_Core".labour_birth 
ALTER COLUMN  chronic_diabetes TYPE int 
USING chronic_diabetes::int

select cesarean_section_reason from "Meternal_Core".labour_birth where cesarean_section_reason is not null


