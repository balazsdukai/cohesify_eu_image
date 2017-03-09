-- translate NUTS3 2006 to NUTS3 2010

create or replace view nuts_tranlate_2006_2010 as
with
nuts_match as (
-- case of merge in version 2006
select a.nuts_id nuts2006, b.nuts_id nuts2010
from nuts_2006_pt a
join nuts_2010_poly b on st_within(a.geom, b.geom)
where b.stat_levl_ = 3 and a.stat_levl_ = 3
union
-- case of split in version 2006
select b.nuts_id nuts2006, a.nuts_id nuts2010
from nuts_2010_pt a
join nuts_2006_poly b on st_within(a.geom, b.geom)
where b.stat_levl_ = 3 and a.stat_levl_ = 3
)
select *
from nuts_match
order by nuts2006;

-- testing if both merges and splits are reported
with
nuts_match as (
select a.nuts_id nuts2006, b.nuts_id nuts2010
from nuts_2006_pt a
join nuts_2010_poly b on st_within(a.geom, b.geom)
where b.stat_levl_ = 3 and a.stat_levl_ = 3
union
-- case of split in version 2006
select b.nuts_id nuts2006, a.nuts_id nuts2010
from nuts_2010_pt a
join nuts_2006_poly b on st_within(a.geom, b.geom)
where b.stat_levl_ = 3 and a.stat_levl_ = 3
)
select *
from nuts_match
where nuts2006 = any(array['UKD22', 'UKE43','UKF23', 'UKG34','UKG35','UKH22','UKD51', 'UKD21', 'FI181', 'FI182', 'ITF41', 'ITF42', 'DEA21', 'DEA25'])
order by nuts2006;
