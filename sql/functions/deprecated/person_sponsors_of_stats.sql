CREATE FUNCTION public.person_sponsors_of_stats(
    IN person_id integer,
    OUT "Institutions" numeric,
    OUT "People" numeric,
    OUT "Athenians" numeric,
    OUT "Romans" numeric,
    OUT "Imperial Family" numeric,
    OUT "Greeks" numeric,
    OUT "Panhellenic" numeric,
    OUT "Other/Uncertain" numeric,
    OUT "Public Institutions" numeric,
    OUT "Private Institutions" numeric,
    OUT "Gene" numeric,
    OUT "Females" numeric,
    OUT "Males" numeric,
    OUT "Athenian Citizens" numeric,
    OUT "Roman Citizens" numeric
) RETURNS record AS
$BODY$
SELECT SUM(sponsors."Institutions") AS "Institutions",
       SUM(sponsors."People") AS "People",
       SUM(sponsors."Athenians") AS "Athenians",
       SUM(sponsors."Romans") AS "Romans",
       SUM(sponsors."Imperial Family") AS "Imperial Family",
       SUM(sponsors."Other Greeks") AS "Greeks",
       SUM(sponsors."Panhellenic") AS "Panhellenic",
       SUM(sponsors."Others/Uncertain") AS "Other/Uncertain",
       SUM(sponsors."Public Institutions") AS "Public Institutions",
       SUM(sponsors."Private Institutions") AS "Private Institutions",
       SUM(sponsors."Gene") AS "Gene",
       SUM(sponsors."Females") AS "Females",
       SUM(sponsors."Males") AS "Males",
       SUM(sponsors."Athenian Citizens") AS "Athenian Citizens",
       SUM(sponsors."Roman Citizens") AS "Roman Citizens"
FROM (
          (SELECT 0 AS "Institutions",
                  COUNT(sponsor."ID") AS "People",
                  COUNT(CASE
                            WHEN sponsor."Category" = 'Athenians' THEN 1
                        END) AS "Athenians",
                  COUNT(CASE
                            WHEN sponsor."Category" = 'Romans' THEN 1
                        END) AS "Romans",
                  COUNT(CASE
                            WHEN sponsor."Category" = 'Imperial Family Members' THEN 1
                        END) AS "Imperial Family",
                  COUNT(CASE
                            WHEN sponsor."Category" = 'Greek'
                                 OR sponsor."Category" = 'Other Greek' THEN 1
                        END) AS "Other Greeks",
                  COUNT(CASE
                            WHEN sponsor."Category" = 'Panhellenic' THEN 1
                        END) AS "Panhellenic",
                  COUNT(CASE
                            WHEN sponsor."Category" = 'Other'
                                 OR sponsor."Category" = 'Uncertain' THEN 1
                        END) AS "Others/Uncertain",
                  0 AS "Public Institutions",
                  0 AS "Private Institutions",
                  0 AS "Gene",
                  COUNT(CASE
                            WHEN sponsor."Gender" = 'Female' THEN 1
                        END) AS "Females",
                  COUNT(CASE
                            WHEN sponsor."Gender" = 'Male' THEN 1
                        END) AS "Males",
                  COUNT(CASE
                            WHEN sponsor."Athenian Citizen" = TRUE THEN 1
                        END) AS "Athenian Citizens",
                  COUNT(CASE
                            WHEN sponsor."Roman Citizen" = TRUE THEN 1
                        END) AS "Roman Citizens"
           FROM public."Person" AS person
           INNER JOIN public."Person in Inscription" AS person_appearance ON person_appearance."Person ID" = Person."ID"
           INNER JOIN public."Person in Inscription" AS coappearance ON person_appearance."Inscription ID" = coappearance."Inscription ID"
           AND person_appearance."Person ID" != coappearance."Person ID"
           AND coappearance."Role" = 'Sponsor'
           INNER JOIN public."Person" AS sponsor ON coappearance."Person ID" = sponsor."ID"
           WHERE person."ID" = person_id
               AND person_appearance."Role" = 'Honoree')
      UNION ALL
          (SELECT COUNT(sponsor."ID") AS "Institutions",
                  0 AS "People",
                  COUNT(CASE
                            WHEN sponsor."Category" = 'Athenian' THEN 1
                        END) AS "Athenians",
                  COUNT(CASE
                            WHEN sponsor."Category" = 'Roman' THEN 1
                        END) AS "Romans",
                  COUNT(CASE
                            WHEN sponsor."Category" = 'Imperial Family' THEN 1
                        END) AS "Imperial Family Members",
                  COUNT(CASE
                            WHEN sponsor."Category" = 'Greek'
                                 OR sponsor."Category" = 'Other Greek' THEN 1
                        END) AS "Other Greeks",
                  COUNT(CASE
                            WHEN sponsor."Category" = 'Panhellenic' THEN 1
                        END) AS "Panhellenic",
                  COUNT(CASE
                            WHEN sponsor."Category" = 'Other'
                                 OR sponsor."Category" = 'Uncertain' THEN 1
                        END) AS "Others/Uncertain",
                  COUNT(CASE
                            WHEN sponsor."Type" = 'Public' THEN 1
                        END) AS "Public Institutions",
                  COUNT(CASE
                            WHEN sponsor."Type" = 'Private' THEN 1
                        END) AS "Private Institutions",
                  COUNT(CASE
                            WHEN sponsor."Type" = 'Genos' THEN 1
                        END) AS "Gene",
                  0 "Females",
                  0 AS "Males",
                  0 AS "Athenian Citizens",
                  0 AS "Roman Citizens"
           FROM public."Person" AS person
           INNER JOIN public."Person in Inscription" AS person_appearance ON person_appearance."Person ID" = Person."ID"
           INNER JOIN public."Institution Sponsorship" AS coappearance ON person_appearance."Inscription ID" = coappearance."Inscription ID"
           AND coappearance."Role" = 'Sponsor'
           INNER JOIN public."Institution" AS sponsor ON coappearance."Institution ID" = sponsor."ID"
           WHERE person."ID" = person_id
               AND person_appearance."Role" = 'Honoree')) AS sponsors
$BODY$
LANGUAGE sql STABLE NOT LEAKPROOF;
