DROP VIEW public."__ Personal Honor Appearance __" IF EXISTS;
CREATE OR REPLACE VIEW public."__ Personal Honor Appearance __" AS
SELECT DISTINCT person."Person" AS "Person",
                honor."Honor" AS "Honor",
                institution."Institution" AS "Honor Institution",
                inscription."IE" AS "IE",
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
                honor."Type" AS "Honor Type",
                honor."Category" AS "Honor Origin",
                institution."Category" AS "Honor Institution Origin",
                institution."Type" AS "Honor Institution Type",
                institution."ID" AS "Institution ID",
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
                person."ID" AS "Person ID",
                honor."ID" AS "Honor ID",
                inscription."ID" AS "Inscription ID",
                person."Uncertain Person" AS "Person Uncertainty"
FROM public."Person Honor Display" AS person_honor
INNER JOIN public."Person" AS person ON person_honor."Person ID" = person."ID"
INNER JOIN public."Honor" AS honor ON person_honor."Honor ID" = honor."ID"
INNER JOIN public."Inscription Full"() AS inscription ON person_honor."Inscription ID" = inscription."ID"
LEFT JOIN public."Institution Honor" AS institution_honor ON honor."ID" = institution_honor."Honor ID"
LEFT JOIN public."Institution" AS institution ON institution_honor."Institution ID" = institution."ID"
ORDER BY
    person."ID",
    honor."ID",
    inscription."ID";
