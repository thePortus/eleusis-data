DROP VIEW public."__ Inscription Person __" IF EXISTS;
CREATE OR REPLACE VIEW public."__ Inscription Person __" AS
SELECT DISTINCT inscription."IE" AS "IE",
                person."Person" AS "Person",
                inscription."Inscription" AS "Inscription",
                inscription."Object Type" AS "Object Type",
                inscription."Inscription Type" AS "Inscription Type",
                inscription."Location" AS "Location",
                inscription."Date" AS "Date",
                inscription."Date Span" AS "Date Span",
                inscription."Word Count" AS "Word Count",
                inscription."Character Count" AS "Character Count",
                inscription."Text" AS "Text",
                inscription."References" AS "References",
                person."Category" AS "Person Origin",
                CASE
                    WHEN person."Category" = 'Athenian'
                         AND person."Roman Citizen" = FALSE THEN 'Athenian without Roman Citizenship'
                    WHEN person."Category" = 'Athenian'
                         AND person."Roman Citizen" = TRUE THEN 'Athenian with Roman Citizenship'
                    ELSE 'Non-Athenian'
                END AS "Person Status",
                person."Gender" AS "Person Gender",
                person."Family" AS "Person Family",
                person."Extended" AS "Person Extended Family",
                person."Deme" AS "Person Deme",
                person_inscription."Role" AS "Person Role",
                inscription."ID" AS "Inscription ID",
                person."ID" AS "Person ID",
                person."Uncertain Person" AS "Person Uncertainty"
FROM public."Person in Inscription" AS person_inscription
INNER JOIN public."Inscription Full"() AS inscription ON person_inscription."Inscription ID" = inscription."ID"
INNER JOIN public."Person" AS person ON person_inscription."Person ID" = person."ID"
ORDER BY inscription."ID",
         person."ID";
