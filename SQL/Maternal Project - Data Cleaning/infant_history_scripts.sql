Alter Table "Meternal_Core".infant_history
ALTER COLUMN  expected_weight_for_the_newborn  TYPE float 
USING expected_weight_for_the_newborn::float;



Alter Table "Meternal_Core".infant_history
ALTER COLUMN   newborn_head_circumference TYPE float 
USING newborn_head_circumference::float;


update "Meternal_Core".infant_history set expected_weight_for_the_newborn=replace (expected_weight_for_the_newborn,',','')


Alter Table "Meternal_Core".infant_history
ALTER COLUMN   newborn_weight TYPE float 
USING newborn_weight::float;

update "Meternal_Core".infant_history set newborn_weight = null
where newborn_weight='not_applicable'


update "Meternal_Core".infant_history set newborn_weight=replace (newborn_weight,',','')


Alter Table "Meternal_Core".infant_history
ALTER COLUMN  newborn_height  TYPE float 
USING newborn_height::float;

update "Meternal_Core".infant_history set newborn_height = null
where newborn_height='not_applicable'



Alter Table "Meternal_Core".infant_history
ALTER COLUMN   newborn_head_circumference TYPE float 
USING newborn_head_circumference::float;


update "Meternal_Core".infant_history set newborn_head_circumference = null
where newborn_head_circumference='not_applicable'


Alter Table "Meternal_Core".infant_history
ALTER COLUMN   thoracic_perimeter_newborn TYPE float 
USING thoracic_perimeter_newborn::float;



Alter Table "Meternal_Core".infant_history
ALTER COLUMN  apgar_first_min  TYPE int 
USING apgar_first_min::int;


Alter Table "Meternal_Core".infant_history
ALTER COLUMN  apgar_first_min  TYPE int 
USING apgar_first_min::int;

Alter Table "Meternal_Core".infant_history
ALTER COLUMN   apgar_5th_min TYPE int 
USING apgar_5th_min::int;

Alter Table "Meternal_Core".infant_history
ALTER COLUMN  pediatric_resuscitation_maneuvers TYPE int 
USING pediatric_resuscitation_maneuvers::int;

Alter Table "Meternal_Core".infant_history
ALTER COLUMN   newborn_intubation TYPE int 
USING newborn_intubation::int;



Alter Table "Meternal_Core".infant_history
ALTER COLUMN   newborn_airway_aspiration TYPE int 
USING newborn_airway_aspiration::int;


alter table "Meternal_Core".infant_history  add constraint fk_case_id  foreign key (case_id) references "Meternal_Core".Patient_Demographics

