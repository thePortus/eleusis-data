DROP VIEW IF EXISTS public."__ Institutional Officer Other Honor __";
CREATE OR REPLACE VIEW public."__ Institutional Officer Other Honor __" AS
SELECT DISTINCT institution."Institution" AS "Institution",
                office."Honor" AS "Office",
                honor."Honor" AS "Other Honor",
                officer."Person" AS "Officer",
                institution."Category" AS "Institution Origin",
                institution."Type" AS "Institution Type",
                office."Type" AS "Office Type",
                honor."Type" AS "Other Honor Type",
                honor."Category" AS "Other Honor Origin",
                SUM(officer_honor."Appearances") AS "Other Honor Appearances",
                other_institution."Institution" AS "Other Institution",
                other_institution."Category" AS "Other Institution Origin",
                other_institution."Type" AS "Other Institution Type",
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
                honor."ID" AS "Honor ID",
                other_institution."ID" AS "Other Institution ID",
                officer."ID" AS "Officer ID",
                officer."Uncertain Person" AS "Officer Uncertainty"
FROM public."Institution Honor" AS institution_office
INNER JOIN public."Person Honor Display" AS officer_office ON institution_office."Honor ID" = officer_office."Honor ID"
INNER JOIN public."Person Honor Display" AS officer_honor ON officer_office."Person ID" = officer_honor."Person ID"
AND officer_office."Honor ID" != officer_honor."Honor ID"
INNER JOIN public."Person in Inscription" AS officer_appearance ON officer_honor."Inscription ID" = officer_appearance."Inscription ID"
AND officer_honor."Person ID" = officer_appearance."Person ID"
INNER JOIN public."Institution" AS institution ON institution_office."Institution ID" = institution."ID"
INNER JOIN public."Honor" AS office ON institution_office."Honor ID" = office."ID"
AND officer_office."Honor ID" = office."ID"
INNER JOIN public."Honor" AS honor ON officer_honor."Honor ID" = honor."ID"
INNER JOIN public."Person" AS officer ON officer_office."Person ID" = officer."ID"
AND officer_honor."Person ID" = officer."ID"
AND officer_appearance."Person ID" = officer."ID"
INNER JOIN public."Institution Honor" as institution_honor ON honor."ID" = institution_honor."Honor ID"
INNER JOIN public."Institution" as other_institution ON institution_honor."Institution ID" = other_institution."ID"
GROUP BY honor."ID", office."ID", institution."ID", officer."ID", other_institution."ID"
ORDER BY institution."ID",
         office."ID",
         honor."ID",
         officer."ID",
         other_institution."ID";
