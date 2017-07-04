CREATE FUNCTION public.institution_honorands_of_stats(
    IN institution_id integer,
    OUT "People" bigint,
    OUT "Athenians" bigint,
    OUT "Romans" bigint,
    OUT "Imperial Family" bigint,
    OUT "Greeks" bigint,
    OUT "Other/Uncertain" bigint,
    OUT "Females" bigint,
    OUT "Males" bigint,
    OUT "Athenian Citizens" bigint,
    OUT "Roman Citizens" bigint
) RETURNS record AS
$BODY$
SELECT COUNT(honorand."ID") AS "People",
       COUNT(CASE
                 WHEN honorand."Category" = 'Athenian' THEN 1
             END) AS "Athenians",
       COUNT(CASE
                 WHEN honorand."Category" = 'Roman' THEN 1
             END) AS "Romans",
       COUNT(CASE
                 WHEN honorand."Category" = 'Imperial Family Member' THEN 1
             END) AS "Imperial Family",
       COUNT(CASE
                 WHEN honorand."Category" = 'Greek'
                      OR honorand."Category" = 'Other Greek' THEN 1
             END) AS "Other Greeks",
       COUNT(CASE
                 WHEN honorand."Category" = 'Other'
                      OR honorand."Category" = 'Uncertain' THEN 1
             END) AS "Others/Uncertain",
       COUNT(CASE
                 WHEN honorand."Gender" = 'Female' THEN 1
             END) AS "Females",
       COUNT(CASE
                 WHEN honorand."Gender" = 'Male' THEN 1
             END) AS "Males",
       COUNT(CASE
                 WHEN honorand."Athenian Citizen" = TRUE THEN 1
             END) AS "Athenian Citizens",
       COUNT(CASE
                 WHEN honorand."Roman Citizen" = TRUE THEN 1
             END) AS "Roman Citizens"
FROM (((public."Institution" AS institution
        INNER JOIN public."Institution Sponsorship" AS institution_sponsorship ON institution_sponsorship."Institution ID" = institution."ID")
       INNER JOIN public."Person in Inscription" AS coappearance ON institution_sponsorship."Inscription ID" = coappearance."Inscription ID"
       AND coappearance."Role" = 'Honoree')
      INNER JOIN public."Person" AS honorand ON coappearance."Person ID" = honorand."ID")
WHERE institution."ID" = institution_id
$BODY$
LANGUAGE sql STABLE NOT LEAKPROOF;
