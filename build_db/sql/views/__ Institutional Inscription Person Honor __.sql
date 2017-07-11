DROP VIEW IF EXISTS public."__ Institutional Inscription Person Honor __";
CREATE OR REPLACE VIEW public."__ Institutional Inscription Person Honor __" AS
SELECT DISTINCT sponsor."Institution" AS "Institution",
                honor."Honor" AS "Honor",
                person."Person" AS "Person",
                sponsor."Category" AS "Institution Origin",
                sponsor."Type" AS "Institution Type",
                honor."Type" AS "Honor Type",
                honor."Category" AS "Honor Origin",
                SUM(person_honor."Appearances") AS "Honor Appearances",
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
                sponsor."ID" AS "Institution ID",
                honor."ID" AS "Office ID",
                person."ID" AS "Person ID",
                person."Uncertain Person" AS "Person Uncertainty"
FROM public."Institution Sponsorship" AS institution_sponsorship
INNER JOIN public."Person Honor Display" AS person_honor ON institution_sponsorship."Inscription ID" = person_honor."Inscription ID"
INNER JOIN public."Person in Inscription" AS person_appearance ON person_honor."Person ID" = person_appearance."Person ID"
AND person_honor."Inscription ID" = person_appearance."Inscription ID"
INNER JOIN public."Institution" AS sponsor ON institution_sponsorship."Institution ID" = sponsor."ID"
INNER JOIN public."Inscription Full"() AS inscription ON institution_sponsorship."Inscription ID" = inscription."ID"
INNER JOIN public."Person" AS person ON person_honor."Person ID" = person."ID"
AND person_appearance."Person ID" = person."ID"
INNER JOIN public."Honor" AS honor ON person_honor."Honor ID" = honor."ID"
GROUP BY honor."ID", person."ID", sponsor."ID"
ORDER BY sponsor."ID",
         honor."ID",
         person."ID";
