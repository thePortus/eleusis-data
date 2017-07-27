DROP FUNCTION IF EXISTS public."Person is Institution Officer";
CREATE FUNCTION public."Person is Institution Officer"(
    IN person_id INTEGER,
    IN institution_id INTEGER,
    OUT "Is Officer" BOOLEAN
) RETURNS BOOLEAN AS
$BODY$
SELECT
    CASE
        WHEN COUNT(institution_honor."Institution ID") > 0 THEN TRUE
        ELSE FALSE
    END AS "Is Officer"
FROM public."Person" as person
    LEFT JOIN public."Person Honor Display" as person_honor
        ON person."ID" = person_honor."Person ID"
    INNER JOIN public."Institution Honor" as institution_honor
        ON person_honor."Honor ID" = institution_honor."Honor ID"
WHERE
    person_honor."Person ID" = person_id and institution_honor."Institution ID" = institution_id
GROUP BY
    institution_honor."Institution ID"
$BODY$
LANGUAGE sql STABLE NOT LEAKPROOF;
