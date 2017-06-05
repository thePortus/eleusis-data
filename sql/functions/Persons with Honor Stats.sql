CREATE FUNCTION public."Persons with Honor Stats"(
    OUT "Person ID" integer,
    OUT "Total Honors" bigint,
    OUT "Different Honors" bigint,
    OUT "Magistracies" bigint,
    OUT "Sacred Offices" bigint,
    OUT "Liturgies/Benefactions" bigint,
    OUT "Other/Private Honors" bigint,
    OUT "Athenian Honors" bigint,
    OUT "Roman Honors" bigint,
    OUT "Other/Greek Honors" bigint
) RETURNS SETOF record AS
$BODY$
SELECT person_honor."Person ID" AS "Person ID",
        SUM(person_honor."Appearances") AS "Total Honors",
        COUNT(DISTINCT honor."ID") AS "Different Honors",
        SUM(CASE
                WHEN honor."Type" = 'Magistracy' THEN person_honor."Appearances"
                ELSE 0
            END) AS "Magistracies",
        SUM(CASE
                WHEN honor."Type" = 'Sacred Official' THEN person_honor."Appearances"
                ELSE 0
            END) AS "Sacred Offices",
        SUM(CASE
                WHEN honor."Type" = 'Liturgy/Benefaction' THEN person_honor."Appearances"
                ELSE 0
            END) AS "Liturgies/Benefactions",
        SUM(CASE
                WHEN honor."Type" = 'Private Office'
                     OR honor."Type" = 'Membership/Status' THEN person_honor."Appearances"
                ELSE 0
            END) AS "Other/Private Honors",
        SUM(CASE
                WHEN honor."Category" = 'Athenian'
                     OR honor."Category" = 'Eleusinian' THEN person_honor."Appearances"
                ELSE 0
            END) AS "Athenian Honors",
        SUM(CASE
                WHEN honor."Category" = 'Roman' THEN person_honor."Appearances"
                ELSE 0
            END) AS "Roman Honors",
        SUM(CASE
                WHEN honor."Category" = 'Greek'
                     OR honor."Category" = 'Panhellenic'
                     OR honor."Category" = 'Other' THEN person_honor."Appearances"
                ELSE 0
            END) AS "Other/Greek Honors"
 FROM (public."Person Honor Display" AS person_honor
       INNER JOIN public."Honor" AS honor ON person_honor."Honor ID" = honor."ID")
 GROUP BY person_honor."Person ID"
 $BODY$
 LANGUAGE sql STABLE NOT LEAKPROOF;
