 -- translate NUTS3 2006 to NUTS3 2010
CREATE
    OR replace VIEW nuts_translate_2006_2010 AS WITH nuts_match AS(
        -- case of merge in version 2006
        SELECT
            a.nuts_id nuts2006,
            b.nuts_id nuts2010
        FROM
            nuts_2006_pt a
        JOIN nuts_2010_poly b ON
            st_within(
                a.geom,
                b.geom
            )
        WHERE
            b.stat_levl_ = 3
            AND a.stat_levl_ = 3
    UNION 
        -- case of split in version 2006
        SELECT
            b.nuts_id nuts2006,
            a.nuts_id nuts2010
        FROM
            nuts_2010_pt a
        JOIN nuts_2006_poly b ON
            st_within(
                a.geom,
                b.geom
            )
        WHERE
            b.stat_levl_ = 3
            AND a.stat_levl_ = 3
    ) SELECT
        *
    FROM
        nuts_match
    ORDER BY
        nuts2006;
        
-- USE POLYGON OVERLAP
﻿ -- translate NUTS3 2006 to NUTS3 2010
CREATE
    OR replace VIEW nuts_translate_2006_2010 AS WITH nuts_match AS(
        -- case of merge in version 2006
        SELECT
            a.nuts_id nuts2006,
            b.nuts_id nuts2010
        FROM
            nuts_2006_pt a
        JOIN nuts_2010_poly b ON
            st_within(
                a.geom,
                b.geom
            )
        WHERE
            b.stat_levl_ = 3
            AND a.stat_levl_ = 3
    UNION 
        -- case of split in version 2006
        SELECT
            b.nuts_id nuts2006,
            a.nuts_id nuts2010
        FROM
            nuts_2010_pt a
        JOIN nuts_2006_poly b ON
            st_within(
                a.geom,
                b.geom
            )
        WHERE
            b.stat_levl_ = 3
            AND a.stat_levl_ = 3
    ) SELECT
        *
    FROM
        nuts_match
    ORDER BY
        nuts2006;

-- testing if both merges and splits are reported
WITH nuts_match AS(
    SELECT
        a.nuts_id nuts2006,
        b.nuts_id nuts2010
    FROM
        nuts_2006_pt a
    JOIN nuts_2010_poly b ON
        st_within(
            a.geom,
            b.geom
        )
    WHERE
        b.stat_levl_ = 3
        AND a.stat_levl_ = 3
UNION -- case of split in version 2006
    SELECT
        b.nuts_id nuts2006,
        a.nuts_id nuts2010
    FROM
        nuts_2010_pt a
    JOIN nuts_2006_poly b ON
        st_within(
            a.geom,
            b.geom
        )
    WHERE
        b.stat_levl_ = 3
        AND a.stat_levl_ = 3
) SELECT
    *
FROM
    nuts_match
WHERE
    nuts2006 = ANY(
        array['UKD22',
        'UKE43',
        'UKF23',
        'UKG34',
        'UKG35',
        'UKH22',
        'UKD51',
        'UKD21',
        'FI181',
        'FI182',
        'ITF41',
        'ITF42',
        'DEA21',
        'DEA25' ]
    )
ORDER BY
    nuts2006;
