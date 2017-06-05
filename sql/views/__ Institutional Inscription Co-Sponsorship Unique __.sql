CREATE OR REPLACE VIEW public."__ Institutional Inscription Co-Sponsorship Unique __" AS
SELECT DISTINCT sponsor."Institution" AS "Institution",
                cosponsor."Institution" AS "Co-sponsor",
                inscription."Inscription" AS "Inscription",
                sponsor."Category" AS "Institution Origin",
                sponsor."Type" AS "Institution Type",
                cosponsor."Category" AS "Co-sponsor Origin",
                cosponsor."Type" AS "Co-sponsor Type",
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
                sponsor."ID" AS "Institution ID",
                cosponsor."ID" AS "Co-sponsor ID"
FROM public."Institution Sponsorship" AS institution_sponsorship
INNER JOIN public."Institution Sponsorship" AS institution_cosponsorship ON institution_sponsorship."Inscription ID" = institution_cosponsorship."Inscription ID" AND institution_sponsorship."Institution ID" < institution_cosponsorship."Institution ID"
INNER JOIN public."Institution" AS sponsor ON institution_sponsorship."Institution ID" = sponsor."ID"
INNER JOIN public."Institution" AS cosponsor ON institution_cosponsorship."Institution ID" = cosponsor."ID"
INNER JOIN public."Inscription with Text"() AS inscription ON institution_sponsorship."Inscription ID" = inscription."ID"
ORDER BY sponsor."ID",
         cosponsor."ID",
         inscription."ID"
