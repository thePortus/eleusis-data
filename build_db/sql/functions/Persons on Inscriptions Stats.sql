CREATE FUNCTION public."Persons on Inscriptions Stats"(
    OUT "Person ID" CHARACTER VARYING,
    OUT "Total Inscriptions" bigint,
    OUT "Bases" bigint,
    OUT "Buildings/Monuments" bigint,
    OUT "Columns/Herms" bigint,
    OUT "Stelai" bigint,
    OUT "Altars" bigint,
    OUT "Other/Fragmented Objects" bigint,
    OUT "Dedications" bigint,
    OUT "Decrees" bigint,
    OUT "Edicts/Regulations" bigint,
    OUT "Epistles" bigint,
    OUT "Verses" bigint,
    OUT "Other/Uncertain Inscriptions" bigint,
    OUT "Before the Telesterion" bigint,
    OUT "Between the Propylaea" bigint,
    OUT "North of the Telesterion" bigint,
    OUT "Outer Courtyard" bigint,
    OUT "South Wall" bigint,
    OUT "Upper Terrace" bigint,
    OUT "Mean Inscription Date" numeric,
    OUT "Mean Inscription Date Span" numeric,
    OUT "Mean Inscription Word Count" numeric,
    OUT "Mean Inscription Character Count" numeric
) RETURNS SETOF record AS
$BODY$
SELECT person_appearance."Person ID" AS "Person ID",
        COUNT(DISTINCT inscription."ID") AS "Total Inscriptions",
        SUM(CASE
                WHEN inscription."Object Type" = 'Base' THEN 1
                ELSE 0
            END) AS "Bases",
        SUM(CASE
                WHEN inscription."Object Type" = 'Building/Monument' THEN 1
                ELSE 0
            END) AS "Buildings/Monuments",
        SUM(CASE
                WHEN inscription."Object Type" = 'Column/Herm' THEN 1
                ELSE 0
            END) AS "Columns/Herms",
        SUM(CASE
                WHEN inscription."Object Type" = 'Stele' THEN 1
                ELSE 0
            END) AS "Stelai",
        SUM(CASE
                WHEN inscription."Object Type" = 'Altar' THEN 1
                ELSE 0
            END) AS "Altars",
        SUM(CASE
                WHEN inscription."Object Type" = 'Other/Fragment' THEN 1
                ELSE 0
            END) AS "Other/Fragmented Objects",
        SUM(CASE
                WHEN inscription."Inscription Type" = 'Dedication' THEN 1
                ELSE 0
            END) AS "Dedications",
        SUM(CASE
                WHEN inscription."Inscription Type" = 'Decree' THEN 1
                ELSE 0
            END) AS "Decrees",
        SUM(CASE
                WHEN inscription."Inscription Type" = 'Edict/Regulation' THEN 1
                ELSE 0
            END) AS "Edicts/Regulations",
        SUM(CASE
                WHEN inscription."Inscription Type" = 'Epistle' THEN 1
                ELSE 0
            END) AS "Epistles",
        SUM(CASE
                WHEN inscription."Inscription Type" = 'Verse' THEN 1
                ELSE 0
            END) AS "Verses",
        SUM(CASE
                WHEN inscription."Inscription Type" = 'Other/Uncertain' THEN 1
                ELSE 0
            END) AS "Other/Uncertain Inscriptions",
        SUM(CASE
                WHEN inscription."Location" = 'Before the Telesterion' THEN 1
                ELSE 0
            END) AS "Before the Telesterion",
        SUM(CASE
                WHEN inscription."Location" = 'Between the Propylaea' THEN 1
                ELSE 0
            END) AS "Between the Propylaea",
        SUM(CASE
                WHEN inscription."Location" = 'North of the Telesterion' THEN 1
                ELSE 0
            END) AS "North of the Telesterion",
        SUM(CASE
                WHEN inscription."Location" = 'Outer Courtyard' THEN 1
                ELSE 0
            END) AS "Outer Courtyard",
        SUM(CASE
                WHEN inscription."Location" = 'South Wall' THEN 1
                ELSE 0
            END) AS "South Wall",
        SUM(CASE
                WHEN inscription."Location" = 'Upper Terrace' THEN 1
                ELSE 0
            END) AS "Upper Terrace",
        ROUND(CAST(AVG(inscription."Date") AS NUMERIC), 2) AS "Mean Inscription Date",
        ROUND(CAST(AVG(inscription."Date Span") AS NUMERIC), 2) AS "Mean Inscription Date Span",
        ROUND(CAST(AVG(inscription_text."Word Count") AS NUMERIC), 2) AS "Mean Inscription Word Count",
        ROUND(CAST(AVG(inscription_text."Character Count") AS NUMERIC), 2) AS "Mean Inscription Character Count"
 FROM (public."Person in Inscription" AS person_appearance
       INNER JOIN public."Inscription" AS inscription ON person_appearance."Inscription ID" = inscription."ID"
       INNER JOIN public."Text" AS inscription_text ON inscription."ID" = inscription_text."ID")
 GROUP BY person_appearance."Person ID"
 $BODY$
 LANGUAGE sql STABLE NOT LEAKPROOF;
