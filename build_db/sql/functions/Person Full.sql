CREATE FUNCTION public."Person Full"(
    OUT "ID" CHARACTER VARYING,
    OUT "Person" CHARACTER VARYING,
    OUT "Category" CHARACTER VARYING,
    OUT "Origin" CHARACTER VARYING,
    OUT "Gender" CHARACTER VARYING,
    OUT "Status" CHARACTER VARYING,
    OUT "Family" CHARACTER VARYING,
    OUT "Extended" CHARACTER VARYING,
    OUT "Praenomen" CHARACTER VARYING,
    OUT "Nomen" CHARACTER VARYING,
    OUT "Cognomen" CHARACTER VARYING,
    OUT "Onomos" CHARACTER VARYING,
    OUT "Patronym" CHARACTER VARYING,
    OUT "Deme" CHARACTER VARYING,
    OUT "Earliest Date" REAL,
    OUT "Areopagus Officer" BOOLEAN,
    OUT "Boule Officer" BOOLEAN,
    OUT "Demos Officer" BOOLEAN,
    OUT "Kerykes Officer" BOOLEAN,
    OUT "Eumolpidai Officer" BOOLEAN,
    OUT "Philleidai Officer" BOOLEAN,
    OUT "Uncertain Person" BOOLEAN
) RETURNS SETOF record AS
$BODY$
SELECT person."ID" AS "ID",
       person."Person" AS "Person",
       person."Category" AS "Category",
       person."Origin" AS "Origin",
       person."Gender" AS "Gender",
       CASE
           WHEN person."Category" = 'Athenian'
                AND person."Roman Citizen" = FALSE THEN 'Athenian without Roman Citizenship'
           WHEN person."Category" = 'Athenian'
                AND person."Roman Citizen" = TRUE THEN 'Athenian with Roman Citizenship'
           ELSE 'Non-Athenian'
       END AS "Status",
       person."Family" AS "Family",
       person."Extended" AS "Extended",
       person."Praenomen" AS "Praenomen",
       person."Nomen" AS "Nomen",
       person."Cognomen" AS "Cognomen",
       person."Onomos" AS "Onomos",
       person."Patronym" AS "Patronym",
       person."Deme" AS "Deme",
       public."Earliest Date"(person."ID") AS "Earliest Date",
       public."Person is Institution Officer"(person."ID", 'areopagus') AS "Areopagus Officer",
       public."Person is Institution Officer"(person."ID", 'boule') AS "Boule Officer",
       public."Person is Institution Officer"(person."ID", 'demos') AS "Demos Officer",
       public."Person is Institution Officer"(person."ID", 'kerykes') AS "Kerykes Officer",
       public."Person is Institution Officer"(person."ID", 'eumolpidai') AS "Eumolpidai Officer",
       public."Person is Institution Officer"(person."ID", 'philleidai') AS "Phileidai Officer",
       person."Uncertain Person" AS "Uncertain Person"
-- Person
FROM public."Person" AS person
$BODY$
LANGUAGE sql STABLE NOT LEAKPROOF;
