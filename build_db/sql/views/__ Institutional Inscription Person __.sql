CREATE OR REPLACE VIEW public."__ Institutional Inscription Person __" AS
SELECT DISTINCT sponsor."Institution" AS "Sponsor",
                person."Person" AS "Person",
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
                sponsor."ID" AS "Sponsor ID",
                person."ID" AS "Person ID",
                person."Uncertain Person" AS "Person Uncertainty"
FROM public."Institution Sponsorship" AS institution_sponsorship
INNER JOIN public."Person in Inscription" AS person_appearance ON institution_sponsorship."Inscription ID" = person_appearance."Inscription ID"
INNER JOIN public."Institution" AS sponsor ON institution_sponsorship."Institution ID" = sponsor."ID"
INNER JOIN public."Inscription Full"() AS inscription ON institution_sponsorship."Inscription ID" = inscription."ID"
INNER JOIN public."Person" AS person ON person_appearance."Person ID" = person."ID"
GROUP BY person."ID", sponsor."ID"
ORDER BY sponsor."ID",
         person."ID";
