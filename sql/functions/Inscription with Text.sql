CREATE FUNCTION public."Inscription with Text"(
    OUT "ID" INTEGER,
    OUT "IE" CHARACTER VARYING,
    OUT "Inscription" CHARACTER VARYING,
    OUT "Object Type" CHARACTER VARYING,
    OUT "Inscription Type" CHARACTER VARYING,
    OUT "Location" CHARACTER VARYING,
    OUT "Date" REAL,
    OUT "Date Span" REAL,
    OUT "Text" TEXT,
    OUT "Word Count" INTEGER,
    OUT "Character Count" INTEGER
) RETURNS SETOF record AS
$BODY$
SELECT inscription."ID" AS "ID",
       inscription."IE" AS "IE",
       inscription."Inscription" AS "Inscription",
       inscription."Object Type" AS "Object Type",
       inscription."Inscription Type" AS "Inscription Type",
       inscription."Suspected Location" AS "Location",
       inscription."Date" AS "Date",
       inscription."Date Span" AS "Date Span",
       inscription_text."Text" AS "Text",
       inscription_text."Word Count" AS "Word Count",
       inscription_text."Character Count" AS "Character Count"
FROM public."Inscription" AS inscription
INNER JOIN public."Text" AS inscription_text ON inscription."ID" = inscription_text."ID"
$BODY$
LANGUAGE sql STABLE NOT LEAKPROOF;
