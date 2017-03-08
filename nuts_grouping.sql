drop view nuts_2006_levels;
create or replace view nuts_2006_levels as
with lvl0 as(
select nuts_id, geom
from nuts_2006_poly2
where stat_levl_ = 0
),
lvl1 as (
select nuts_id, geom
from nuts_2006_poly2
where stat_levl_ = 1
),
lvl2 as (
select nuts_id, geom
from nuts_2006_poly2
where stat_levl_ = 2
),
lvl3 as (
select nuts_id, geom
from nuts_2006_poly2
where stat_levl_ = 3
)
select distinct
lvl0.nuts_id id0,
lvl1.nuts_id id1,
lvl2.nuts_id id2,
lvl3.nuts_id id3
from lvl0
left join lvl1 on st_covers(lvl0.geom, lvl1.geom)
left join lvl2 on st_covers(lvl1.geom, lvl2.geom)
left join lvl3 on st_covers(lvl2.geom, lvl3.geom);

-- NUTS 2010
create or replace view nuts_2010_levels as
with
lvl0 as (
select nuts_id id0
from nuts_2010_poly
where stat_levl_ = 0
),
lvl1 as (
select a.*, b.nuts_id id1
from lvl0 a
join nuts_2010_poly b on a.id0 = substring(b.nuts_id,1,2)
where b.stat_levl_ = 1
),
lvl2 as (
select a.*, b.nuts_id id2
from lvl1 a
join nuts_2010_poly b on a.id1 = substring(b.nuts_id,1,3)
where b.stat_levl_ = 2
)
select a.*, b.nuts_id id3
from lvl2 a
join nuts_2010_poly b on a.id2 = substring(b.nuts_id,1,4)
where b.stat_levl_ = 3
order by a.id0, a.id1, a.id2, b.nuts_id;