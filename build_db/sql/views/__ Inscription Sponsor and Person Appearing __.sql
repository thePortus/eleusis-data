DROP VIEW IF EXISTS public."__ Inscription Sponsor and Person Appearing __";
CREATE OR REPLACE VIEW public."__ Inscription Sponsor and Person Appearing __" AS
SELECT DISTINCT inscription."IE" AS "IE",
                sponsor."Person" AS "Sponsor",
                honorand."Person" AS "Honorand",
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
                honorand."Category" AS "Honorand Origin",
                CASE
                    WHEN honorand."Category" = 'Athenian'
                         AND honorand."Roman Citizen" = FALSE THEN 'Athenian without Roman Citizenship'
                    WHEN honorand."Category" = 'Athenian'
                         AND honorand."Roman Citizen" = TRUE THEN 'Athenian with Roman Citizenship'
                    ELSE 'Non-Athenian'
                END AS "Honorand Status",
                NULL AS "Honorand Type",
                honorand."Gender" AS "Honorand Gender",
                honorand."Family" AS "Honorand Family",
                honorand."Extended" AS "Honorand Extended Family",
                honorand."Deme" AS "Honorand Deme",
                inscription."ID" AS "Inscription ID",
                sponsor."ID" AS "Sponsor ID",
                honorand."ID" AS "Honorand ID",
                sponsor."Uncertain Person" AS "Sponsor Uncertainty",
                honorand."Uncertain Person" AS "Honorand Uncertainty"
FROM public."Person in Inscription" AS sponsor_inscription
INNER JOIN public."Person in Inscription" AS honorand_inscription ON sponsor_inscription."Inscription ID" = honorand_inscription."Inscription ID"
INNER JOIN public."Inscription Full"() AS inscription ON sponsor_inscription."Inscription ID" = inscription."ID"
INNER JOIN public."Person" AS sponsor ON sponsor_inscription."Person ID" = sponsor."ID"
INNER JOIN public."Person" AS honorand ON honorand_inscription."Person ID" = honorand."ID"
WHERE sponsor_inscription."Role" = 'Sponsor' AND sponsor."ID" != honorand."ID"
UNION ALL
SELECT DISTINCT inscription."IE" AS "IE",
                sponsor."Institution" AS "Sponsor",
                honorand."Person" AS "Honorand",
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
                honorand."Category" AS "Honorand Origin",
                CASE
                    WHEN honorand."Category" = 'Athenian'
                         AND honorand."Roman Citizen" = FALSE THEN 'Athenian without Roman Citizenship'
                    WHEN honorand."Category" = 'Athenian'
                         AND honorand."Roman Citizen" = TRUE THEN 'Athenian with Roman Citizenship'
                    ELSE 'Non-Athenian'
                END AS "Honorand Status",
                NULL AS "Honorand Type",
                honorand."Gender" AS "Honorand Gender",
                honorand."Family" AS "Honorand Family",
                honorand."Extended" AS "Honorand Extended Family",
                honorand."Deme" AS "Honorand Deme",
                inscription."ID" AS "Inscription ID",
                sponsor."ID" AS "Sponsor ID",
                honorand."ID" AS "Honorand ID",
                sponsor_inscription."Uncertain" AS "Sponsor Uncertainty",
                honorand."Uncertain Person" AS "Honorand Uncertainty"
FROM public."Institution Sponsorship" AS sponsor_inscription
INNER JOIN public."Person in Inscription" as honorand_inscription ON sponsor_inscription."Inscription ID" = honorand_inscription."Inscription ID"
INNER JOIN public."Inscription Full"() AS inscription ON sponsor_inscription."Inscription ID" = inscription."ID"
INNER JOIN public."Institution" AS sponsor ON sponsor_inscription."Institution ID" = sponsor."ID"
INNER JOIN public."Person" AS honorand ON honorand_inscription."Person ID" = honorand."ID"
ORDER BY "Inscription ID",
         "Sponsor ID";
