CREATE OR REPLACE VIEW public."__ Institutional Officer Other Honor Appearance __" AS
SELECT DISTINCT institution."Institution" AS "Institution",
                office."Honor" AS "Office",
                honor."Honor" AS "Other Honor",
                officer."Person" AS "Officer",
                inscription."Inscription" AS "Inscription",
                institution."Category" AS "Institution Origin",
                institution."Type" AS "Institution Type",
                office."Type" AS "Office Type",
                honor."Type" AS "Other Honor Type",
                honor."Category" AS "Other Honor Origin",
                officer_honor."Appearances" AS "Other Honor Appearances",
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
                officer_appearance."Role" AS "Officer Role",
                inscription."IE" AS "IE",
                inscription."Object Type" AS "Object Type",
                inscription."Inscription Type" AS "Inscription Type",
                inscription."Location" AS "Location",
                inscription."Date" AS "Date",
                inscription."Date Span" AS "Date Span",
                inscription."Word Count" AS "Word Count",
                inscription."Character Count" AS "Character Count",
                inscription."Text" AS "Text",
                institution."ID" AS "Institution ID",
                office."ID" AS "Office ID",
                honor."ID" AS "Honor ID",
                officer."ID" AS "Officer ID",
                inscription."ID" AS "Inscription ID",
                officer."Uncertain Person" AS "Officer Uncertainty"
FROM public."Institution Honor" AS institution_honor
INNER JOIN public."Person Honor Display" AS officer_office ON institution_honor."Honor ID" = officer_office."Honor ID"
INNER JOIN public."Person Honor Display" AS officer_honor ON officer_office."Person ID" = officer_honor."Person ID"
AND officer_office."Honor ID" != officer_honor."Honor ID"
INNER JOIN public."Person in Inscription" AS officer_appearance ON officer_honor."Inscription ID" = officer_appearance."Inscription ID"
AND officer_honor."Person ID" = officer_appearance."Person ID"
INNER JOIN public."Institution" AS institution ON institution_honor."Institution ID" = institution."ID"
INNER JOIN public."Honor" AS office ON institution_honor."Honor ID" = office."ID"
AND officer_office."Honor ID" = office."ID"
INNER JOIN public."Honor" AS honor ON officer_honor."Honor ID" = honor."ID"
INNER JOIN public."Person" AS officer ON officer_office."Person ID" = officer."ID"
AND officer_honor."Person ID" = officer."ID"
AND officer_appearance."Person ID" = officer."ID"
INNER JOIN public."Inscription with Text"() AS inscription ON officer_honor."Inscription ID" = inscription."ID"
ORDER BY institution."ID",
         office."ID",
         honor."ID",
         officer."ID",
         inscription. "ID"
