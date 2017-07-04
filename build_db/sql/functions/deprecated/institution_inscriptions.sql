CREATE FUNCTION public.institution_inscriptions(
    IN institution_id integer,
    OUT "ID" integer,
    OUT "IE" character varying,
    OUT "Title" character varying,
    OUT "Object Type" character varying,
    OUT "Inscription Type" character varying,
    OUT "Suspected Location" character varying,
    OUT "Low Date" integer,
    OUT "High Date" integer,
    OUT "Date" real,
    OUT "Date Span" real,
    OUT "Text" text,
    OUT "Word Count" integer,
    OUT "Character Count" integer
) RETURNS SETOF record AS
$BODY$
SELECT inscription_with_text."ID" AS "ID",
       inscription_with_text."IE",
       inscription_with_text."Title",
       inscription_with_text."Object Type",
       inscription_with_text."Inscription Type",
       inscription_with_text."Suspected Location",
       inscription_with_text."Low Date",
       inscription_with_text."High Date",
       inscription_with_text."Date",
       inscription_with_text."Date Span",
       inscription_with_text."Text",
       inscription_with_text."Word Count",
       inscription_with_text."Character Count"
FROM
    public."Institution Sponsorship" as appearance INNER JOIN
    (SELECT inscription."ID",
            inscription."IE",
            inscription."Title",
            inscription."Object Type",
            inscription."Inscription Type",
            inscription."Suspected Location",
            inscription."Low Date",
            inscription."High Date",
            inscription."Date",
            inscription."Date Span",
            inscription_text."Text",
            inscription_text."Word Count",
            inscription_text."Character Count"
     FROM public."Inscription" AS inscription
     INNER JOIN public."Text" AS inscription_text ON inscription."ID" = inscription_text."ID") AS inscription_with_text
ON appearance."Inscription ID" = inscription_with_text."ID"
WHERE appearance."Institution ID" = institution_id
$BODY$
LANGUAGE sql STABLE NOT LEAKPROOF;
