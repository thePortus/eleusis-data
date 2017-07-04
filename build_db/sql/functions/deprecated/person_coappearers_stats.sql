CREATE FUNCTION public.person_coappearers_stats(
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
SELECT SUM(coappearers."Institutions") AS "Institutions",
       SUM(coappearers."People") AS "People",
       SUM(coappearers."Athenians") AS "Athenians",
       SUM(coappearers."Romans") AS "Romans",
       SUM(coappearers."Imperial Family") AS "Imperial Family",
       SUM(coappearers."Other Greeks") AS "Greeks",
       SUM(coappearers."Panhellenic") AS "Panhellenic",
       SUM(coappearers."Others/Uncertain") AS "Other/Uncertain",
       SUM(coappearers."Public Institutions") AS "Public Institutions",
       SUM(coappearers."Private Institutions") AS "Private Institutions",
       SUM(coappearers."Gene") AS "Gene",
       SUM(coappearers."Females") AS "Females",
       SUM(coappearers."Males") AS "Males",
       SUM(coappearers."Athenian Citizens") AS "Athenian Citizens",
       SUM(coappearers."Roman Citizens") AS "Roman Citizens"
FROM (
          (SELECT 0 AS "Institutions",
                  COUNT(coappearer."ID") AS "People",
                  COUNT(CASE
                            WHEN coappearer."Category" = 'Athenians' THEN 1
                        END) AS "Athenians",
                  COUNT(CASE
                            WHEN coappearer."Category" = 'Romans' THEN 1
                        END) AS "Romans",
                  COUNT(CASE
                            WHEN coappearer."Category" = 'Imperial Family Members' THEN 1
                        END) AS "Imperial Family",
                  COUNT(CASE
                            WHEN coappearer."Category" = 'Greek'
                                 OR coappearer."Category" = 'Other Greek' THEN 1
                        END) AS "Other Greeks",
                  COUNT(CASE
                            WHEN coappearer."Category" = 'Panhellenic' THEN 1
                        END) AS "Panhellenic",
                  COUNT(CASE
                            WHEN coappearer."Category" = 'Other'
                                 OR coappearer."Category" = 'Uncertain' THEN 1
                        END) AS "Others/Uncertain",
                  0 AS "Public Institutions",
                  0 AS "Private Institutions",
                  0 AS "Gene",
                  COUNT(CASE
                            WHEN coappearer."Gender" = 'Female' THEN 1
                        END) AS "Females",
                  COUNT(CASE
                            WHEN coappearer."Gender" = 'Male' THEN 1
                        END) AS "Males",
                  COUNT(CASE
                            WHEN coappearer."Athenian Citizen" = TRUE THEN 1
                        END) AS "Athenian Citizens",
                  COUNT(CASE
                            WHEN coappearer."Roman Citizen" = TRUE THEN 1
                        END) AS "Roman Citizens"
           FROM public."Person" AS person
           INNER JOIN public."Person in Inscription" AS person_appearance ON person_appearance."Person ID" = Person."ID"
           INNER JOIN public."Person in Inscription" AS coappearance ON person_appearance."Inscription ID" = coappearance."Inscription ID"
           AND person_appearance."Person ID" != coappearance."Person ID"
           INNER JOIN public."Person" AS coappearer ON coappearance."Person ID" = coappearer."ID"
           WHERE person."ID" = person_id)
      UNION ALL
          (SELECT COUNT(coappearer."ID") AS "Institutions",
                  0 AS "People",
                  COUNT(CASE
                            WHEN coappearer."Category" = 'Athenian' THEN 1
                        END) AS "Athenians",
                  COUNT(CASE
                            WHEN coappearer."Category" = 'Roman' THEN 1
                        END) AS "Romans",
                  COUNT(CASE
                            WHEN coappearer."Category" = 'Imperial Family' THEN 1
                        END) AS "Imperial Family Members",
                  COUNT(CASE
                            WHEN coappearer."Category" = 'Greek'
                                 OR coappearer."Category" = 'Other Greek' THEN 1
                        END) AS "Other Greeks",
                  COUNT(CASE
                            WHEN coappearer."Category" = 'Panhellenic' THEN 1
                        END) AS "Panhellenic",
                  COUNT(CASE
                            WHEN coappearer."Category" = 'Other'
                                 OR coappearer."Category" = 'Uncertain' THEN 1
                        END) AS "Others/Uncertain",
                  COUNT(CASE
                            WHEN coappearer."Type" = 'Public' THEN 1
                        END) AS "Public Institutions",
                  COUNT(CASE
                            WHEN coappearer."Type" = 'Private' THEN 1
                        END) AS "Private Institutions",
                  COUNT(CASE
                            WHEN coappearer."Type" = 'Genos' THEN 1
                        END) AS "Gene",
                  0 "Females",
                  0 AS "Males",
                  0 AS "Athenian Citizens",
                  0 AS "Roman Citizens"
           FROM public."Person" AS person
           INNER JOIN public."Person in Inscription" AS person_appearance ON person_appearance."Person ID" = Person."ID"
           INNER JOIN public."Institution Sponsorship" AS coappearance ON person_appearance."Inscription ID" = coappearance."Inscription ID"
           INNER JOIN public."Institution" AS coappearer ON coappearance."Institution ID" = coappearer."ID"
           WHERE person."ID" = person_id)) AS coappearers
$BODY$
LANGUAGE sql STABLE NOT LEAKPROOF;
