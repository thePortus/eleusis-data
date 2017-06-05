CREATE FUNCTION public."Earliest Date"(
    IN thing_id INTEGER,
    OUT "Date" REAL
) RETURNS REAL AS
$BODY$
SELECT MIN(inscription."Date") AS "Date"
FROM public."Person in Inscription" as person_appearance
INNER JOIN public."Inscription" AS inscription ON person_appearance."Inscription ID" = inscription."ID"
WHERE person_appearance."Person ID" = thing_id
UNION ALL
SELECT MIN(inscription."Date") AS "Date"
FROM public."Institution Sponsorship" as institution_sponsorship
INNER JOIN public."Inscription" AS inscription ON institution_sponsorship."Inscription ID" = inscription."ID"
WHERE institution_sponsorship."Institution ID" = thing_id
UNION ALL
SELECT MIN(inscription."Date") AS "Date"
FROM public."Honor in Inscription" as honor_appearance
INNER JOIN public."Inscription" AS inscription ON honor_appearance."Inscription ID" = inscription."ID"
WHERE honor_appearance."Honor ID" = thing_id
$BODY$
LANGUAGE sql STABLE NOT LEAKPROOF;
