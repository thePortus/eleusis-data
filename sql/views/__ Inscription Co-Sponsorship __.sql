CREATE OR REPLACE VIEW public."__ Inscription Co-Sponsorship __" AS
-- Person to Person Cosponsorships
SELECT DISTINCT inscription."IE" AS "IE",
                'Person-Person' AS "Co-Sponsorship Type",
                sponsor."Person" AS "Sponsor",
                cosponsor."Person" AS "Co-Sponsor",
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
                'Person' AS "Sponsor Class",
                sponsor."Category" AS "Sponsor Origin",
                CASE
                    WHEN sponsor."Category" = 'Athenian'
                         AND sponsor."Roman Citizen" = FALSE THEN 'Athenian without Roman Citizenship'
                    WHEN sponsor."Category" = 'Athenian'
                         AND sponsor."Roman Citizen" = TRUE THEN 'Athenian with Roman Citizenship'
                    ELSE 'Non-Athenian'
                END AS "Sponsor Status",
                NULL AS "Sponsor Type",
                sponsor."Gender" AS "Sponsor Gender",
                sponsor."Family" AS "Sponsor Family",
                sponsor."Extended" AS "Sponsor Extended Family",
                sponsor."Deme" AS "Sponsor Deme",
                'Person' AS "Co-Sponsor Class",
                cosponsor."Category" AS "Co-Sponsor Origin",
                CASE
                    WHEN cosponsor."Category" = 'Athenian'
                         AND cosponsor."Roman Citizen" = FALSE THEN 'Athenian without Roman Citizenship'
                    WHEN cosponsor."Category" = 'Athenian'
                         AND cosponsor."Roman Citizen" = TRUE THEN 'Athenian with Roman Citizenship'
                    ELSE 'Non-Athenian'
                END AS "Co-Sponsor Status",
                NULL AS "Co-Sponsor Type",
                cosponsor."Gender" AS "Co-Sponsor Gender",
                cosponsor."Family" AS "Co-Sponsor Family",
                cosponsor."Extended" AS "Co-Sponsor Extended Family",
                cosponsor."Deme" AS "Co-Sponsor Deme",
                inscription."ID" AS "Inscription ID",
                sponsor."ID" AS "Sponsor ID",
                cosponsor."ID" AS "Co-Sponsor ID",
                sponsor."Uncertain Person" AS "Sponsor Uncertainty",
                cosponsor."Uncertain Person" AS "Co-Sponsor Uncertainty"
FROM
public."Person in Inscription" AS sponsorship
INNER JOIN public."Person in Inscription" AS cosponsorship ON sponsorship."Inscription ID" = cosponsorship."Inscription ID"
INNER JOIN public."Inscription Full"() AS inscription ON sponsorship."Inscription ID" = inscription."ID"
INNER JOIN public."Person" AS sponsor ON sponsorship."Person ID" = sponsor."ID"
INNER JOIN public."Person" AS cosponsor ON cosponsorship."Person ID" = cosponsor."ID"
WHERE sponsorship."Person ID" != cosponsorship."Person ID" AND sponsorship."Role" = 'Sponsor' AND cosponsorship."Role" = 'Sponsor'
UNION ALL
-- Person to Institution Cosponsorships
SELECT DISTINCT inscription."IE" AS "IE",
                'Person-Institution' AS "Co-Sponsorship Type",
                sponsor."Person" AS "Sponsor",
                cosponsor."Institution" AS "Co-Sponsor",
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
                'Person' AS "Sponsor Class",
                sponsor."Category" AS "Sponsor Origin",
                CASE
                    WHEN sponsor."Category" = 'Athenian'
                         AND sponsor."Roman Citizen" = FALSE THEN 'Athenian without Roman Citizenship'
                    WHEN sponsor."Category" = 'Athenian'
                         AND sponsor."Roman Citizen" = TRUE THEN 'Athenian with Roman Citizenship'
                    ELSE 'Non-Athenian'
                END AS "Sponsor Status",
                NULL AS "Sponsor Type",
                sponsor."Gender" AS "Sponsor Gender",
                sponsor."Family" AS "Sponsor Family",
                sponsor."Extended" AS "Sponsor Extended Family",
                sponsor."Deme" AS "Sponsor Deme",
                'Institution' AS "Co-Sponsor Class",
                cosponsor."Category" AS "Sponsor Origin",
                NULL AS "Co-Sponsor Status",
                cosponsor."Type" AS "Co-Sponsor Type",
                NULL AS "Co-Sponsor Gender",
                NULL AS "Co-Sponsor Family",
                NULL AS "Co-Sponsor Extended Family",
                NULL AS "Co-Sponsor Deme",
                inscription."ID" AS "Inscription ID",
                sponsor."ID" AS "Sponsor ID",
                cosponsor."ID" AS "Co-Sponsor ID",
                sponsor."Uncertain Person" AS "Sponsor Uncertainty",
                cosponsorship."Uncertain" AS "Co-Sponsor Uncertainty"
FROM
public."Person in Inscription" as sponsorship
INNER JOIN public."Institution Sponsorship" as cosponsorship ON sponsorship."Inscription ID" = cosponsorship."Inscription ID"
INNER JOIN public."Inscription Full"() as inscription on sponsorship."Inscription ID" = inscription."ID"
INNER JOIN public."Person" AS sponsor ON sponsorship."Person ID" = sponsor."ID"
INNER JOIN public."Institution" AS cosponsor ON cosponsorship."Institution ID" = cosponsor."ID"
WHERE sponsorship."Role" = 'Sponsor'
UNION ALL
-- Institution to Institution Co-Sponsorships
SELECT DISTINCT inscription."IE" AS "IE",
                'Institution-Institution' AS "Co-Sponsorship Type",
                sponsor."Institution" AS "Sponsor",
                cosponsor."Institution" AS "Co-Sponsor",
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
                'Institution' AS "Sponsor Class",
                sponsor."Category" AS "Sponsor Origin",
                NULL AS "Sponsor Status",
                sponsor."Type" AS "Sponsor Type",
                NULL AS "Sponsor Gender",
                NULL AS "Sponsor Family",
                NULL AS "Sponsor Extended Family",
                NULL AS "Sponsor Deme",
                'Institution' AS "Co-Sponsor Class",
                cosponsor."Category" AS "Sponsor Origin",
                NULL AS "Co-Sponsor Status",
                cosponsor."Type" AS "Co-Sponsor Type",
                NULL AS "Co-Sponsor Gender",
                NULL AS "Co-Sponsor Family",
                NULL AS "Co-Sponsor Extended Family",
                NULL AS "Co-Sponsor Deme",
                inscription."ID" AS "Inscription ID",
                sponsor."ID" AS "Sponsor ID",
                cosponsor."ID" AS "Co-Sponsor ID",
                sponsorship."Uncertain" AS "Sponsor Uncertainty",
                cosponsorship."Uncertain" AS "Co-Sponsor Uncertainty"
FROM
public."Institution Sponsorship" as sponsorship
INNER JOIN public."Institution Sponsorship" as cosponsorship ON sponsorship."Inscription ID" = cosponsorship."Inscription ID"
INNER JOIN public."Inscription Full"() as inscription on sponsorship."Inscription ID" = inscription."ID"
INNER JOIN public."Institution" AS sponsor ON sponsorship."Institution ID" = sponsor."ID"
INNER JOIN public."Institution" AS cosponsor ON cosponsorship."Institution ID" = cosponsor."ID"
WHERE sponsorship."Role" = 'Sponsor' AND sponsor."ID" != cosponsor."ID"
