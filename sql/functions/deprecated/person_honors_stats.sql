CREATE FUNCTION public.person_honors_stats(
    IN person_id integer,
    OUT "Honors" bigint,
    OUT "Athenian Honors" bigint,
    OUT "Eleusinian Honors" bigint,
    OUT "Roman Honors" bigint,
    OUT "Other Greek Honors" bigint,
    OUT "Panhellenic Honors" bigint,
    OUT "Magistracies" bigint,
    OUT "Sacred Offices" bigint,
    OUT "Liturgies/Benefactions" bigint,
    OUT "Memberships/Statuses" bigint,
    OUT "Private Offices" bigint
) RETURNS record AS
$BODY$
SELECT COUNT(honor."ID") AS "Honors",
       COUNT(CASE
                 WHEN honor."Category" = 'Athenian' THEN 1
             END) AS "Athenian Honors",
       COUNT(CASE
                 WHEN honor."Category" = 'Eleusinian' THEN 1
             END) AS "Eleusinian Honors",
       COUNT(CASE
                 WHEN honor."Category" = 'Roman' THEN 1
             END) AS "Roman Honors",
       COUNT(CASE
                 WHEN honor."Category" = 'Greek' THEN 1
             END) AS "Greek Honors",
       COUNT(CASE
                 WHEN honor."Category" = 'Panhellenic' THEN 1
             END) AS "Panhellenic Honors",
       COUNT(CASE
                 WHEN honor."Type" = 'Magistracy' THEN 1
             END) AS "Magistracies",
       COUNT(CASE
                 WHEN honor."Type" = 'Sacred Official' THEN 1
             END) AS "Sacred Offices",
       COUNT(CASE
                 WHEN honor."Type" = 'Liturgy/Benefaction' THEN 1
             END) AS "Liturgies/Benefactions",
       COUNT(CASE
                 WHEN honor."Type" = 'Membership/Status' THEN 1
             END) AS "Memberships/Statuses",
       COUNT(CASE
                 WHEN honor."Type" = 'Private Office' THEN 1
             END) AS "Private Offices"
FROM (public."Honor" AS honor
      INNER JOIN public."Person Honor Display" AS commemoration ON honor."ID" = commemoration."Honor ID")
WHERE commemoration."Person ID" = person_id
$BODY$
LANGUAGE sql STABLE NOT LEAKPROOF;
