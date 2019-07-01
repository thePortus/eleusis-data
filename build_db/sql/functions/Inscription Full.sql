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
    OUT "Raw Text" TEXT,
    OUT "Lemmata" TEXT,
    OUT "Features" TEXT,
    OUT "References" CHARACTER VARYING
) RETURNS SETOF record AS
$BODY$
SELECT inscription."ID" AS "ID",
       inscription."IE" AS "IE",
       inscription."Inscription" AS "Inscription",
       inscription."Object Type" AS "Object Type",
       inscription."Inscription Type" AS "Inscription Type",
       inscription."Location" AS "Location",
       inscription."Date" AS "Date",
       inscription."Date Span" AS "Date Span",
       inscription_text."Word Count" AS "Word Count",
       inscription_text."Character Count" AS "Character Count",
       inscription_text."Text" AS "Text",
       inscription_text."Raw Text" AS "Raw Text",
       inscription_text."Lemmata" AS "Lemmata",
       features."Features" AS "Features",
       reference."References" AS "References"
-- Inscription
FROM public."Inscription" AS inscription
-- Inscription Text
INNER JOIN public."Text" AS inscription_text ON inscription."ID" = inscription_text."ID"
-- Inscription References
LEFT JOIN (
    SELECT
    inscription_references."Inscription ID" AS "ID",
    string_agg(inscription_references."Reference", ',') AS "References"
    FROM
    (SELECT reference."Inscription ID" AS "Inscription ID",
           concat_ws(' ', reference."Publication", reference."Number", reference."Additional") AS "Reference",
           reference."Notes" AS "Notes"
    FROM public."Inscription Reference" AS reference) AS inscription_references
    GROUP BY inscription_references."Inscription ID"
) AS reference ON inscription."ID" = reference."ID"
-- Inscription Features
LEFT JOIN (
    SELECT
    inscription_features."Inscription ID" AS "ID",
    string_agg(inscription_features."Feature", ', ') AS "Features"
    FROM public."Inscription Feature" AS inscription_features
    GROUP BY inscription_features."Inscription ID"
) AS features ON inscription."ID" = features."ID"
$BODY$
LANGUAGE sql STABLE NOT LEAKPROOF;
