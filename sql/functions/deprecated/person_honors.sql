CREATE FUNCTION public.person_honors(
    IN person_id integer,
    OUT "ID" integer,
    OUT "Honor" character varying,
    OUT "Category" character varying,
    OUT "Type" character varying,
    OUT "Inscription ID" integer,
    OUT "Appearances" integer
) RETURNS SETOF record AS
$BODY$
SELECT honor."ID" AS "ID",
        honor."Honor" AS "Honor",
        honor."Category" AS "Category",
        honor."Type" AS "Type",
        commemoration."Inscription ID" AS "Inscription ID", commemoration."Appearances" AS "Appearances"
FROM (public."Honor" AS honor
      INNER JOIN public."Person Honor Display" AS commemoration ON honor."ID" = commemoration."Honor ID")
WHERE commemoration."Person ID" = person_id
$BODY$
LANGUAGE sql STABLE NOT LEAKPROOF;
