CREATE OR REPLACE FUNCTION public.institution_honor_appearances(
    IN institution_id integer,
    OUT "ID" integer,
    OUT "Honor" character varying,
    OUT "Category" character varying,
    OUT "Type" character varying,
    OUT "Inscription ID" integer,
    OUT "IE" character varying,
    OUT "Inscription" character varying,
    OUT "Object Type" character varying,
    OUT "Inscription Type" character varying,
    OUT "Suspected Location" character varying,
    OUT "Date" real,
    OUT "Date Span" real,
    OUT "Appearances" integer,
    OUT "Text" text,
    OUT "Word Count" integer,
    OUT "Character Count" integer)
  RETURNS SETOF record AS
$BODY$
SELECT
        honor."ID" as "ID",
        honor."Honor" as "Honor",
        honor."Category" as "Category",
        honor."Type" as "Type",
        inscription_with_text."ID" AS "Inscription ID",
       inscription_with_text."IE" AS "IE",
       inscription_with_text."Title" AS "Inscription",
       inscription_with_text."Object Type" AS "Object Type",
       inscription_with_text."Inscription Type" AS "Inscription Type",
       inscription_with_text."Suspected Location" AS "Suspected Location",
       inscription_with_text."Date" AS "Date",
       inscription_with_text."Date Span" AS "Date Span",
       appearance."Appearances" AS "Appearances",
       inscription_with_text."Text" AS "Text",
       inscription_with_text."Word Count" AS "Word Count",
       inscription_with_text."Character Count" AS "Character Count"
FROM public."Institution Honor" AS institution_honor
INNER JOIN public."Honor" AS honor ON institution_honor."Honor ID" = honor."ID"
INNER JOIN public."Honor in Inscription" AS appearance ON honor."ID" = appearance."Honor ID"
INNER JOIN
    (SELECT inscription."ID" AS "ID",
            inscription."IE" AS "IE",
            inscription."Title" AS "Title",
            inscription."Object Type" AS "Object Type",
            inscription."Inscription Type" AS "Inscription Type",
            inscription."Suspected Location" AS "Suspected Location",
            inscription."Date" AS "Date",
            inscription."Date Span" AS "Date Span",
            inscription_text."Text" AS "Text",
            inscription_text."Word Count" AS "Word Count",
            inscription_text."Character Count" AS "Character Count"
     FROM public."Inscription" AS inscription
     INNER JOIN public."Text" AS inscription_text ON inscription."ID" = inscription_text."ID") AS inscription_with_text ON appearance."Inscription ID" = inscription_with_text."ID"
WHERE institution_honor."Institution ID" = institution_id
$BODY$
  LANGUAGE sql STABLE
