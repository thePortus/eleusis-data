CREATE FUNCTION public.person_inscriptions(
    IN person_id integer,
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
    OUT "Role" character varying,
    OUT "Text" text,
    OUT "Word Count" integer,
    OUT "Character Count" integer
) RETURNS SETOF record AS
$BODY$
SELECT inscription."ID",
       inscription."IE",
       inscription."Title",
       inscription."Object Type",
       inscription."Inscription Type",
       inscription."Suspected Location",
       inscription."Low Date",
       inscription."High Date",
       inscription."Date",
       inscription."Date Span",
       appearance."Role",
       inscription_text."Text",
       inscription_text."Word Count",
       inscription_text."Character Count"
       FROM (public."Inscription" AS inscription INNER JOIN public."Text" as inscription_text ON inscription."ID" = inscription_text."ID" INNER JOIN public."Person in Inscription" AS appearance ON appearance."Inscription ID" = inscription."ID")
       WHERE appearance."Person ID" = person_id
$BODY$
LANGUAGE sql STABLE NOT LEAKPROOF;
