DROP FUNCTION IF EXISTS public."Inscription Institutions Stats";
CREATE FUNCTION public."Inscription Institutions Stats"(
    OUT "Inscription ID" integer,
    OUT "Total Institutions" bigint,
    OUT "Institution Sponsors" bigint,
    OUT "Public Institutions" bigint,
    OUT "Private Institutions" bigint,
    OUT "Gene" bigint,
    OUT "Athenian Institutions" bigint,
    OUT "Roman Institutions" bigint,
    OUT "Other/Greek Institutions" bigint
) RETURNS SETOF record AS
$BODY$
SELECT institution_sponsorship."Inscription ID" AS "Inscription ID",
        COUNT(DISTINCT institution."ID") AS "Total Institutions",
        SUM(CASE
                WHEN institution_sponsorship."Role" = 'Sponsor' THEN 1
                ELSE 0
            END) AS "Institution Sponsors",
        SUM(CASE
                WHEN institution."Type" = 'Public' THEN 1
                ELSE 0
            END) AS "Public Institutions",
        SUM(CASE
                WHEN institution."Type" = 'Private' THEN 1
                ELSE 0
            END) AS "Private Institutions",
        SUM(CASE
                WHEN institution."Type" = 'Genos' THEN 1
                ELSE 0
            END) AS "Gene",
        SUM(CASE
                WHEN institution."Category" = 'Athenian'
                     OR institution."Category" = 'Eleusinian' THEN 1
                ELSE 0
            END) AS "Athenian Institutions",
        SUM(CASE
                WHEN institution."Category" = 'Roman' THEN 1
                ELSE 0
            END) AS "Roman Institutions",
        SUM(CASE
                WHEN institution."Category" = 'Greek'
                     OR institution."Category" = 'Panhellenic'
                     OR institution."Category" = 'Other' THEN 1
                ELSE 0
            END) AS "Other/Greek Institutions"
 FROM public."Institution Sponsorship" AS institution_sponsorship
 INNER JOIN public."Institution" AS institution ON institution_sponsorship."Institution ID" = institution."ID"
 GROUP BY institution_sponsorship."Inscription ID"
 $BODY$
 LANGUAGE sql STABLE NOT LEAKPROOF;
