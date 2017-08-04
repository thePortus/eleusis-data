CREATE FUNCTION public."Inscription Honors Stats"(
    OUT "Inscription ID" integer,
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
SELECT honor_appearance."Inscription ID" AS "Inscription ID",
        SUM(honor_appearance."Appearances") AS "Total Honors",
        COUNT(DISTINCT honor."ID") AS "Different Honors",
        SUM(CASE
                WHEN honor."Type" = 'Magistracy' THEN honor_appearance."Appearances"
                ELSE 0
            END) AS "Magistracies",
        SUM(CASE
                WHEN honor."Type" = 'Sacred Official' THEN honor_appearance."Appearances"
                ELSE 0
            END) AS "Sacred Offices",
        SUM(CASE
                WHEN honor."Type" = 'Liturgy/Benefaction' THEN honor_appearance."Appearances"
                ELSE 0
            END) AS "Liturgies/Benefactions",
        SUM(CASE
                WHEN honor."Type" = 'Private Office'
                     OR honor."Type" = 'Membership/Status' THEN honor_appearance."Appearances"
                ELSE 0
            END) AS "Other/Private Honors",
        SUM(CASE
                WHEN honor."Category" = 'Athenian'
                     OR honor."Category" = 'Eleusinian' THEN honor_appearance."Appearances"
                ELSE 0
            END) AS "Athenian Honors",
        SUM(CASE
                WHEN honor."Category" = 'Roman' THEN honor_appearance."Appearances"
                ELSE 0
            END) AS "Roman Honors",
        SUM(CASE
                WHEN honor."Category" = 'Greek'
                     OR honor."Category" = 'Panhellenic'
                     OR honor."Category" = 'Other' THEN honor_appearance."Appearances"
                ELSE 0
            END) AS "Other/Greek Honors"
 FROM public."Honor in Inscription" AS honor_appearance
 INNER JOIN public."Honor" AS honor ON honor_appearance."Honor ID" = honor."ID"
 GROUP BY honor_appearance."Inscription ID"
 $BODY$
 LANGUAGE sql STABLE NOT LEAKPROOF;
