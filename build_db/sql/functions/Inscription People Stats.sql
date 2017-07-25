DROP FUNCTION IF EXISTS public."Inscription People Stats";
CREATE FUNCTION public."Inscription People Stats"(
    OUT "Inscription ID" integer,
    OUT "People" bigint,
    OUT "Females" bigint,
    OUT "Males" bigint,
    OUT "Athenians" bigint,
    OUT "Romans" bigint,
    OUT "Imperial Family" bigint,
    OUT "Greeks" bigint,
    OUT "Athenians without Roman Citizenship" bigint,
    OUT "Athenians with Roman Citizenship" bigint,
    OUT "Individual Sponsors" bigint,
    OUT "Honorands" bigint
) RETURNS SETOF record AS
$BODY$
SELECT person_appearance."Inscription ID" AS "Inscription ID",
        COUNT(DISTINCT person."ID") AS "People",
        COUNT(DISTINCT CASE
                           WHEN person."Gender" = 'Female' THEN person."ID"
                       END) AS "Females",
        COUNT(DISTINCT CASE
                           WHEN person."Gender" = 'Male' THEN person."ID"
                       END) AS "Males",
        COUNT(DISTINCT CASE
                           WHEN person."Category" = 'Athenian' THEN person."ID"
                       END) AS "Athenians",
        COUNT(DISTINCT CASE
                           WHEN person."Category" = 'Roman' THEN person."ID"
                       END) AS "Romans",
        COUNT(DISTINCT CASE
                           WHEN person."Category" = 'Imperial Family' THEN person."ID"
                       END) AS "Imperial Family",
        COUNT(DISTINCT CASE
                           WHEN person."Category" = 'Other Greek' THEN person."ID"
                       END) AS "Greeks",
        COUNT(DISTINCT CASE
                           WHEN person."Category" = 'Athenian'
                                AND person."Roman Citizen" = FALSE THEN person."ID"
                       END) AS "Athenians without Roman Citizenship",
        COUNT(DISTINCT CASE
                           WHEN person."Category" = 'Athenian'
                                AND person."Roman Citizen" = TRUE THEN person."ID"
                       END) AS "Athenians with Roman Citizenship",
        COUNT(DISTINCT CASE
                           WHEN person_appearance."Role" = 'Sponsor' THEN person."ID"
                       END) AS "Sponsors",
        COUNT(DISTINCT CASE
                           WHEN person_appearance."Role" = 'Honorand' THEN person."ID"
                       END) AS "Honorands"
 FROM public."Person in Inscription" AS person_appearance
 INNER JOIN public."Person" AS person ON person_appearance."Person ID" = person."ID"
 GROUP BY person_appearance."Inscription ID"
 $BODY$
 LANGUAGE sql STABLE NOT LEAKPROOF;
