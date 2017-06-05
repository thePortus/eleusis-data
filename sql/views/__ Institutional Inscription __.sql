CREATE OR REPLACE VIEW public."__ Institutional Inscription __" AS
SELECT DISTINCT sponsor."Institution" AS "Institution",
                inscription."Inscription" AS "Inscription",
                sponsor."Category" AS "Institution Origin",
                sponsor."Type" AS "Institution Type",
                inscription."IE" AS "IE",
                inscription."Object Type" AS "Object Type",
                inscription."Inscription Type" AS "Inscription Type",
                inscription."Location" AS "Location",
                inscription."Date" AS "Date",
                inscription."Date Span" AS "Date Span",
                inscription."Word Count" AS "Word Count",
                inscription."Character Count" AS "Character Count",
                inscription."Text" AS "Text",
                inscription."ID" AS "Inscription ID",
                sponsor."ID" AS "Institution ID"
FROM public."Institution Sponsorship" AS institution_sponsorship
INNER JOIN public."Institution" AS sponsor ON institution_sponsorship."Institution ID" = sponsor."ID"
INNER JOIN public."Inscription with Text"() AS inscription ON institution_sponsorship."Inscription ID" = inscription."ID"
ORDER BY sponsor."ID",
         inscription."ID"
