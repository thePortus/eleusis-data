CREATE OR REPLACE VIEW public."__ Institutional Inscription Honor Appearance __" AS
SELECT DISTINCT sponsor."Institution" AS "Institution",
                honor."Honor" AS "Honor",
                inscription."IE" AS "IE",
                sponsor."Category" AS "Institution Origin",
                sponsor."Type" AS "Institution Type",
                honor."Type" AS "Honor Type",
                honor."Category" AS "Honor Origin",
                honor_appearance."Appearances" AS "Appearances",
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
                sponsor."ID" AS "Institution ID",
                honor."ID" AS "Office ID",
                inscription."ID" AS "Inscription ID"
FROM public."Institution Sponsorship" AS institution_sponsorship
INNER JOIN public."Honor in Inscription" AS honor_appearance ON institution_sponsorship."Inscription ID" = honor_appearance."Inscription ID"
INNER JOIN public."Institution" AS sponsor ON institution_sponsorship."Institution ID" = sponsor."ID"
INNER JOIN public."Inscription Full"() AS inscription ON institution_sponsorship."Inscription ID" = inscription."ID"
INNER JOIN public."Honor" AS honor ON honor_appearance."Honor ID" = honor."ID"
ORDER BY sponsor."ID",
         honor."ID",
         inscription."ID";
