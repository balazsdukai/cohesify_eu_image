CREATE TABLE nuts_2010_poly2 AS                       --poly will be the new polygon table
WITH dump AS (
    SELECT id, stat_levl_, nuts_id,                       --columns from your multipolygon table 
      (ST_DUMP(geom)).geom AS geom 
    FROM nuts_2010_poly                             --the name of your multipolygon table
) 
SELECT id, stat_levl_, nuts_id, 
  st_makevalid(geom::geometry(Polygon,4258)) geom         --type cast using SRID from multipolygon
FROM dump;
create index nuts_2010_poly2_nuts_id_idx on nuts_2010_poly2 using btree (nuts_id);
create index nuts_2010_poly2_geom_idx on nuts_2010_poly2 using gist (geom);

CREATE TABLE nuts_2010_poly3 AS                       --poly will be the new polygon table
SELECT id, stat_levl_, nuts_id, 
  st_makevalid(geom) geom         --type cast using SRID from multipolygon
FROM nuts_2010_poly;
create index nuts_2010_poly3_nuts_id_idx on nuts_2010_poly3 using btree (nuts_id);
create index nuts_2010_poly3_geom_idx on nuts_2010_poly3 using gist (geom);