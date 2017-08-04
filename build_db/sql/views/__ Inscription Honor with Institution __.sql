CREATE OR REPLACE VIEW public."__ Inscription Honor with Institution __" AS
SELECT DISTINCT inscription."IE" AS "IE",
                honor."Honor" AS "Honor",
                institution."Institution" AS "Institution",
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
                honor."Type" AS "Honor Type",
                honor."Category" AS "Honor Origin",
                institution."Category" AS "Institution Origin",
                institution."Type" AS "Institution Type",
                inscription."ID" AS "Inscription ID",
                institution."ID" AS "Institution ID",
                honor."ID" AS "Honor ID"
FROM public."Honor in Inscription" AS honor_inscription
LEFT JOIN public."Institution Honor" AS institution_honor ON honor_inscription."Honor ID" = institution_honor."Honor ID"
INNER JOIN public."Inscription Full"() AS inscription ON honor_inscription."Inscription ID" = inscription."ID"
INNER JOIN public."Honor" AS honor ON institution_honor."Honor ID" = honor."ID"
LEFT JOIN public."Institution" AS institution ON institution_honor."Institution ID" = institution."ID"
ORDER BY inscription."ID",
         institution."ID",
         honor."ID";
