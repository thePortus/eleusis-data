CREATE OR REPLACE VIEW public."__ Inscription Sponsor and Person Appearing __" AS
SELECT DISTINCT inscription."IE" AS "IE",
                sponsor."Person" AS "Sponsor",
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
                'Person' AS "Sponsor Class",
                sponsor."Category" AS "Sponsor Origin",
                CASE
                    WHEN sponsor."Category" = 'Athenian'
                         AND sponsor."Roman Citizen" = FALSE THEN 'Athenian without Roman Citizenship'
                    WHEN sponsor."Category" = 'Athenian'
                         AND sponsor."Roman Citizen" = TRUE THEN 'Athenian with Roman Citizenship'
                    ELSE 'Non-Athenian'
                END AS "Sponsor Status",
                NULL AS "Sponsor Type",
                sponsor."Gender" AS "Sponsor Gender",
                sponsor."Family" AS "Sponsor Family",
                sponsor."Extended" AS "Sponsor Extended Family",
                sponsor."Deme" AS "Sponsor Deme",
                person."Category" AS "Person Origin",
                CASE
                    WHEN person."Category" = 'Athenian'
                         AND person."Roman Citizen" = FALSE THEN 'Athenian without Roman Citizenship'
                    WHEN person."Category" = 'Athenian'
                         AND person."Roman Citizen" = TRUE THEN 'Athenian with Roman Citizenship'
                    ELSE 'Non-Athenian'
                END AS "Person Status",
                NULL AS "Person Type",
                person."Gender" AS "Person Gender",
                person."Family" AS "Person Family",
                person."Extended" AS "Person Extended Family",
                person."Deme" AS "Person Deme",
                person_inscription."Role" AS "Person Role",
                inscription."ID" AS "Inscription ID",
                sponsor."ID" AS "Sponsor ID",
                person."ID" AS "Person ID",
                sponsor."Uncertain Person" AS "Sponsor Uncertainty",
                person."Uncertain Person" AS "Person Uncertainty"
FROM public."Person in Inscription" AS sponsor_inscription
INNER JOIN public."Person in Inscription" AS person_inscription ON sponsor_inscription."Inscription ID" = person_inscription."Inscription ID"
INNER JOIN public."Inscription Full"() AS inscription ON sponsor_inscription."Inscription ID" = inscription."ID"
INNER JOIN public."Person" AS sponsor ON sponsor_inscription."Person ID" = sponsor."ID"
INNER JOIN public."Person" AS person ON person_inscription."Person ID" = person."ID"
WHERE sponsor_inscription."Role" = 'Sponsor' AND sponsor."ID" != person."ID"
UNION ALL
SELECT DISTINCT inscription."IE" AS "IE",
                sponsor."Institution" AS "Sponsor",
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
                'Institution' AS "Sponsor Class",
                sponsor."Category" AS "Sponsor Origin",
                NULL AS "Sponsor Status",
                sponsor."Type" AS "Sponsor Type",
                NULL AS "Sponsor Gender",
                NULL AS "Sponsor Family",
                NULL AS "Sponsor Extended Family",
                NULL AS "Sponsor Deme",
                person."Category" AS "Person Origin",
                CASE
                    WHEN person."Category" = 'Athenian'
                         AND person."Roman Citizen" = FALSE THEN 'Athenian without Roman Citizenship'
                    WHEN person."Category" = 'Athenian'
                         AND person."Roman Citizen" = TRUE THEN 'Athenian with Roman Citizenship'
                    ELSE 'Non-Athenian'
                END AS "Person Status",
                NULL AS "Person Type",
                person."Gender" AS "Person Gender",
                person."Family" AS "Person Family",
                person."Extended" AS "Person Extended Family",
                person."Deme" AS "Person Deme",
                person_inscription."Role" AS "Person Role",
                inscription."ID" AS "Inscription ID",
                sponsor."ID" AS "Sponsor ID",
                person."ID" AS "Person ID",
                sponsor_inscription."Uncertain" AS "Sponsor Uncertainty",
                person."Uncertain Person" AS "Person Uncertainty"
FROM public."Institution Sponsorship" AS sponsor_inscription
INNER JOIN public."Person in Inscription" as person_inscription ON sponsor_inscription."Inscription ID" = person_inscription."Inscription ID"
INNER JOIN public."Inscription Full"() AS inscription ON sponsor_inscription."Inscription ID" = inscription."ID"
INNER JOIN public."Institution" AS sponsor ON sponsor_inscription."Institution ID" = sponsor."ID"
INNER JOIN public."Person" AS person ON person_inscription."Person ID" = person."ID"
ORDER BY "Inscription ID",
         "Sponsor ID";
