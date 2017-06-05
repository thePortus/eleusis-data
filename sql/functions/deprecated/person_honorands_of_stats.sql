CREATE FUNCTION public.person_honorands_of_stats(
    IN person_id integer,
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
FROM (((public."Person" AS person
        INNER JOIN public."Person in Inscription" AS person_appearance ON person_appearance."Person ID" = Person."ID")
       INNER JOIN public."Person in Inscription" AS coappearance ON person_appearance."Inscription ID" = coappearance."Inscription ID"
       AND person_appearance."Person ID" != coappearance."Person ID"
       AND coappearance."Role" = 'Honoree')
      INNER JOIN public."Person" AS honorand ON coappearance."Person ID" = honorand."ID")
WHERE person."ID" = person_id
    AND person_appearance."Role" = 'Sponsor'
$BODY$
LANGUAGE sql STABLE NOT LEAKPROOF;
