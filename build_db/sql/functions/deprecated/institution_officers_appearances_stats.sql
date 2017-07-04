CREATE FUNCTION public.institution_officers_appearances_stats(
    IN institution_id integer,
    OUT "Officers" bigint,
    OUT "Athenians" bigint,
    OUT "Romans" bigint,
    OUT "Imperial Family" bigint,
    OUT "Other Greeks" bigint,
    OUT "Other/Uncertain" bigint,
    OUT "Females" bigint,
    OUT "Males" bigint,
    OUT "Athenian Citizens" bigint,
    OUT "Roman Citizens" bigint,
    OUT "Athenians without Roman Citizenship" bigint,
    OUT "Athenians with Roman Citizenship" bigint,
    OUT "Officer Appearances" bigint,
    OUT "Athenian Appearances" bigint,
    OUT "Roman Appearances" bigint,
    OUT "Imperial Family Appearances" bigint,
    OUT "Other Greek Appearances" bigint,
    OUT "Other/Uncertain Appearances" bigint,
    OUT "Female Appearances" bigint,
    OUT "Male Appearances" bigint,
    OUT "Athenian Citizen Appearances" bigint,
    OUT "Roman Citizen Appearances" bigint,
    OUT "Athenian without Roman Citizenship Appearances" bigint,
    OUT "Athenian with Roman Citizenship Appearances" bigint,
    OUT "Sponsor Appearances" bigint,
    OUT "Honorand Appearances" bigint,
    OUT "Other Role Appearances" bigint,
    OUT "Inscriptions" bigint,
    OUT "Dedication Inscriptions" bigint,
    OUT "Decrees Inscriptions" bigint,
    OUT "Edict/Regulation Inscriptions" bigint,
    OUT "Epistle Inscriptions" bigint,
    OUT "Verse Inscriptions" bigint,
    OUT "Other/Fragmentary Inscriptions" bigint,
    OUT "Base Inscriptions" bigint,
    OUT "Altar Inscriptions" bigint,
    OUT "Building/Monument Inscriptions" bigint,
    OUT "Column/Herm Inscriptions" bigint,
    OUT "Stele Inscriptions" bigint,
    OUT "Other/Fragmentary Object Inscriptions" bigint,
    OUT "Before the Telesterion Inscriptions" bigint,
    OUT "Between the Propylaea Inscriptions" bigint,
    OUT "North of the Telesterion Inscriptions" bigint,
    OUT "Outer Courtyard Inscriptions" bigint,
    OUT "South Wall Inscriptions" bigint,
    OUT "Upper Terrace Inscriptions" bigint,
    OUT "Inscription Appearances" bigint,
    OUT "Dedication Appearances" bigint,
    OUT "Decree Appearances" bigint,
    OUT "Edict/Regulation Appearances" bigint,
    OUT "Epistle Appearances" bigint,
    OUT "Verse Inscription Appearances" bigint,
    OUT "Other/Fragmentary Inscription Appearances" bigint,
    OUT "Base Appearances" bigint,
    OUT "Altar Appearances" bigint,
    OUT "Building/Monument Appearances" bigint,
    OUT "Columns/Herm Appearances" bigint,
    OUT "Stele Appearances" bigint,
    OUT "Other/Fragmentary Object Appearances" bigint,
    OUT "Before the Telesterion Inscription Appearances" bigint,
    OUT "Between the Propylaea Inscription Appearances" bigint,
    OUT "North of the Telesterion Inscription Appearances" bigint,
    OUT "Outer Courtyard Inscription Appearances" bigint,
    OUT "South Wall Inscription Appearances" bigint,
    OUT "Upper Terrace Inscription Appearances" bigint
) RETURNS record AS
$BODY$
SELECT COUNT(DISTINCT officer."ID") AS "Officers",
       COUNT(DISTINCT CASE
                          WHEN officer."Category" = 'Athenian' THEN officer."ID"
                      END) AS "Athenians",
       COUNT(DISTINCT CASE
                          WHEN officer."Category" = 'Roman' THEN officer."ID"
                      END) AS "Romans",
       COUNT(DISTINCT CASE
                          WHEN officer."Category" = 'Imperial Family Member' THEN officer."ID"
                      END) AS "Imperial Family",
       COUNT(DISTINCT CASE
                          WHEN officer."Category" = 'Greek'
                               OR officer."Category" = 'Other Greek' THEN officer."ID"
                      END) AS "Other Greeks",
       COUNT(DISTINCT CASE
                          WHEN officer."Category" = 'Other'
                               OR officer."Category" = 'Uncertain' THEN officer."ID"
                      END) AS "Others/Uncertain",
       COUNT(DISTINCT CASE
                          WHEN officer."Gender" = 'Female' THEN officer."ID"
                      END) AS "Females",
       COUNT(DISTINCT CASE
                          WHEN officer."Gender" = 'Male' THEN officer."ID"
                      END) AS "Males",
       COUNT(DISTINCT CASE
                          WHEN officer."Athenian Citizen" = TRUE THEN officer."ID"
                      END) AS "Athenian Citizens",
       COUNT(DISTINCT CASE
                          WHEN officer."Roman Citizen" = TRUE THEN officer."ID"
                      END) AS "Roman Citizens",
       COUNT(DISTINCT CASE
                          WHEN officer."Category" = 'Athenian'
                               AND officer."Roman Citizen" = FALSE THEN officer."ID"
                      END) AS "Athenians without Roman Citizenship",
       COUNT(DISTINCT CASE
                          WHEN officer."Category" = 'Athenian'
                               AND officer."Roman Citizen" = TRUE THEN officer."ID"
                      END) AS "Athenians with Roman Citizenship",
       COUNT(officer."ID") AS "Officer Appearances",
       COUNT(CASE
                 WHEN officer."Category" = 'Athenian' THEN 1
             END) AS "Athenian Appearances",
       COUNT(CASE
                 WHEN officer."Category" = 'Roman' THEN 1
             END) AS "Roman Appearances",
       COUNT(CASE
                 WHEN officer."Category" = 'Imperial Family Member' THEN 1
             END) AS "Imperial Family Appearances",
       COUNT(CASE
                 WHEN officer."Category" = 'Greek'
                      OR officer."Category" = 'Other Greek' THEN 1
             END) AS "Other Greek Appearances",
       COUNT(CASE
                 WHEN officer."Category" = 'Other'
                      OR officer."Category" = 'Uncertain' THEN 1
             END) AS "Other/Uncertain Appearances",
       COUNT(CASE
                 WHEN officer."Gender" = 'Female' THEN 1
             END) AS "Female Appearances",
       COUNT(CASE
                 WHEN officer."Gender" = 'Male' THEN 1
             END) AS "Male Appearances",
       COUNT(CASE
                 WHEN officer."Athenian Citizen" = TRUE THEN 1
             END) AS "Athenian Citizen Appearances",
       COUNT(CASE
                 WHEN officer."Roman Citizen" = TRUE THEN 1
             END) AS "Roman Citizen Appearances",
       COUNT(CASE
                 WHEN officer."Category" = 'Athenian'
                      AND officer."Roman Citizen" = FALSE THEN 1
             END) AS "Athenian without Roman Citizenship Appearances",
       COUNT(CASE
                 WHEN officer."Category" = 'Athenian'
                      AND officer."Roman Citizen" = TRUE THEN 1
             END) AS "Athenian with Roman Citizenship Appearances",
       COUNT(CASE
                 WHEN person_appearance."Role" = 'Sponsor' THEN 1
             END) AS "Sponsor Appearances",
       COUNT(CASE
                 WHEN person_appearance."Role" = 'Honoree' THEN 1
             END) AS "Honorand Appearances",
       COUNT(CASE
                 WHEN (person_appearance."Role" != 'Honoree'
                      AND person_appearance."Role" != 'Sponsor') OR person_appearance."Role" IS NULL THEN 1
             END) AS "Other Role Appearances",
       COUNT(DISTINCT inscription_with_text."ID") AS "Inscriptions",
       COUNT(DISTINCT CASE
                          WHEN inscription_with_text."Inscription Type" = 'Dedication' THEN inscription_with_text."ID"
                      END) AS "Dedication Inscriptions",
       COUNT(DISTINCT CASE
                          WHEN inscription_with_text."Inscription Type" = 'Decree' THEN inscription_with_text."ID"
                      END) AS "Decree Inscriptions",
       COUNT(DISTINCT CASE
                          WHEN inscription_with_text."Inscription Type" = 'Edict/Regulation' THEN inscription_with_text."ID"
                      END) AS "Edict/Regulation Inscriptions",
       COUNT(DISTINCT CASE
                          WHEN inscription_with_text."Inscription Type" = 'Epistle' THEN inscription_with_text."ID"
                      END) AS "Epistle Inscriptions",
       COUNT(DISTINCT CASE
                          WHEN inscription_with_text."Inscription Type" = 'Verse' THEN inscription_with_text."ID"
                      END) AS "Verse Inscriptions",
       COUNT(DISTINCT CASE
                          WHEN inscription_with_text."Inscription Type" = 'Other/Fragmentary' THEN inscription_with_text."ID"
                      END) AS "Other/Fragmentary Inscriptions",
       COUNT(DISTINCT CASE
                          WHEN inscription_with_text."Object Type" = 'Base' THEN inscription_with_text."ID"
                      END) AS "Base Inscriptions",
       COUNT(DISTINCT CASE
                          WHEN inscription_with_text."Object Type" = 'Altar' THEN inscription_with_text."ID"
                      END) AS "Altar Inscriptions",
       COUNT(DISTINCT CASE
                          WHEN inscription_with_text."Object Type" = 'Building/Monument' THEN inscription_with_text."ID"
                      END) AS "Building/Monument Inscriptions",
       COUNT(DISTINCT CASE
                          WHEN inscription_with_text."Object Type" = 'Column/Herm' THEN inscription_with_text."ID"
                      END) AS "Column/Herm Inscriptions",
       COUNT(DISTINCT CASE
                          WHEN inscription_with_text."Object Type" = 'Stele' THEN inscription_with_text."ID"
                      END) AS "Stele Inscriptions",
       COUNT(DISTINCT CASE
                          WHEN inscription_with_text."Object Type" = 'Other/Fragmentary' THEN inscription_with_text."ID"
                      END) AS "Other/Fragmentary Object Inscriptions",
       COUNT(DISTINCT CASE
                          WHEN inscription_with_text."Suspected Location" = 'Before the Telesterion' THEN inscription_with_text."ID"
                      END) AS "Before Telesterion Inscriptions",
       COUNT(DISTINCT CASE
                          WHEN inscription_with_text."Suspected Location" = 'Between the Propylaea' THEN inscription_with_text."ID"
                      END) AS "Between the Propylaea Inscriptions",
       COUNT(DISTINCT CASE
                          WHEN inscription_with_text."Suspected Location" = 'North of the Telesterion' THEN inscription_with_text."ID"
                      END) AS "North of the Telesterion Inscriptions",
       COUNT(DISTINCT CASE
                          WHEN inscription_with_text."Suspected Location" = 'Outer Courtyard' THEN inscription_with_text."ID"
                      END) AS "Outer Courtyard Inscriptions",
       COUNT(DISTINCT CASE
                          WHEN inscription_with_text."Suspected Location" = 'South Wall' THEN inscription_with_text."ID"
                      END) AS "South Wall Inscriptions",
       COUNT(DISTINCT CASE
                          WHEN inscription_with_text."Suspected Location" = 'Upper Terrace' THEN inscription_with_text."ID"
                      END) AS "Upper Terrace Inscriptions",
       COUNT(inscription_with_text."ID") AS "Inscription Appearances",
       COUNT(CASE
                 WHEN inscription_with_text."Inscription Type" = 'Dedication' THEN 1
             END) AS "Dedication Appearances",
       COUNT(CASE
                 WHEN inscription_with_text."Inscription Type" = 'Decree' THEN 1
             END) AS "Decree Appearances",
       COUNT(CASE
                 WHEN inscription_with_text."Inscription Type" = 'Edict/Regulation' THEN 1
             END) AS "Edict/Regulation Appearances",
       COUNT(CASE
                 WHEN inscription_with_text."Inscription Type" = 'Epistle' THEN 1
             END) AS "Epistle Appearances",
       COUNT(CASE
                 WHEN inscription_with_text."Inscription Type" = 'Verse' THEN 1
             END) AS "Verse Appearances",
       COUNT(CASE
                 WHEN inscription_with_text."Inscription Type" = 'Other/Fragmentary' THEN 1
             END) AS "Other/Fragmentary Appearances",
       COUNT(CASE
                 WHEN inscription_with_text."Object Type" = 'Base' THEN 1
             END) AS "Base Appearances",
       COUNT(CASE
                 WHEN inscription_with_text."Object Type" = 'Altar' THEN 1
             END) AS "Altar Appearances",
       COUNT(CASE
                 WHEN inscription_with_text."Object Type" = 'Building/Monument' THEN 1
             END) AS "Building/Monument Appearances",
       COUNT(CASE
                 WHEN inscription_with_text."Object Type" = 'Column/Herm' THEN 1
             END) AS "Column/Herm Appearances",
       COUNT(CASE
                 WHEN inscription_with_text."Object Type" = 'Stele' THEN 1
             END) AS "Stele Appearances",
       COUNT(CASE
                 WHEN inscription_with_text."Object Type" = 'Other/Fragmentary' THEN 1
             END) AS "Other/Fragmentary Object Appearances",
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
             END) AS "Upper Terrace Appearances"
FROM public."Institution Honor" AS institution_honor
INNER JOIN public."Honor" honor ON institution_honor."Honor ID" = honor."ID"
INNER JOIN public."Person Honor Display" AS person_honor ON honor."ID" = person_honor."Honor ID"
INNER JOIN public."Person in Inscription" AS person_appearance ON person_honor."Person ID" = person_appearance."Person ID"
AND person_honor."Inscription ID" = person_appearance."Inscription ID"
INNER JOIN public."Person" AS officer ON person_honor."Person ID" = officer."ID"
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
     INNER JOIN public."Text" AS inscription_text ON inscription."ID" = inscription_text."ID") AS inscription_with_text ON person_honor."Inscription ID" = inscription_with_text."ID"
WHERE institution_honor."Institution ID" = institution_id
$BODY$
  LANGUAGE sql STABLE
