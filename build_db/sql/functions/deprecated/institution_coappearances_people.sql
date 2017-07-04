CREATE FUNCTION public.institution_coappearances_people(
    IN institution_id integer,
    OUT "Person ID" integer,
    OUT "Person" character varying,
    OUT "Origin" character varying,
    OUT "Gender" character varying,
    OUT "Athenian Citizen" boolean,
    OUT "Roman Citizen" boolean,
    OUT "Family" character varying,
    OUT "Extended" character varying,
    OUT "Demotic" character varying,
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
       coappearer."Name" AS "Person",
       coappearer."Origin" AS "Origin",
       coappearer."Gender" AS "Gender",
       coappearer."Athenian Citizen" AS "Athenian Citizen",
       coappearer."Roman Citizen" AS "Roman Citizen",
       coappearer."Family" AS "Family",
       coappearer."Extended" AS "Extended",
       coappearer."Demotic" AS "Demotic",
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
INNER JOIN public."Person in Inscription" AS coappearance ON institution_sponsorship."Inscription ID" = coappearance."Inscription ID"
INNER JOIN public."Person" AS coappearer ON coappearance."Person ID" = coappearer."ID"
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
