CREATE FUNCTION public."Inscription Full"(
    OUT "ID" INTEGER,
    OUT "IE" CHARACTER VARYING,
    OUT "Inscription" CHARACTER VARYING,
    OUT "Object Type" CHARACTER VARYING,
    OUT "Inscription Type" CHARACTER VARYING,
    OUT "Location" CHARACTER VARYING,
    OUT "Date" REAL,
    OUT "Date Span" REAL,
    OUT "Word Count" INTEGER,
    OUT "Character Count" INTEGER,
    OUT "Text" TEXT,
    OUT "References" CHARACTER VARYING
) RETURNS SETOF record AS
$BODY$
SELECT
inscription."ID" as "ID",
inscription."IE" AS "IE",
inscription."Inscription" as "Inscription",
inscription."Object Type" AS "Object Type",
inscription."Inscription Type" AS "Inscription Type",
inscription."Location" AS "Location",
inscription."Date" AS "Date",
inscription."Date Span" AS "Date Span",
inscription."Word Count" AS "Word Count",
inscription."Character Count" AS "Character Count",
inscription."Text" AS "Text",
reference."References" AS "References"
FROM
public."Inscription with Text"() AS inscription
LEFT JOIN public."Inscription with References"() as reference ON inscription."ID" = reference."ID"
$BODY$
LANGUAGE sql STABLE NOT LEAKPROOF;
