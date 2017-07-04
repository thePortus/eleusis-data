CREATE FUNCTION public."Inscription with References"(
    OUT "ID" INTEGER,
    OUT "References" CHARACTER VARYING
) RETURNS SETOF record AS
$BODY$
SELECT
inscription_references."Inscription ID" AS "ID",
string_agg(inscription_references."Reference", ',') AS "References"
FROM
(SELECT reference."Inscription ID" AS "Inscription ID",
       concat_ws(' ', reference."Publication", reference."Number", reference."Additional") AS "Reference",
       reference."Notes" AS "Notes"
FROM public."Inscription Reference" AS reference) as inscription_references
GROUP BY inscription_references."Inscription ID"
$BODY$
LANGUAGE sql STABLE NOT LEAKPROOF;
