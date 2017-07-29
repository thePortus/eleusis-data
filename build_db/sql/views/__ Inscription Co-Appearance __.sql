DROP VIEW IF EXISTS public."- Inscription Co-Appearance -";
CREATE OR REPLACE VIEW public."- Inscription Co-Appearance -" AS
-- FOR COAPPEARANCES BETWEEN INDIVIDUALS
SELECT DISTINCT
-- Party A Fields
    party_a."Person" AS "Party A",
    party_b."Person" AS "Party B",
    inscription."Inscription" AS "Inscription",
    'Person' AS "Party A Class",
    NULL AS "Party A Type",
    (CASE
         WHEN party_a."Category" = 'Athenian'
              OR party_a."Category" = 'Eleusinian' THEN 'Athenian'
         WHEN party_a."Category" = 'Other'
              OR party_a."Category" = 'Uncertain' THEN 'Other/Uncertain'
         WHEN party_a."Category" = 'Roman'
              OR party_a."Category" = 'Imperial Family' THEN 'Roman'
         WHEN party_a."Category" = 'Greek'
              OR party_a."Category" = 'Other Greek'
              OR party_a."Category" = 'Panhellenic' THEN 'Other Greek'
         ELSE 'Other/Uncertain'
     END) AS "Party A Origin",
    party_a."Gender" AS "Party A Gender",
    (CASE
         WHEN party_a."Category" = 'Athenian'
              AND party_a."Roman Citizen" = TRUE THEN 'TRUE'
         ELSE 'FALSE'
     END) AS "Party A Athenian with Roman Citizenship",
    party_a."Family" AS "Party A Family",
    party_a."Extended" AS "Party A Extended",
    party_a."Deme" AS "Party A Deme",
--- Start of Party B Fields
    'Person' AS "Party B Class",
    NULL AS "Party B Type",
    (CASE
         WHEN party_b."Category" = 'Athenian'
              OR party_b."Category" = 'Eleusinian' THEN 'Athenian'
         WHEN party_b."Category" = 'Other'
              OR party_b."Category" = 'Uncertain' THEN 'Other/Uncertain'
         WHEN party_b."Category" = 'Roman'
              OR party_b."Category" = 'Imperial Family' THEN 'Roman'
         WHEN party_b."Category" = 'Greek'
              OR party_b."Category" = 'Other Greek'
              OR party_b."Category" = 'Panhellenic' THEN 'Other Greek'
         ELSE 'Other/Uncertain'
     END) AS "Party B Origin",
    party_b."Gender" AS "Party B Gender",
    (CASE
         WHEN party_b."Category" = 'Athenian'
              AND party_b."Roman Citizen" = TRUE THEN 'TRUE'
         ELSE 'FALSE'
     END) AS "Party B Athenian with Roman Citizenship",
    party_b."Family" AS "Party B Family",
    party_b."Extended" AS "Party B Extended",
    party_b."Deme" AS "Party B Deme",
-- Inscription Fields
    inscription."IE" AS "IE",
    inscription."Object Type" AS "Object",
    inscription."Inscription Type" AS "Inscription Type",
    inscription."Location" AS "Location",
    inscription."Date" AS "Date",
    inscription."Date Span" AS "Date Span",
    inscription."Word Count" AS "Word Count",
    inscription."Character Count" AS "Character Count",
    inscription."Text" AS "Text",
    inscription."References" AS "References",
    inscription."ID" AS "Inscription ID",
    party_a."ID" AS "Party A ID",
    party_b."ID" AS "Party B ID"
-- Person in Inscription to Person in Inscription
FROM public."Person in Inscription" as party_a_in_inscription
    INNER JOIN public."Person in Inscription" as party_b_in_inscription
        ON party_a_in_inscription."Inscription ID" = party_b_in_inscription."Inscription ID"
-- Join Inscription
    INNER JOIN public."Inscription Full"() as inscription
        ON party_a_in_inscription."Inscription ID" = inscription."ID"
-- Join Party A
    INNER JOIN public."Person" as party_a
        ON party_a_in_inscription."Person ID" = party_a."ID"
-- Join Party B
    INNER JOIN public."Person" as party_b
        ON party_b_in_inscription."Person ID" = party_b."ID"
-- Exclude when Party A is Party B
WHERE party_a."ID" != party_b."ID"
UNION ALL
-- FOR COAPPEARANCES BETEWEEN INSTITUTIONS AND INDIVIDUALS
SELECT DISTINCT
-- Party A Fields
    party_a."Institution" AS "Party A",
    party_b."Person" AS "Party B",
    inscription."Inscription" AS "Inscription",
    'Institution' AS "Party A Class",
    party_a."Type" AS "Party A Type",
    (CASE
         WHEN party_a."Category" = 'Athenian'
              OR party_a."Category" = 'Eleusinian' THEN 'Athenian'
         WHEN party_a."Category" = 'Other'
              OR party_a."Category" = 'Uncertain' THEN 'Other/Uncertain'
         WHEN party_a."Category" = 'Roman'
              OR party_a."Category" = 'Imperial Family' THEN 'Roman'
         WHEN party_a."Category" = 'Greek'
              OR party_a."Category" = 'Other Greek'
              OR party_a."Category" = 'Panhellenic' THEN 'Other Greek'
         ELSE 'Other/Uncertain'
     END) AS "Party A Origin",
    NULL AS "Party A Gender",
    NULL AS "Party A Athenian with Roman Citizenship",
    NULL AS "Party A Family",
    NULL AS "Party A Extended",
    NULL AS "Party A Deme",
--- Start of Party B Fields
    'Person' AS "Party B Class",
    NULL AS "Party B Type",
    (CASE
         WHEN party_b."Category" = 'Athenian'
              OR party_b."Category" = 'Eleusinian' THEN 'Athenian'
         WHEN party_b."Category" = 'Other'
              OR party_b."Category" = 'Uncertain' THEN 'Other/Uncertain'
         WHEN party_b."Category" = 'Roman'
              OR party_b."Category" = 'Imperial Family' THEN 'Roman'
         WHEN party_b."Category" = 'Greek'
              OR party_b."Category" = 'Other Greek'
              OR party_b."Category" = 'Panhellenic' THEN 'Other Greek'
         ELSE 'Other/Uncertain'
     END) AS "Party B Origin",
    party_b."Gender" AS "Party B Gender",
    (CASE
         WHEN party_b."Category" = 'Athenian'
              AND party_b."Roman Citizen" = TRUE THEN 'TRUE'
         ELSE 'FALSE'
     END) AS "Party B Athenian with Roman Citizenship",
    party_b."Family" AS "Party B Family",
    party_b."Extended" AS "Party B Extended",
    party_b."Deme" AS "Party B Deme",
-- Inscription Fields
    inscription."IE" AS "IE",
    inscription."Object Type" AS "Object",
    inscription."Inscription Type" AS "Inscription Type",
    inscription."Location" AS "Location",
    inscription."Date" AS "Date",
    inscription."Date Span" AS "Date Span",
    inscription."Word Count" AS "Word Count",
    inscription."Character Count" AS "Character Count",
    inscription."Text" AS "Text",
    inscription."References" AS "References",
    inscription."ID" AS "Inscription ID",
    party_a."ID" AS "Party A ID",
    party_b."ID" AS "Party B ID"
-- Person in Inscription to Person in Inscription
FROM public."Institution Sponsorship" as party_a_in_inscription
    INNER JOIN public."Person in Inscription" as party_b_in_inscription
        ON party_a_in_inscription."Inscription ID" = party_b_in_inscription."Inscription ID"
-- Join Inscription
    INNER JOIN public."Inscription Full"() as inscription
        ON party_a_in_inscription."Inscription ID" = inscription."ID"
-- Join Party A
    INNER JOIN public."Institution" as party_a
        ON party_a_in_inscription."Institution ID" = party_a."ID"
-- Join Party B
    INNER JOIN public."Person" as party_b
        ON party_b_in_inscription."Person ID" = party_b."ID"
