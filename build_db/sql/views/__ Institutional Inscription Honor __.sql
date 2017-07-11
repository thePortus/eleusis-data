DROP VIEW public."__ Institutional Inscription Honor __" IF EXISTS;
CREATE OR REPLACE VIEW public."__ Institutional Inscription Honor __" AS
SELECT DISTINCT sponsor."Institution" AS "Institution",
                honor."Honor" AS "Honor",
                sponsor."Category" AS "Institution Origin",
                sponsor."Type" AS "Institution Type",
                honor."Type" AS "Honor Type",
                honor."Category" AS "Honor Origin",
                SUM(honor_appearance."Appearances") AS "Appearances",
                sponsor."ID" AS "Institution ID",
                honor."ID" AS "Office ID"
FROM public."Institution Sponsorship" AS institution_sponsorship
INNER JOIN public."Honor in Inscription" AS honor_appearance ON institution_sponsorship."Inscription ID" = honor_appearance."Inscription ID"
INNER JOIN public."Institution" AS sponsor ON institution_sponsorship."Institution ID" = sponsor."ID"
INNER JOIN public."Inscription Full"() AS inscription ON institution_sponsorship."Inscription ID" = inscription."ID"
INNER JOIN public."Honor" AS honor ON honor_appearance."Honor ID" = honor."ID"
GROUP BY honor."ID",
         sponsor."ID"
ORDER BY sponsor."ID",
         honor."ID";
