CREATE TABLE
    nuts_2010_poly2 AS --poly will be the new polygon table
    WITH dump AS(
        SELECT
            gid,
            stat_levl_,
            nuts_id,
            --columns from your multipolygon table 
            (
                ST_DUMP(geom)
            ).geom AS geom
        FROM
            nuts_2010_poly --the name of your multipolygon table

    ) SELECT
        gid,
        stat_levl_,
        nuts_id,
        st_makevalid(
            geom::geometry(
                Polygon,
                4258
            )
        ) geom --type cast using SRID from multipolygon

    FROM
        dump;

CREATE
    INDEX nuts_2010_poly2_nuts_id_idx ON
    nuts_2010_poly2
        USING btree(nuts_id);

CREATE
    INDEX nuts_2010_poly2_geom_idx ON
    nuts_2010_poly2
        USING gist(geom);

CREATE
    TABLE
        nuts_2010_poly3 AS --poly will be the new polygon table
        SELECT
            gid,
            stat_levl_,
            nuts_id,
            st_makevalid(geom) geom --type cast using SRID from multipolygon

        FROM
            nuts_2010_poly;

CREATE
    INDEX nuts_2010_poly3_nuts_id_idx ON
    nuts_2010_poly3
        USING btree(nuts_id);

CREATE
    INDEX nuts_2010_poly3_geom_idx ON
    nuts_2010_poly3
        USING gist(geom);
        
        






