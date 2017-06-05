CREATE FUNCTION public.institution_honorands_of(
    IN institution_id integer,
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
FROM (((public."Institution" AS institution
        INNER JOIN public."Institution Sponsorship" AS institution_sponsorship ON institution_sponsorship."Institution ID" = institution."ID")
       INNER JOIN public."Person in Inscription" AS coappearance ON institution_sponsorship."Inscription ID" = coappearance."Inscription ID"
       AND coappearance."Role" = 'Honoree')
      INNER JOIN public."Person" AS honorand ON coappearance."Person ID" = honorand."ID")
WHERE institution."ID" = institution_id
$BODY$
LANGUAGE sql STABLE NOT LEAKPROOF;
