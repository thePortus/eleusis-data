DROP VIEW public."__ Institutional Inscription Person Appearance__" IF EXISTS;
CREATE OR REPLACE VIEW public."__ Institutional Inscription Person Appearance__" AS
SELECT DISTINCT sponsor."Institution" AS "Sponsor",
                person."Person" AS "Person",
                inscription."IE" AS "IE",
                sponsor."Category" AS "Sponsor Origin",
                sponsor."Type" AS "Sponsor Type",
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
                person_appearance."Role" AS "Person Role",
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
                sponsor."ID" AS "Sponsor ID",
                person."ID" AS "Person ID",
                inscription."ID" AS "Inscription ID",
                person."Uncertain Person" AS "Person Uncertainty"
FROM public."Institution Sponsorship" AS institution_sponsorship
INNER JOIN public."Person in Inscription" AS person_appearance ON institution_sponsorship."Inscription ID" = person_appearance."Inscription ID"
INNER JOIN public."Institution" AS sponsor ON institution_sponsorship."Institution ID" = sponsor."ID"
INNER JOIN public."Inscription Full"() AS inscription ON institution_sponsorship."Inscription ID" = inscription."ID"
INNER JOIN public."Person" AS person ON person_appearance."Person ID" = person."ID"
ORDER BY sponsor."ID",
         person."ID",
         inscription."ID";
