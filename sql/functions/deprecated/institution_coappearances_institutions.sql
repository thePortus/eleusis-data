CREATE FUNCTION public.institution_coappearances_institutions(
    IN institution_id integer,
    OUT "Institution ID" integer,
    OUT "Institution" character varying,
    OUT "Origin" character varying,
    OUT "Type" character varying,
    OUT "Role" character varying,
    OUT "Inscription ID" integer,
    OUT "IE" character varying,
    OUT "Inscription" character varying,
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
SELECT coappearer."ID" AS "Person ID",
       coappearer."Name" AS "Institution",
       coappearer."Origin" AS "Origin",
       coappearer."Type" AS "Gender",
       coappearance."Role" AS "Role",
       inscription_with_text."ID" AS "Inscription ID",
       inscription_with_text."IE" AS "IE",
       inscription_with_text."Title" AS "Inscription",
       inscription_with_text."Object Type" AS "Object Type",
       inscription_with_text."Inscription Type" AS "Inscription Type",
       inscription_with_text."Suspected Location" AS "Suspected Location",
       inscription_with_text."Low Date" AS "Low Date",
       inscription_with_text."High Date" AS "High Date",
       inscription_with_text."Date" AS "Date",
       inscription_with_text."Date Span" AS "Date Span",
       inscription_with_text."Text" AS "Text",
       inscription_with_text."Word Count" AS "Word Count",
       inscription_with_text."Character Count" AS "Character Count"
FROM public."Institution Sponsorship" AS institution_sponsorship
INNER JOIN public."Institution Sponsorship" AS coappearance ON institution_sponsorship."Inscription ID" = coappearance."Inscription ID" AND institution_sponsorship."Institution ID" != coappearance."Institution ID"
INNER JOIN public."Institution" AS coappearer ON coappearance."Institution ID" = coappearer."ID"
INNER JOIN
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
     INNER JOIN public."Text" AS inscription_text ON inscription."ID" = inscription_text."ID") AS inscription_with_text ON coappearance."Inscription ID" = inscription_with_text."ID"
WHERE institution_sponsorship."Institution ID" = institution_id
$BODY$
  LANGUAGE sql STABLE
