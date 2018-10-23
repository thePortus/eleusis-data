CREATE FUNCTION public."Persons on Institution Inscriptions Stats"(
    OUT "Person ID" CHARACTER VARYING,
    OUT "As Institution Honorand" bigint,
    OUT "As Institution Non-Honorand" bigint,
    OUT "As Public Honorand" bigint,
    OUT "As Public Non-Honorand" bigint,
    OUT "As Private Honorand" bigint,
    OUT "As Private Non-Honorand" bigint,
    OUT "As Genos Honorand" bigint,
    OUT "As Genos Non-Honorand" bigint,
    OUT "As Areopagus Honorand" bigint,
    OUT "As Areopagus Non-Honorand" bigint,
    OUT "As Boule Honorand" bigint,
    OUT "As Boule Non-Honorand" bigint,
    OUT "As Demos Honorand" bigint,
    OUT "As Demos Non-Honorand" bigint,
    OUT "As Eumolpidai Honorand" bigint,
    OUT "As Eumolpidai Non-Honorand" bigint,
    OUT "As Kerykes Honorand" bigint,
    OUT "As Kerykes Non-Honorand" bigint
) RETURNS SETOF record AS
$BODY$
SELECT person_appearance."Person ID" AS "Person ID",
       COUNT(DISTINCT CASE
                          WHEN person_appearance."Role" = 'Honorand' THEN person_appearance."Inscription ID"
                      END) AS "As Institution Honorand",
       COUNT(DISTINCT CASE
                          WHEN person_appearance."Role" != 'Honorand' THEN person_appearance."Inscription ID"
                      END) AS "As Institution Non-Honorand",
       COUNT(DISTINCT CASE
                          WHEN person_appearance."Role" = 'Honorand'
                               AND institution."Type" = 'Public' THEN person_appearance."Inscription ID"
                      END) AS "As Public Honorand",
       COUNT(DISTINCT CASE
                          WHEN person_appearance."Role" != 'Honorand'
                               AND institution."Type" = 'Public' THEN person_appearance."Inscription ID"
                      END) AS "As Public Non-Honorand",
       COUNT(DISTINCT CASE
                          WHEN person_appearance."Role" = 'Honorand'
                               AND institution."Type" = 'Private' THEN person_appearance."Inscription ID"
                      END) AS "As Private Honorand",
       COUNT(DISTINCT CASE
                          WHEN person_appearance."Role" != 'Honorand'
                               AND institution."Type" = 'Private' THEN person_appearance."Inscription ID"
                      END) AS "As Private Non-Honorand",
       COUNT(DISTINCT CASE
                          WHEN person_appearance."Role" = 'Honorand'
                               AND institution."Type" = 'Genos' THEN person_appearance."Inscription ID"
                      END) AS "As Genos Honorand",
       COUNT(DISTINCT CASE
                          WHEN person_appearance."Role" != 'Honorand'
                               AND institution."Type" = 'Genos' THEN person_appearance."Inscription ID"
                      END) AS "As Genos Non-Honorand",
       COUNT(DISTINCT CASE
                          WHEN person_appearance."Role" = 'Honorand'
                               AND institution."Institution" = 'Areopagus' THEN person_appearance."Inscription ID"
                      END) AS "As Areopagus Honorand",
       COUNT(DISTINCT CASE
                          WHEN person_appearance."Role" != 'Honorand'
                               AND institution."Institution" = 'Areopagus' THEN person_appearance."Inscription ID"
                      END) AS "As Areopagus Non-Honorand",
       COUNT(DISTINCT CASE
                          WHEN person_appearance."Role" = 'Honorand'
                               AND institution."Institution" = 'Boule' THEN person_appearance."Inscription ID"
                      END) AS "As Boule Honorand",
       COUNT(DISTINCT CASE
                          WHEN person_appearance."Role" != 'Honorand'
                               AND institution."Institution" = 'Boule' THEN person_appearance."Inscription ID"
                      END) AS "As Boule Non-Honorand",
       COUNT(DISTINCT CASE
                          WHEN person_appearance."Role" = 'Honorand'
                               AND institution."Institution" = 'Demos' THEN person_appearance."Inscription ID"
                      END) AS "As Demos Honorand",
       COUNT(DISTINCT CASE
                          WHEN person_appearance."Role" != 'Honorand'
                               AND institution."Institution" = 'Demos' THEN person_appearance."Inscription ID"
                      END) AS "As Demos Non-Honorand",
       COUNT(DISTINCT CASE
                          WHEN person_appearance."Role" = 'Honorand'
                               AND institution."Institution" = 'Eumolpidai' THEN person_appearance."Inscription ID"
                      END) AS "As Eumolpidai Honorand",
       COUNT(DISTINCT CASE
                          WHEN person_appearance."Role" != 'Honorand'
                               AND institution."Institution" = 'Eumolpidai' THEN person_appearance."Inscription ID"
                      END) AS "As Eumolpidai Non-Honorand",
       COUNT(DISTINCT CASE
                          WHEN person_appearance."Role" = 'Honorand'
                               AND institution."Institution" = 'Kerykes' THEN person_appearance."Inscription ID"
                      END) AS "As Kerykes Honorand",
       COUNT(DISTINCT CASE
                          WHEN person_appearance."Role" != 'Honorand'
                               AND institution."Institution" = 'Kerykes' THEN person_appearance."Inscription ID"
                      END) AS "As Kerykes Non-Honorand"
FROM (public."Person in Inscription" AS person_appearance
      INNER JOIN public."Institution Sponsorship" AS institution_sponsorship ON person_appearance."Inscription ID" = institution_sponsorship."Inscription ID"
      INNER JOIN public."Institution" AS institution ON institution_sponsorship."Institution ID" = institution."ID")
GROUP BY person_appearance."Person ID"
$BODY$
LANGUAGE sql STABLE NOT LEAKPROOF;
