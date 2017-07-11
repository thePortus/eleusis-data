DROP VIEW IF EXISTS public."__ Institutional Officer __";
CREATE OR REPLACE VIEW public."__ Institutional Officer __" AS
SELECT DISTINCT institution."Institution" AS "Institution",
                office."Honor" AS "Office",
                officer."Person" AS "Officer",
                institution."Category" AS "Institution Origin",
                institution."Type" AS "Institution Type",
                office."Type" AS "Office Type",
                SUM(officer_office."Appearances") AS "Office Appearances",
                officer."Category" AS "Officer Origin",
                CASE
                    WHEN officer."Category" = 'Athenian'
                         AND officer."Roman Citizen" = FALSE THEN 'Athenian without Roman Citizenship'
                    WHEN officer."Category" = 'Athenian'
                         AND officer."Roman Citizen" = TRUE THEN 'Athenian with Roman Citizenship'
                    ELSE 'Non-Athenian'
                END AS "Officer Status",
                officer."Gender" AS "Officer Gender",
                officer."Family" AS "Officer Family",
                officer."Extended" AS "Officer Extended Family",
                officer."Deme" AS "Officer Deme",
                SUM(CASE WHEN officer_appearance."Role" = 'Sponsor' THEN 1 ELSE 0 END) AS "Officer as Sponsor",
                SUM(CASE WHEN officer_appearance."Role" = 'Honorand' THEN 1 ELSE 0 END) AS "Officer as Honorand",
                SUM(CASE WHEN officer_appearance."Role" = '' THEN 1 ELSE 0 END) AS "Officer as Other Role",
                institution."ID" AS "Institution ID",
                office."ID" AS "Office ID",
                officer."ID" AS "Officer ID",
                officer."Uncertain Person" AS "Officer Uncertainty"
FROM public."Institution Honor" AS institution_honor
INNER JOIN public."Person Honor Display" AS officer_office ON institution_honor."Honor ID" = officer_office."Honor ID"
INNER JOIN public."Person in Inscription" AS officer_appearance ON officer_office."Person ID" = officer_appearance."Person ID"
INNER JOIN public."Institution" AS institution ON institution_honor."Institution ID" = institution."ID"
INNER JOIN public."Honor" AS office ON institution_honor."Honor ID" = office."ID"
AND officer_office."Honor ID" = office."ID"
INNER JOIN public."Person" AS officer ON officer_office."Person ID" = officer."ID" AND officer_appearance."Person ID" = officer."ID"
GROUP BY officer."ID",
         institution."ID",
         office."ID"
ORDER BY institution."ID",
         office."ID",
         officer."ID";
