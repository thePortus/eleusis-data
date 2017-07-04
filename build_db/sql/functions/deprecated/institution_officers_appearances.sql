CREATE FUNCTION public.institution_officers_appearances(
    IN institution_id integer,
    OUT "Officer ID" integer,
    OUT "Officer" character varying,
    OUT "Origin" character varying,
    OUT "Gender" character varying,
    OUT "Athenian Citizen" boolean,
    OUT "Roman Citizen" boolean,
    OUT "Family" character varying,
    OUT "Extended" character varying,
    OUT "Demotic" character varying,
    OUT "Role" character varying,
    OUT "Honor ID" integer,
    OUT "Honor" character varying,
    OUT "Honor Appearances" integer,
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
SELECT officer."ID" AS "Officer ID",
       officer."Name" AS "Officer",
       officer."Origin" AS "Origin",
       officer."Gender" AS "Gender",
       officer."Athenian Citizen" AS "Athenian Citizen",
       officer."Roman Citizen" AS "Roman Citizen",
       officer."Family" AS "Family",
       officer."Extended" AS "Extended",
       officer."Demotic" AS "Demotic",
       person_appearance."Role" AS "Role",
       honor."ID" AS "Honor ID",
       honor."Honor" AS "Honor",
       person_honor."Appearances" AS "Honor Appearances",
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
FROM public."Institution Honor" AS institution_honor
INNER JOIN public."Honor" honor ON institution_honor."Honor ID" = honor."ID"
INNER JOIN public."Person Honor Display" AS person_honor ON honor."ID" = person_honor."Honor ID" INNER JOIN public."Person in Inscription" AS person_appearance ON person_honor."Person ID" = person_appearance."Person ID"
AND person_honor."Inscription ID" = person_appearance."Inscription ID"
INNER JOIN public."Person" AS officer ON person_honor."Person ID" = officer."ID"
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
     INNER JOIN public."Text" AS inscription_text ON inscription."ID" = inscription_text."ID") AS inscription_with_text ON person_honor."Inscription ID" = inscription_with_text."ID"
WHERE institution_honor."Institution ID" = institution_id
$BODY$
  LANGUAGE sql STABLE
