CREATE FUNCTION public.institution_inscriptions_stats(
    IN institution_id integer,
    OUT "Appearances" bigint,
    OUT "Dedications" bigint,
    OUT "Decrees" bigint,
    OUT "Edicts/Regulations" bigint,
    OUT "Epistles" bigint,
    OUT "Verse Inscriptions" bigint,
    OUT "Other/Fragmentary Inscriptions" bigint,
    OUT "Bases" bigint,
    OUT "Altars" bigint,
    OUT "Buildings/Monuments" bigint,
    OUT "Columns/Herms" bigint,
    OUT "Steles" bigint,
    OUT "Other/Fragmentary Objects" bigint,
    OUT "Before the Telesterion Appearances" bigint,
    OUT "Between the Propylaea Appearances" bigint,
    OUT "North of the Telesterion Appearances" bigint,
    OUT "Outer Courtyard" bigint,
    OUT "South Wall Appearances" bigint,
    OUT "Upper Terrace Appearances" bigint,
    OUT "Mean Date of Inscriptions" double precision,
    OUT "Mean Date Span" double precision,
    OUT "Mean Word Count" numeric,
    OUT "Mean Character Count" numeric
) RETURNS record AS
$BODY$
SELECT COUNT(inscription_with_text."ID") AS "Appearances",
       COUNT(CASE
                 WHEN inscription_with_text."Inscription Type" = 'Dedication' THEN 1
             END) AS "Dedications",
       COUNT(CASE
                 WHEN inscription_with_text."Inscription Type" = 'Decree' THEN 1
             END) AS "Decrees",
       COUNT(CASE
                 WHEN inscription_with_text."Inscription Type" = 'Edict/Regulation' THEN 1
             END) AS "Edicts/Regulations",
       COUNT(CASE
                 WHEN inscription_with_text."Inscription Type" = 'Epistle' THEN 1
             END) AS "Epistles",
       COUNT(CASE
                 WHEN inscription_with_text."Inscription Type" = 'Verse' THEN 1
             END) AS "Verse Inscriptions",
       COUNT(CASE
                 WHEN inscription_with_text."Inscription Type" = 'Other/Fragmentary' THEN 1
             END) AS "Other/Fragmentary Inscriptions",
       COUNT(CASE
                 WHEN inscription_with_text."Object Type" = 'Base' THEN 1
             END) AS "Bases",
       COUNT(CASE
                 WHEN inscription_with_text."Object Type" = 'Altar' THEN 1
             END) AS "Altars",
       COUNT(CASE
                 WHEN inscription_with_text."Object Type" = 'Building/Monument' THEN 1
             END) AS "Buildings/Monuments",
       COUNT(CASE
                 WHEN inscription_with_text."Object Type" = 'Column/Herm' THEN 1
             END) AS "Column/Herms",
       COUNT(CASE
                 WHEN inscription_with_text."Object Type" = 'Stele' THEN 1
             END) AS "Steles",
       COUNT(CASE
                 WHEN inscription_with_text."Object Type" = 'Other/Fragmentary' THEN 1
             END) AS "Other/Fragmentary Objects",
       COUNT(CASE
                 WHEN inscription_with_text."Suspected Location" = 'Before the Telesterion' THEN 1
             END) AS "Before Telesterion Appearances",
       COUNT(CASE
                 WHEN inscription_with_text."Suspected Location" = 'Between the Propylaea' THEN 1
             END) AS "Between the Propylaea Appearances",
       COUNT(CASE
                 WHEN inscription_with_text."Suspected Location" = 'North of the Telesterion' THEN 1
             END) AS "North of the Telesterion Appearances",
       COUNT(CASE
                 WHEN inscription_with_text."Suspected Location" = 'Outer Courtyard' THEN 1
             END) AS "Outer Courtyard Appearances",
       COUNT(CASE
                 WHEN inscription_with_text."Suspected Location" = 'South Wall' THEN 1
             END) AS "South Wall Appearances",
       COUNT(CASE
                 WHEN inscription_with_text."Suspected Location" = 'Upper Terrace' THEN 1
             END) AS "Upper Terrace Appearances",
       ROUND(AVG(inscription_with_text."Date")) AS "Mean Date of Inscriptions",
       ROUND(AVG(inscription_with_text."Date Span")) AS "Mean Date Span",
       ROUND(AVG(inscription_with_text."Word Count")) AS "Mean Word Count",
       ROUND(AVG(inscription_with_text."Character Count")) AS "Mean Character Count"
FROM public."Institution Sponsorship" AS appearance
INNER JOIN
    (SELECT inscription."ID",
            inscription."IE",
            inscription."Title",
            inscription."Object Type",
            inscription."Inscription Type",
            inscription."Suspected Location",
            inscription."Low Date",
            inscription."High Date",
            inscription."Date",
            inscription."Date Span",
            inscription_text."Text",
            inscription_text."Word Count",
            inscription_text."Character Count"
     FROM public."Inscription" AS inscription
     INNER JOIN public."Text" AS inscription_text ON inscription."ID" = inscription_text."ID") AS inscription_with_text ON appearance."Inscription ID" = inscription_with_text."ID"
WHERE appearance."Institution ID" = institution_id
$BODY$
LANGUAGE sql STABLE NOT LEAKPROOF;
