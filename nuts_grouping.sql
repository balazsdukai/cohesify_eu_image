create or replace view nuts_2006_levels as
with lvl0 as(
select nuts_id, geom
from nuts_2006_poly
where stat_levl_ = 0
group by id
),
lvl1 as (
select nuts_id, geom
from nuts_2006_poly
where stat_levl_ = 1
group by id
),
lvl2 as (
select nuts_id, geom
from nuts_2006_poly
where stat_levl_ = 2
group by id
),
lvl3 as (
select nuts_id, geom
from nuts_2006_poly
where stat_levl_ = 3
group by id
)
select lvl0.nuts_id id0, lvl1.nuts_id id1, lvl2.nuts_id id2, lvl3.nuts_id id3
from lvl0, lvl1, lvl2, lvl3
where st_covers(lvl0.geom, lvl1.geom) and st_covers(lvl1.geom, lvl2.geom)
 and st_covers(lvl2.geom, lvl3.geom);
