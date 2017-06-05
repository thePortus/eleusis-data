CREATE FUNCTION public.institution_coappearances_institutions_stats(
    IN institution_id integer,
    OUT "Institutions" bigint,
    OUT "Public Institutions" bigint,
    OUT "Private Institutions" bigint,
    OUT "Gene" bigint,
    OUT "Athenian Institutions" bigint,
    OUT "Roman Institutions" bigint,
    OUT "Panhellenic Institutions" bigint,
    OUT "Greek Institutions" bigint,
    OUT "Other Institutions" bigint,
    OUT "Institution Appearances" bigint,
    OUT "Public Institution Appearances" bigint,
    OUT "Private Institution Appearances" bigint,
    OUT "Gene Appearances" bigint,
    OUT "Athenian Institution Appearances" bigint,
    OUT "Roman Institution Appearances" bigint,
    OUT "Panhellenic Institution Appearances" bigint,
    OUT "Greek Institution Appearances" bigint,
    OUT "Other Institution Appearances" bigint,
    OUT "Areopagus Appearances" bigint,
    OUT "Boule Appearances" bigint,
    OUT "Demos Appearanes" bigint,
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
SELECT COUNT(DISTINCT coappearer."ID") AS "Institutions",
       COUNT(DISTINCT CASE
                          WHEN coappearer."Type" = 'Public' THEN coappearer."ID"
                      END) AS "Public Institutions",
       COUNT(DISTINCT CASE
                          WHEN coappearer."Type" = 'Private' THEN coappearer."ID"
                      END) AS "Private Institutions",
       COUNT(DISTINCT CASE
                          WHEN coappearer."Type" = 'Genos' THEN coappearer."ID"
                      END) AS "Gene",
       COUNT(DISTINCT CASE
                          WHEN coappearer."Category" = 'Athenian'
                               OR coappearer."Category" = 'Eleusinian' THEN coappearer."ID"
                      END) AS "Athenian Institutions",
       COUNT(DISTINCT CASE
                          WHEN coappearer."Category" = 'Roman' THEN coappearer."ID"
                      END) AS "Roman Institutions",
       COUNT(DISTINCT CASE
                          WHEN coappearer."Category" = 'Panhellenic' THEN coappearer."ID"
                      END) AS "Panhellenic Institutions",
       COUNT(DISTINCT CASE
                          WHEN coappearer."Category" = 'Greek' THEN coappearer."ID"
                      END) AS "Greek Institutions",
       COUNT(DISTINCT CASE
                          WHEN coappearer."Category" = 'Other' THEN coappearer."ID"
                      END) AS "Other Institutions",
       COUNT(coappearer."ID") AS "Institution Appearances",
       COUNT(CASE
                 WHEN coappearer."Type" = 'Public' THEN 1
             END) AS "Public Institution Appearances",
       COUNT(CASE
                 WHEN coappearer."Type" = 'Private' THEN 1
             END) AS "Private Institution Appearances",
       COUNT(CASE
                 WHEN coappearer."Type" = 'Genos' THEN 1
             END) AS "Gene Appearances",
       COUNT(CASE
                 WHEN coappearer."Category" = 'Athenian'
                      OR coappearer."Category" = 'Eleusinian' THEN 1
             END) AS "Athenian Institution Appearances",
       COUNT(CASE
                 WHEN coappearer."Category" = 'Roman' THEN 1
             END) AS "Roman Institution Appearances",
       COUNT(CASE
                 WHEN coappearer."Category" = 'Panhellenic' THEN 1
             END) AS "Panhellenic Institution Appearances",
       COUNT(CASE
                 WHEN coappearer."Category" = 'Greek' THEN 1
             END) AS "Greek Institution Appearances",
       COUNT(CASE
                 WHEN coappearer."Category" = 'Other' THEN 1
             END) AS "Other Institution Appearances",
       COUNT(CASE
                 WHEN coappearer."Name" = 'Areopagus' THEN 1
             END) AS "Areopagus Appearances",
       COUNT(CASE
                 WHEN coappearer."Name" = 'Boule' THEN 1
             END) AS "Boule Appearances",
       COUNT(CASE
                 WHEN coappearer."Name" = 'Demos' THEN 1
             END) AS "Demos Appearances",
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
FROM public."Institution Sponsorship" AS institution_sponsorship
INNER JOIN public."Institution Sponsorship" AS coappearance ON institution_sponsorship."Inscription ID" = coappearance."Inscription ID"
AND institution_sponsorship."Institution ID" != coappearance."Institution ID"
INNER JOIN public."Institution" AS coappearer ON coappearance."Institution ID" = coappearer."ID"
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
     INNER JOIN public."Text" AS inscription_text ON inscription."ID" = inscription_text."ID") AS inscription_with_text ON coappearance."Inscription ID" = inscription_with_text."ID"
WHERE institution_sponsorship."Institution ID" = institution_id
$BODY$
  LANGUAGE sql STABLE
