drop VIEW nuts_2006_levels;

CREATE
    OR REPLACE VIEW nuts_2006_levels AS WITH lvl0 AS(
        SELECT
            nuts_id,
            geom
        FROM
            nuts_2006_poly2
        WHERE
            stat_levl_ = 0
    ),
    lvl1 AS(
        SELECT
            nuts_id,
            geom
        FROM
            nuts_2006_poly2
        WHERE
            stat_levl_ = 1
    ),
    lvl2 AS(
        SELECT
            nuts_id,
            geom
        FROM
            nuts_2006_poly2
        WHERE
            stat_levl_ = 2
    ),
    lvl3 AS(
        SELECT
            nuts_id,
            geom
        FROM
            nuts_2006_poly2
        WHERE
            stat_levl_ = 3
    ) SELECT
        DISTINCT lvl0.nuts_id id0,
        lvl1.nuts_id id1,
        lvl2.nuts_id id2,
        lvl3.nuts_id id3
    FROM
        lvl0
    LEFT JOIN lvl1 ON
        st_covers(
            lvl0.geom,
            lvl1.geom
        )
    LEFT JOIN lvl2 ON
        st_covers(
            lvl1.geom,
            lvl2.geom
        )
    LEFT JOIN lvl3 ON
        st_covers(
            lvl2.geom,
            lvl3.geom
        );

-- NUTS 2010
-- spatial search doesn't work for NUTS2010, because FR91 is not
-- covered by higher level regions, probably a data error
CREATE
    OR REPLACE VIEW nuts_2010_levels AS WITH lvl0 AS(
        SELECT
            nuts_id id0
        FROM
            nuts_2010_poly
        WHERE
            stat_levl_ = 0
    ),
    lvl1 AS(
        SELECT
            a.*,
            b.nuts_id id1
        FROM
            lvl0 a
        JOIN nuts_2010_poly b ON
            a.id0 = SUBSTRING( b.nuts_id, 1, 2 )
        WHERE
            b.stat_levl_ = 1
    ),
    lvl2 AS(
        SELECT
            a.*,
            b.nuts_id id2
        FROM
            lvl1 a
        JOIN nuts_2010_poly b ON
            a.id1 = SUBSTRING( b.nuts_id, 1, 3 )
        WHERE
            b.stat_levl_ = 2
    ) SELECT
        a.*,
        b.nuts_id id3
    FROM
        lvl2 a
    JOIN nuts_2010_poly b ON
        a.id2 = SUBSTRING( b.nuts_id, 1, 4 )
    WHERE
        b.stat_levl_ = 3
    ORDER BY
        a.id0,
        a.id1,
        a.id2,
        b.nuts_id;