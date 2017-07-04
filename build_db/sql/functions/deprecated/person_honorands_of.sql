CREATE FUNCTION public.person_honorands_of(
    IN person_id integer,
    OUT "ID" integer,
    OUT "Name" character varying,
    OUT "Origin" character varying,
    OUT "Gender" character varying,
    OUT "Athenian Citizen" boolean,
    OUT "Roman Citizen" boolean,
    OUT "Family" character varying,
    OUT "Extended" character varying,
    OUT "Demotic" character varying
) RETURNS SETOF record AS
$BODY$
SELECT honorand."ID",
       honorand."Name",
       honorand."Origin",
       honorand."Gender",
       honorand."Athenian Citizen",
       honorand."Roman Citizen",
       honorand."Family",
       honorand."Extended",
       honorand."Demotic"
FROM (((public."Person" AS person
        INNER JOIN public."Person in Inscription" AS person_appearance ON person_appearance."Person ID" = Person."ID")
       INNER JOIN public."Person in Inscription" AS coappearance ON person_appearance."Inscription ID" = coappearance."Inscription ID"
       AND person_appearance."Person ID" != coappearance."Person ID" AND coappearance."Role" = 'Honoree')
      INNER JOIN public."Person" AS honorand ON coappearance."Person ID" = honorand."ID")
WHERE person."ID" = person_id AND person_appearance."Role" = 'Sponsor'
$BODY$
LANGUAGE sql STABLE NOT LEAKPROOF;
