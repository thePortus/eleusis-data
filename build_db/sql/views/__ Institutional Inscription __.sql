DROP VIEW IF EXISTS public."__ Institutional Inscription __";
CREATE OR REPLACE VIEW public."__ Institutional Inscription __" AS
SELECT DISTINCT sponsor."Institution" AS "Institution",
                inscription."IE" AS "IE",
                sponsor."Category" AS "Institution Origin",
                sponsor."Type" AS "Institution Type",
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
                inscription."ID" AS "Inscription ID",
                sponsor."ID" AS "Institution ID"
FROM public."Institution Sponsorship" AS institution_sponsorship
INNER JOIN public."Institution" AS sponsor ON institution_sponsorship."Institution ID" = sponsor."ID"
INNER JOIN public."Inscription Full"() AS inscription ON institution_sponsorship."Inscription ID" = inscription."ID"
ORDER BY sponsor."ID",
         inscription."ID";
