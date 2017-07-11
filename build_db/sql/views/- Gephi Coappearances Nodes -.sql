DROP VIEW IF EXISTS public."- Gephi Coappearance Nodes -";
CREATE OR REPLACE VIEW public."- Gephi Coappearance Nodes -" AS
SELECT DISTINCT sponsor."ID" AS "ID",
                sponsor."Person" AS "Label",
                public."Earliest Date"(sponsor."ID") AS "Start",
                350.0 AS "Stop",
                'Person' AS "Class",
                NULL AS "Type",
                (CASE
                     WHEN sponsor."Category" = 'Athenian'
                          OR sponsor."Category" = 'Eleusinian' THEN 'Athenian'
                     WHEN sponsor."Category" = 'Other'
                          OR sponsor."Category" = 'Uncertain' THEN 'Other/Uncertain'
                     WHEN sponsor."Category" = 'Roman'
                          OR sponsor."Category" = 'Imperial Family' THEN 'Roman'
                     WHEN sponsor."Category" = 'Greek'
                          OR sponsor."Category" = 'Other Greek'
                          OR sponsor."Category" = 'Panhellenic' THEN 'Other Greek'
                     ELSE 'Other/Uncertain'
                 END) AS "Origin",
                sponsor."Gender" AS "Gender",
                (CASE
                     WHEN sponsor."Category" = 'Athenian'
                          AND sponsor."Roman Citizen" = TRUE THEN 'TRUE'
                     ELSE 'FALSE'
                 END) AS "Athenian with Roman Citizenship",
                sponsor."Family" AS "Family",
                sponsor."Extended" AS "Extended",
                sponsor."Deme" AS "Deme"
FROM public."Person in Inscription" AS sponsor_appearance
INNER JOIN public."Person in Inscription" AS honorand_appearance ON sponsor_appearance."Inscription ID" = honorand_appearance."Inscription ID"
INNER JOIN public."Person" AS sponsor ON sponsor_appearance."Person ID" = sponsor."ID"
WHERE sponsor_appearance."Person ID" != honorand_appearance."Person ID"
UNION
SELECT DISTINCT honorand."ID" AS "ID",
                honorand."Person" AS "Label",
                public."Earliest Date"(honorand."ID") AS "Start",
                350.0 AS "Stop",
                'Person' AS "Class",
                NULL AS "Type",
                (CASE
                     WHEN honorand."Category" = 'Athenian'
                          OR honorand."Category" = 'Eleusinian' THEN 'Athenian'
                     WHEN honorand."Category" = 'Other'
                          OR honorand."Category" = 'Uncertain' THEN 'Other/Uncertain'
                     WHEN honorand."Category" = 'Roman'
                          OR honorand."Category" = 'Imperial Family' THEN 'Roman'
                     WHEN honorand."Category" = 'Greek'
                          OR honorand."Category" = 'Other Greek'
                          OR honorand."Category" = 'Panhellenic' THEN 'Other Greek'
                     ELSE 'Other/Uncertain'
                 END) AS "Origin",
                honorand."Gender" AS "Gender",
                (CASE
                     WHEN honorand."Category" = 'Athenian'
                          AND honorand."Roman Citizen" = TRUE THEN 'TRUE'
                     ELSE 'FALSE'
                 END) AS "Athenian with Roman Citizenship",
                honorand."Family" AS "Family",
                honorand."Extended" AS "Extended",
                honorand."Deme" AS "Deme"
FROM public."Person in Inscription" AS honorand_appearance
INNER JOIN public."Person in Inscription" AS sponsor_appearance ON honorand_appearance."Inscription ID" = sponsor_appearance."Inscription ID"
INNER JOIN public."Person" AS honorand ON honorand_appearance."Person ID" = honorand."ID"
WHERE sponsor_appearance."Person ID" != honorand_appearance."Person ID"
UNION
SELECT DISTINCT sponsor."ID" AS "ID",
                sponsor."Institution" AS "Label",
                public."Earliest Date"(sponsor."ID") AS "Start",
                350.0 AS "Stop",
                'Institution' AS "Class",
                sponsor."Type" AS "Type",
                (CASE
                     WHEN sponsor."Category" = 'Athenian'
                          OR sponsor."Category" = 'Eleusinian' THEN 'Athenian'
                     WHEN sponsor."Category" = 'Other'
                          OR sponsor."Category" = 'Uncertain' THEN 'Other/Uncertain'
                     WHEN sponsor."Category" = 'Roman'
                          OR sponsor."Category" = 'Imperial Family' THEN 'Roman'
                     WHEN sponsor."Category" = 'Greek'
                          OR sponsor."Category" = 'Other Greek'
                          OR sponsor."Category" = 'Panhellenic' THEN 'Other Greek'
                     ELSE 'Other/Uncertain'
                 END) AS "Origin",
                NULL AS "Gender",
                NULL AS "Athenian with Roman Citizenship",
                NULL AS "Family",
                NULL AS "Extended",
                NULL AS "Deme"
FROM public."Institution Sponsorship" AS sponsor_appearance
INNER JOIN public."Person in Inscription" AS honorand_appearance ON sponsor_appearance."Inscription ID" = honorand_appearance."Inscription ID"
INNER JOIN public."Institution" AS sponsor ON sponsor_appearance."Institution ID" = sponsor."ID"
INNER JOIN public."Person" AS honorand ON honorand_appearance."Person ID" = honorand."ID"
UNION
SELECT DISTINCT honorand."ID" AS "ID",
                honorand."Person" AS "Label",
                public."Earliest Date"(honorand."ID") AS "Start",
                350.0 AS "Stop",
                'Person' AS "Class",
                NULL AS "Type",
                (CASE
                     WHEN honorand."Category" = 'Athenian'
                          OR honorand."Category" = 'Eleusinian' THEN 'Athenian'
                     WHEN honorand."Category" = 'Other'
                          OR honorand."Category" = 'Uncertain' THEN 'Other/Uncertain'
                     WHEN honorand."Category" = 'Roman'
                          OR honorand."Category" = 'Imperial Family' THEN 'Roman'
                     WHEN honorand."Category" = 'Greek'
                          OR honorand."Category" = 'Other Greek'
                          OR honorand."Category" = 'Panhellenic' THEN 'Other Greek'
                     ELSE 'Other/Uncertain'
                 END) AS "Origin",
                honorand."Gender" AS "Gender",
                (CASE
                     WHEN honorand."Category" = 'Athenian'
                          AND honorand."Roman Citizen" = TRUE THEN 'TRUE'
                     ELSE 'FALSE'
                 END) AS "Athenian with Roman Citizenship",
                honorand."Family" AS "Family",
                honorand."Extended" AS "Extended",
                honorand."Deme" AS "Deme"
FROM public."Person in Inscription" AS honorand_appearance
INNER JOIN public."Institution Sponsorship" AS sponsor_appearance ON honorand_appearance."Inscription ID" = sponsor_appearance."Inscription ID"
INNER JOIN public."Person" AS honorand ON honorand_appearance."Person ID" = honorand."ID";
