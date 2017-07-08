-- Roman Eleusis build_database.sql
-- by David J. Thomas, thePortus.com


-- =============START OF TABLES=============
-- Table from: /Users/davidthomas/Git/brown-diss/build_db/sql/tables/Inscription.sql

-- Table: public."Inscription"

-- DROP TABLE public."Inscription";

CREATE TABLE public."Inscription"
(
  "ID" integer NOT NULL,
  "IE" character varying(10),
  "Inscription" character varying(500),
  "Object Type" character varying(200),
  "Inscription Type" character varying(200),
  "Suspected Location" character varying(200),
  "Low Date" integer,
  "High Date" integer,
  "Date" real,
  "Date Span" real,
  "Low Date Uncertain" boolean,
  "High Date Uncertain" boolean,
  "Notes" character varying(1000),
  CONSTRAINT "Inscriptions_pkey" PRIMARY KEY ("ID")
)
WITH (
  OIDS=FALSE
);


-- Table from: /Users/davidthomas/Git/brown-diss/build_db/sql/tables/Inscription Text.sql

-- Table: public."Text"

-- DROP TABLE public."Text";

CREATE TABLE public."Text"
(
  "ID" integer NOT NULL,
  "Raw Text" text,
  "Text" text,
  "Lemmata" text,
  "Word Count" integer,
  "Character Count" integer,
  CONSTRAINT "Text_pkey" PRIMARY KEY ("ID"),
  CONSTRAINT "ID" FOREIGN KEY ("ID")
      REFERENCES public."Inscription" ("ID") MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE
)
WITH (
  OIDS=FALSE
);


-- Table from: /Users/davidthomas/Git/brown-diss/build_db/sql/tables/Inscription Reference.sql

-- Table: public."Inscription Reference"

-- DROP TABLE public."Inscription Reference";

CREATE TABLE public."Inscription Reference"
(
  "Inscription ID" integer NOT NULL,
  "Publication" character varying(50),
  "Number" character varying(50),
  "Additional" character varying(50),
  "Notes" character varying(500),
  CONSTRAINT "Inscription Reference_pkey" PRIMARY KEY ("Inscription ID", "Publication", "Number"),
  CONSTRAINT "Ref_Inscription Reference_to_Inscription" FOREIGN KEY ("Inscription ID")
      REFERENCES public."Inscription" ("ID") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);


-- Table from: /Users/davidthomas/Git/brown-diss/build_db/sql/tables/Inscription Feature.sql

-- Table: public."Inscription Feature"

-- DROP TABLE public."Inscription Feature";

CREATE TABLE public."Inscription Feature"
(
  "ID" integer NOT NULL,
  "Inscription ID" integer,
  "Feature" Text,
  "Uncertain" boolean,
  "Notes" text,
  CONSTRAINT "Inscription Feature_pkey" PRIMARY KEY ("ID"),
  CONSTRAINT "Ref_Inscription Feature_to_Inscription" FOREIGN KEY ("Inscription ID")
      REFERENCES public."Inscription" ("ID") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);


-- Table from: /Users/davidthomas/Git/brown-diss/build_db/sql/tables/Inscription Macroscopic.sql

-- Table: public."Inscription Macroscopic"

-- DROP TABLE public."Inscription Macroscopic";

CREATE TABLE public."Inscription Macroscopic"
(
  "ID" character varying(10) NOT NULL,
  "Title" character varying(500),
  "Date" integer,
  "Date Strength" character varying(100),
  "Inscription Type" character varying(100),
  "Object Type" character varying(100),
  "Altered" character varying(100),
  "Visuals" character varying(300),
  "Text Format" character varying(100),
  "Sponsor Type" character varying(100),
  "Honorand Type" character varying(100),
  CONSTRAINT "Inscription Macroscopic_pkey" PRIMARY KEY ("ID")
)
WITH (
  OIDS=FALSE
);


-- Table from: /Users/davidthomas/Git/brown-diss/build_db/sql/tables/Institution.sql

-- Table: public."Institution"

-- DROP TABLE public."Institution";

CREATE TABLE public."Institution"
(
  "ID" integer NOT NULL,
  "Institution" character varying(100),
  "Origin" character varying(200),
  "Type" character varying(200),
  "Category" character varying(200),
  "Notes" character varying(1000),
  CONSTRAINT "Institutions_pkey" PRIMARY KEY ("ID")
)
WITH (
  OIDS=FALSE
);


-- Table from: /Users/davidthomas/Git/brown-diss/build_db/sql/tables/Honor.sql

-- Table: public."Honor"

-- DROP TABLE public."Honor";

CREATE TABLE public."Honor"
(
  "ID" integer NOT NULL,
  "Honor" character varying(100),
  "Origin" character varying(100),
  "Category" character varying(100),
  "Type" character varying(100),
  "Notes" character varying(1000),
  CONSTRAINT "Honor_pkey" PRIMARY KEY ("ID")
)
WITH (
  OIDS=FALSE
);


-- Table from: /Users/davidthomas/Git/brown-diss/build_db/sql/tables/Person.sql

-- Table: public."Person"

-- DROP TABLE public."Person";

CREATE TABLE public."Person"
(
  "ID" integer NOT NULL,
  "Person" character varying(500),
  "Category" character varying(100),
  "Origin" character varying(100),
  "Gender" character varying(100),
  "Athenian Citizen" boolean,
  "Roman Citizen" boolean,
  "Family" character varying(100),
  "Extended" character varying(100),
  "Praenomen" character varying(100),
  "Nomen" character varying(100),
  "Cognomen" character varying(100),
  "Onomos" character varying(100),
  "Patronym" character varying(100),
  "Deme" character varying(100),
  "Uncertain Person" boolean,
  CONSTRAINT "Person_pkey" PRIMARY KEY ("ID")
)
WITH (
  OIDS=FALSE
);


-- Table from: /Users/davidthomas/Git/brown-diss/build_db/sql/tables/Institution Honor.sql

-- Table: public."Institution Honor"

-- DROP TABLE public."Institution Honor";

CREATE TABLE public."Institution Honor"
(
  "Institution ID" integer NOT NULL,
  "Honor ID" integer NOT NULL,
  "Notes" character varying(1000),
  CONSTRAINT "Institution Honor_pkey" PRIMARY KEY ("Honor ID", "Institution ID"),
  CONSTRAINT "Ref_Institution Honor_to_Honor" FOREIGN KEY ("Honor ID")
      REFERENCES public."Honor" ("ID") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "Ref_Institution Honor_to_Institutions" FOREIGN KEY ("Institution ID")
      REFERENCES public."Institution" ("ID") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);


-- Table from: /Users/davidthomas/Git/brown-diss/build_db/sql/tables/Honor in Inscription.sql

-- Table: public."Honor in Inscription"

-- DROP TABLE public."Honor in Inscription";

CREATE TABLE public."Honor in Inscription"
(
  "Honor ID" integer NOT NULL,
  "Inscription ID" integer NOT NULL,
  "Appearances" integer,
  "Notes" character varying(1000),
  CONSTRAINT "Honor in Inscription_pkey" PRIMARY KEY ("Inscription ID", "Honor ID"),
  CONSTRAINT "Ref_Honor in Inscription_to_Honor" FOREIGN KEY ("Honor ID")
      REFERENCES public."Honor" ("ID") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "Ref_Honor in Inscription_to_Inscriptions" FOREIGN KEY ("Inscription ID")
      REFERENCES public."Inscription" ("ID") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);


-- Table from: /Users/davidthomas/Git/brown-diss/build_db/sql/tables/Institution Sponsorship.sql

-- Table: public."Institution Sponsorship"

-- DROP TABLE public."Institution Sponsorship";

CREATE TABLE public."Institution Sponsorship"
(
  "Institution ID" integer NOT NULL,
  "Inscription ID" integer NOT NULL,
  "Role" character varying(20),
  "Uncertain" boolean,
  "Notes" character varying(1000),
  CONSTRAINT "Institution Sponsorship_pkey" PRIMARY KEY ("Institution ID", "Inscription ID"),
  CONSTRAINT "Ref_Institution Sponsorship_to_Inscriptions" FOREIGN KEY ("Inscription ID")
      REFERENCES public."Inscription" ("ID") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "Ref_Institution Sponsorship_to_Institutions" FOREIGN KEY ("Institution ID")
      REFERENCES public."Institution" ("ID") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);


-- Table from: /Users/davidthomas/Git/brown-diss/build_db/sql/tables/Person in Inscription.sql

-- Table: public."Person in Inscription"

-- DROP TABLE public."Person in Inscription";

CREATE TABLE public."Person in Inscription"
(
  "Person ID" integer NOT NULL,
  "Inscription ID" integer NOT NULL,
  "Role" character varying(50),
  "Notes" character varying(500),
  CONSTRAINT "People in Inscriptions_pkey" PRIMARY KEY ("Inscription ID", "Person ID"),
  CONSTRAINT "Ref_People in Inscriptions_to_Inscription" FOREIGN KEY ("Inscription ID")
      REFERENCES public."Inscription" ("ID") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "Ref_People in Inscriptions_to_Person" FOREIGN KEY ("Person ID")
      REFERENCES public."Person" ("ID") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);


-- Table from: /Users/davidthomas/Git/brown-diss/build_db/sql/tables/Person Honor Display.sql

-- Table: public."Person Honor Display"

-- DROP TABLE public."Person Honor Display";

CREATE TABLE public."Person Honor Display"
(
  "Person ID" integer NOT NULL,
  "Honor ID" integer NOT NULL,
  "Inscription ID" integer NOT NULL,
  "Uncertain" boolean,
  "Appearances" integer,
  CONSTRAINT "Person Honor Display_pkey" PRIMARY KEY ("Honor ID", "Person ID", "Inscription ID"),
  CONSTRAINT "Ref_Person Honor Display_to_Honor" FOREIGN KEY ("Honor ID")
      REFERENCES public."Honor" ("ID") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "Ref_Person Honor Display_to_Inscriptions" FOREIGN KEY ("Inscription ID")
      REFERENCES public."Inscription" ("ID") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "Ref_Person Honor Display_to_Person" FOREIGN KEY ("Person ID")
      REFERENCES public."Person" ("ID") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);


-- =============END OF TABLES=============

-- =============START OF FUNCTIONS=============
-- Function from: /Users/davidthomas/Git/brown-diss/build_db/sql/functions/Inscription Full.sql

CREATE FUNCTION public."Inscription Full"(
    OUT "ID" INTEGER,
    OUT "IE" CHARACTER VARYING,
    OUT "Inscription" CHARACTER VARYING,
    OUT "Object Type" CHARACTER VARYING,
    OUT "Inscription Type" CHARACTER VARYING,
    OUT "Location" CHARACTER VARYING,
    OUT "Date" REAL,
    OUT "Date Span" REAL,
    OUT "Word Count" INTEGER,
    OUT "Character Count" INTEGER,
    OUT "Text" TEXT,
    OUT "Features" TEXT,
    OUT "References" CHARACTER VARYING
) RETURNS SETOF record AS
$BODY$
SELECT inscription."ID" AS "ID",
       inscription."IE" AS "IE",
       inscription."Inscription" AS "Inscription",
       inscription."Object Type" AS "Object Type",
       inscription."Inscription Type" AS "Inscription Type",
       inscription."Suspected Location" AS "Location",
       inscription."Date" AS "Date",
       inscription."Date Span" AS "Date Span",
       inscription_text."Word Count" AS "Word Count",
       inscription_text."Character Count" AS "Character Count",
       inscription_text."Text" AS "Text",
        features."Features" AS "Features",
        reference."References" AS "References"
-- Inscription
FROM public."Inscription" AS inscription
-- Inscription Text
INNER JOIN public."Text" AS inscription_text ON inscription."ID" = inscription_text."ID"
-- Inscription References
LEFT JOIN (
    SELECT
    inscription_references."Inscription ID" AS "ID",
    string_agg(inscription_references."Reference", ',') AS "References"
    FROM
    (SELECT reference."Inscription ID" AS "Inscription ID",
           concat_ws(' ', reference."Publication", reference."Number", reference."Additional") AS "Reference",
           reference."Notes" AS "Notes"
    FROM public."Inscription Reference" AS reference) AS inscription_references
    GROUP BY inscription_references."Inscription ID"
) AS reference ON inscription."ID" = reference."ID"
-- Inscription Features
LEFT JOIN (
    SELECT
    inscription_features."Inscription ID" AS "ID",
    string_agg(inscription_features."Feature", ',') AS "Features"
    FROM public."Inscription Feature" AS inscription_features
    GROUP BY inscription_features."Inscription ID"
) AS features ON inscription."ID" = features."ID"
$BODY$
LANGUAGE sql STABLE NOT LEAKPROOF;


-- Function from: /Users/davidthomas/Git/brown-diss/build_db/sql/functions/Inscription Honors Stats.sql

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


-- Function from: /Users/davidthomas/Git/brown-diss/build_db/sql/functions/Inscription Institutions Stats.sql

CREATE FUNCTION public."Inscription Institutions Stats"(
    OUT "Inscription ID" integer,
    OUT "Total Institutions" bigint,
    OUT "Institution Sponsors" bigint,
    OUT "Public Institutions" bigint,
    OUT "Private Institutions" bigint,
    OUT "Gene" bigint,
    OUT "Athenian Institutions" bigint,
    OUT "Roman Institutions" bigint,
    OUT "Other/Greek Institutions" bigint
) RETURNS SETOF record AS
$BODY$
SELECT institution_sponsorship."Inscription ID" AS "Inscription ID",
        COUNT(DISTINCT institution."ID") AS "Total Institutions",
        SUM(CASE
                WHEN institution_sponsorship."Role" = 'Sponsor' THEN 1
                ELSE 0
            END) AS "Institution Sponsors",
        SUM(CASE
                WHEN institution."Type" = 'Public' THEN 1
                ELSE 0
            END) AS "Public Institutions",
        SUM(CASE
                WHEN institution."Type" = 'Private' THEN 1
                ELSE 0
            END) AS "Private Institutions",
        SUM(CASE
                WHEN institution."Type" = 'Genos' THEN 1
                ELSE 0
            END) AS "Gene",
        SUM(CASE
                WHEN institution."Category" = 'Athenian'
                     OR institution."Category" = 'Eleusinian' THEN 1
                ELSE 0
            END) AS "Athenian Institutions",
        SUM(CASE
                WHEN institution."Category" = 'Roman' THEN 1
                ELSE 0
            END) AS "Roman Institutions",
        SUM(CASE
                WHEN institution."Category" = 'Greek'
                     OR institution."Category" = 'Panhellenic'
                     OR institution."Category" = 'Other' THEN 1
                ELSE 0
            END) AS "Other/Greek Institutions"
 FROM public."Institution Sponsorship" AS institution_sponsorship
 INNER JOIN public."Institution" AS institution ON institution_sponsorship."Institution ID" = institution."ID"
 GROUP BY institution_sponsorship."Inscription ID"
 $BODY$
 LANGUAGE sql STABLE NOT LEAKPROOF;


-- Function from: /Users/davidthomas/Git/brown-diss/build_db/sql/functions/Inscription People Stats.sql

CREATE FUNCTION public."Inscription People Stats"(
    OUT "Inscription ID" integer,
    OUT "People" bigint,
    OUT "Females" bigint,
    OUT "Males" bigint,
    OUT "Athenians" bigint,
    OUT "Romans" bigint,
    OUT "Imperial Family" bigint,
    OUT "Greeks" bigint,
    OUT "Athenians without Roman Citizenship" bigint,
    OUT "Athenians with Roman Citizenship" bigint,
    OUT "Individual Sponsors" bigint,
    OUT "Honorands" bigint
) RETURNS SETOF record AS
$BODY$
SELECT person_appearance."Inscription ID" AS "Inscription ID",
        COUNT(DISTINCT person."ID") AS "People",
        COUNT(DISTINCT CASE
                           WHEN person."Gender" = 'Female' THEN person."ID"
                       END) AS "Females",
        COUNT(DISTINCT CASE
                           WHEN person."Gender" = 'Male' THEN person."ID"
                       END) AS "Males",
        COUNT(DISTINCT CASE
                           WHEN person."Category" = 'Athenian' THEN person."ID"
                       END) AS "Athenians",
        COUNT(DISTINCT CASE
                           WHEN person."Category" = 'Roman' THEN person."ID"
                       END) AS "Romans",
        COUNT(DISTINCT CASE
                           WHEN person."Category" = 'Imperial Family' THEN person."ID"
                       END) AS "Imperial Family",
        COUNT(DISTINCT CASE
                           WHEN person."Category" = 'Other Greek' THEN person."ID"
                       END) AS "Greeks",
        COUNT(DISTINCT CASE
                           WHEN person."Category" = 'Athenian'
                                AND person."Roman Citizen" = FALSE THEN person."ID"
                       END) AS "Athenians without Roman Citizenship",
        COUNT(DISTINCT CASE
                           WHEN person."Category" = 'Athenian'
                                AND person."Roman Citizen" = TRUE THEN person."ID"
                       END) AS "Athenians with Roman Citizenship",
        COUNT(DISTINCT CASE
                           WHEN person_appearance."Role" = 'Sponsor' THEN person."ID"
                       END) AS "Sponsors",
        COUNT(DISTINCT CASE
                           WHEN person_appearance."Role" = 'Honorand' THEN person."ID"
                       END) AS "Honorands"
 FROM public."Person in Inscription" AS person_appearance
 INNER JOIN public."Person" AS person ON person_appearance."Person ID" = person."ID"
 GROUP BY person_appearance."Inscription ID"
 $BODY$
 LANGUAGE sql STABLE NOT LEAKPROOF;


-- Function from: /Users/davidthomas/Git/brown-diss/build_db/sql/functions/Persons on Inscriptions Stats.sql

CREATE FUNCTION public."Persons on Inscriptions Stats"(
    OUT "Person ID" integer,
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
                WHEN inscription."Suspected Location" = 'Before the Telesterion' THEN 1
                ELSE 0
            END) AS "Before the Telesterion",
        SUM(CASE
                WHEN inscription."Suspected Location" = 'Between the Propylaea' THEN 1
                ELSE 0
            END) AS "Between the Propylaea",
        SUM(CASE
                WHEN inscription."Suspected Location" = 'North of the Telesterion' THEN 1
                ELSE 0
            END) AS "North of the Telesterion",
        SUM(CASE
                WHEN inscription."Suspected Location" = 'Outer Courtyard' THEN 1
                ELSE 0
            END) AS "Outer Courtyard",
        SUM(CASE
                WHEN inscription."Suspected Location" = 'South Wall' THEN 1
                ELSE 0
            END) AS "South Wall",
        SUM(CASE
                WHEN inscription."Suspected Location" = 'Upper Terrace' THEN 1
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


-- Function from: /Users/davidthomas/Git/brown-diss/build_db/sql/functions/Persons on Institution Inscriptions Stats.sql

CREATE FUNCTION public."Persons on Institution Inscriptions Stats"(
    OUT "Person ID" integer,
    OUT "As Institution Honorand" bigint,
    OUT "As Institution Non-Honorand" bigint,
    OUT "As Public Honorand" bigint,
    OUT "As Public Non-Honorand" bigint,
    OUT "As Private Honorand" bigint,
    OUT "As Private Non-Honorand" bigint,
    OUT "As Genos Honorand" bigint,
    OUT "As Genos Non-Honorand" bigint,
    OUT "As Areopagus Honorand" bigint,
    OUT "As Areopagus Non-Honorand" bigint,
    OUT "As Boule Honorand" bigint,
    OUT "As Boule Non-Honorand" bigint,
    OUT "As Demos Honorand" bigint,
    OUT "As Demos Non-Honorand" bigint,
    OUT "As Eumolpidai Honorand" bigint,
    OUT "As Eumolpidai Non-Honorand" bigint,
    OUT "As Kerykes Honorand" bigint,
    OUT "As Kerykes Non-Honorand" bigint
) RETURNS SETOF record AS
$BODY$
SELECT person_appearance."Person ID" AS "Person ID",
       COUNT(DISTINCT CASE
                          WHEN person_appearance."Role" = 'Honorand' THEN person_appearance."Inscription ID"
                      END) AS "As Institution Honorand",
       COUNT(DISTINCT CASE
                          WHEN person_appearance."Role" != 'Honorand' THEN person_appearance."Inscription ID"
                      END) AS "As Institution Non-Honorand",
       COUNT(DISTINCT CASE
                          WHEN person_appearance."Role" = 'Honorand'
                               AND institution."Type" = 'Public' THEN person_appearance."Inscription ID"
                      END) AS "As Public Honorand",
       COUNT(DISTINCT CASE
                          WHEN person_appearance."Role" != 'Honorand'
                               AND institution."Type" = 'Public' THEN person_appearance."Inscription ID"
                      END) AS "As Public Non-Honorand",
       COUNT(DISTINCT CASE
                          WHEN person_appearance."Role" = 'Honorand'
                               AND institution."Type" = 'Private' THEN person_appearance."Inscription ID"
                      END) AS "As Private Honorand",
       COUNT(DISTINCT CASE
                          WHEN person_appearance."Role" != 'Honorand'
                               AND institution."Type" = 'Private' THEN person_appearance."Inscription ID"
                      END) AS "As Private Non-Honorand",
       COUNT(DISTINCT CASE
                          WHEN person_appearance."Role" = 'Honorand'
                               AND institution."Type" = 'Genos' THEN person_appearance."Inscription ID"
                      END) AS "As Genos Honorand",
       COUNT(DISTINCT CASE
                          WHEN person_appearance."Role" != 'Honorand'
                               AND institution."Type" = 'Genos' THEN person_appearance."Inscription ID"
                      END) AS "As Genos Non-Honorand",
       COUNT(DISTINCT CASE
                          WHEN person_appearance."Role" = 'Honorand'
                               AND institution."Institution" = 'Areopagus' THEN person_appearance."Inscription ID"
                      END) AS "As Areopagus Honorand",
       COUNT(DISTINCT CASE
                          WHEN person_appearance."Role" != 'Honorand'
                               AND institution."Institution" = 'Areopagus' THEN person_appearance."Inscription ID"
                      END) AS "As Areopagus Non-Honorand",
       COUNT(DISTINCT CASE
                          WHEN person_appearance."Role" = 'Honorand'
                               AND institution."Institution" = 'Boule' THEN person_appearance."Inscription ID"
                      END) AS "As Boule Honorand",
       COUNT(DISTINCT CASE
                          WHEN person_appearance."Role" != 'Honorand'
                               AND institution."Institution" = 'Boule' THEN person_appearance."Inscription ID"
                      END) AS "As Boule Non-Honorand",
       COUNT(DISTINCT CASE
                          WHEN person_appearance."Role" = 'Honorand'
                               AND institution."Institution" = 'Demos' THEN person_appearance."Inscription ID"
                      END) AS "As Demos Honorand",
       COUNT(DISTINCT CASE
                          WHEN person_appearance."Role" != 'Honorand'
                               AND institution."Institution" = 'Demos' THEN person_appearance."Inscription ID"
                      END) AS "As Demos Non-Honorand",
       COUNT(DISTINCT CASE
                          WHEN person_appearance."Role" = 'Honorand'
                               AND institution."Institution" = 'Eumolpidai' THEN person_appearance."Inscription ID"
                      END) AS "As Eumolpidai Honorand",
       COUNT(DISTINCT CASE
                          WHEN person_appearance."Role" != 'Honorand'
                               AND institution."Institution" = 'Eumolpidai' THEN person_appearance."Inscription ID"
                      END) AS "As Eumolpidai Non-Honorand",
       COUNT(DISTINCT CASE
                          WHEN person_appearance."Role" = 'Honorand'
                               AND institution."Institution" = 'Kerykes' THEN person_appearance."Inscription ID"
                      END) AS "As Kerykes Honorand",
       COUNT(DISTINCT CASE
                          WHEN person_appearance."Role" != 'Honorand'
                               AND institution."Institution" = 'Kerykes' THEN person_appearance."Inscription ID"
                      END) AS "As Kerykes Non-Honorand"
FROM (public."Person in Inscription" AS person_appearance
      INNER JOIN public."Institution Sponsorship" AS institution_sponsorship ON person_appearance."Inscription ID" = institution_sponsorship."Inscription ID"
      INNER JOIN public."Institution" AS institution ON institution_sponsorship."Institution ID" = institution."ID")
GROUP BY person_appearance."Person ID"
$BODY$
LANGUAGE sql STABLE NOT LEAKPROOF;


-- Function from: /Users/davidthomas/Git/brown-diss/build_db/sql/functions/Persons with Honor Stats.sql

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


-- Function from: /Users/davidthomas/Git/brown-diss/build_db/sql/functions/Persons Combined Stats.sql

CREATE FUNCTION public."Persons Combined Stats"(
    OUT "ID" INTEGER,
    OUT "Person" CHARACTER VARYING,
    OUT "Origin" CHARACTER VARYING,
    OUT "Gender" CHARACTER VARYING,
    OUT "Athenian with Roman Citizenship" BOOLEAN,
    OUT "Family" CHARACTER VARYING,
    OUT "Extended" CHARACTER VARYING,
    OUT "Deme" CHARACTER VARYING,
    OUT "Total Inscriptions" BIGINT,
    OUT "Bases" BIGINT,
    OUT "Buildings/Monuments" BIGINT,
    OUT "Columns/Herms" BIGINT,
    OUT "Stelai" BIGINT,
    OUT "Altars" BIGINT,
    OUT "Other/Fragmented Objects" BIGINT,
    OUT "Dedications" BIGINT,
    OUT "Decrees" BIGINT,
    OUT "Edicts/Regulations" BIGINT,
    OUT "Epistles" BIGINT,
    OUT "Verses" BIGINT,
    OUT "Other/Uncertain Inscriptions" BIGINT,
    OUT "Before the Telesterion" BIGINT,
    OUT "Between the Propylaea" BIGINT,
    OUT "North of the Telesterion" BIGINT,
    OUT "Outer Courtyard" BIGINT,
    OUT "South Wall" BIGINT,
    OUT "Upper Terrace" BIGINT,
    OUT "Mean Inscription Date" NUMERIC,
    OUT "Mean Inscription Date Span" NUMERIC,
    OUT "Mean Inscription Word Count" NUMERIC,
    OUT "Mean Inscription Character Count" NUMERIC,
    OUT "Total Honors" BIGINT,
    OUT "Different Honors" BIGINT,
    OUT "Magistracies" BIGINT,
    OUT "Sacred Offices" BIGINT,
    OUT "Liturgies/Benefactions" BIGINT,
    OUT "Other/Private Honors" BIGINT,
    OUT "Athenian Honors" BIGINT,
    OUT "Roman Honors" BIGINT,
    OUT "Other/Greek Honors" BIGINT,
    OUT "As Institution Honorand" BIGINT,
    OUT "As Institution Non-Honorand" BIGINT,
    OUT "As Public Honorand" BIGINT,
    OUT "As Public Non-Honorand" BIGINT,
    OUT "As Private Honorand" BIGINT,
    OUT "As Private Non-Honorand" BIGINT,
    OUT "As Genos Honorand" BIGINT,
    OUT "As Genos Non-Honorand" BIGINT,
    OUT "As Areopagus Honorand" BIGINT,
    OUT "As Areopagus Non-Honorand" BIGINT,
    OUT "As Boule Honorand" BIGINT,
    OUT "As Boule Non-Honorand" BIGINT,
    OUT "As Demos Honorand" BIGINT,
    OUT "As Demos Non-Honorand" BIGINT,
    OUT "As Eumolpidai Honorand" BIGINT,
    OUT  "As Eumolpidai Non-Honorand" BIGINT,
    OUT "As Kerykes Honorand" BIGINT,
    OUT "As Kerykes Non-Honorand" BIGINT
) RETURNS SETOF record AS
$BODY$
SELECT person."ID" AS "ID",
       person."Person" AS "Person",
       person."Category" AS "Origin",
       person."Gender" AS "Gender",
       (CASE
            WHEN person."Category" = 'Athenian'
                 AND person."Roman Citizen" = TRUE THEN TRUE
            ELSE FALSE
        END) AS "Athenian with Roman Citizenship",
       person."Family" AS "Family",
       person."Extended" AS "Extended",
       person."Deme" AS "Deme",
       COALESCE(inscription_stats."Total Inscriptions", 0) AS "Total Inscriptions",
       COALESCE(inscription_stats."Bases", 0) AS "Bases",
       COALESCE(inscription_stats."Buildings/Monuments", 0) AS "Buildings/Monuments",
       COALESCE(inscription_stats."Columns/Herms", 0) AS "Columns/Herms",
       COALESCE(inscription_stats."Stelai", 0) AS "Stelai",
       COALESCE(inscription_stats."Altars", 0) AS "Altars",
       COALESCE(inscription_stats."Other/Fragmented Objects", 0) AS "Other/Fragmented Objects",
       COALESCE(inscription_stats."Dedications", 0) AS "Dedications",
       COALESCE(inscription_stats."Decrees", 0) AS "Decrees",
       COALESCE(inscription_stats."Edicts/Regulations", 0) AS "Edicts/Regulations",
       COALESCE(inscription_stats."Epistles", 0) AS "Epistles",
       COALESCE(inscription_stats."Verses", 0) AS "Verses",
       COALESCE(inscription_stats."Other/Uncertain Inscriptions", 0) AS "Other/Uncertain Inscriptions",
       COALESCE(inscription_stats."Before the Telesterion", 0) AS "Before the Telesterion",
       COALESCE(inscription_stats."Between the Propylaea", 0) AS "Between the Propylaea",
       COALESCE(inscription_stats."North of the Telesterion", 0) AS "North of the Telesterion",
       COALESCE(inscription_stats."Outer Courtyard", 0) AS "Outer Courtyard",
       COALESCE(inscription_stats."South Wall", 0) AS "South Wall",
       COALESCE(inscription_stats."Upper Terrace", 0) AS "Upper Terrace",
       COALESCE(inscription_stats."Mean Inscription Date", 0) AS "Mean Inscription Date",
       COALESCE(inscription_stats."Mean Inscription Date Span", 0) AS "Mean Inscription Date Span",
       COALESCE(inscription_stats."Mean Inscription Word Count", 0) AS "Mean Inscription Word Count",
       COALESCE(inscription_stats."Mean Inscription Character Count", 0) AS "Mean Inscription Character Count",
       COALESCE(honor_stats."Total Honors", 0) AS "Total Honors",
       COALESCE(honor_stats."Different Honors", 0) AS "Different Honors",
       COALESCE(honor_stats."Magistracies", 0) AS "Magistracies",
       COALESCE(honor_stats."Sacred Offices", 0) AS "Sacred Offices",
       COALESCE(honor_stats."Liturgies/Benefactions", 0) AS "Liturgies/Benefactions",
       COALESCE(honor_stats."Other/Private Honors", 0) AS "Other/Private Honors",
       COALESCE(honor_stats."Athenian Honors", 0) AS "Athenian Honors",
       COALESCE(honor_stats."Roman Honors", 0) AS "Roman Honors",
       COALESCE(honor_stats."Other/Greek Honors", 0) AS "Other/Greek Honors",
       COALESCE(institution_sponsorship_stats."As Institution Honorand", 0) AS "As Institution Honorand",
       COALESCE(institution_sponsorship_stats."As Institution Non-Honorand", 0) AS "As Institution Non-Honorand",
       COALESCE(institution_sponsorship_stats."As Public Honorand", 0) AS "As Public Honorand",
       COALESCE(institution_sponsorship_stats."As Public Non-Honorand", 0) AS "As Public Non-Honorand",
       COALESCE(institution_sponsorship_stats."As Private Honorand", 0) AS "As Private Honorand",
       COALESCE(institution_sponsorship_stats."As Private Non-Honorand", 0) AS "As Private Non-Honorand",
       COALESCE(institution_sponsorship_stats."As Genos Honorand", 0) AS "As Genos Honorand",
       COALESCE(institution_sponsorship_stats."As Genos Non-Honorand", 0) AS "As Genos Non-Honorand",
       COALESCE(institution_sponsorship_stats."As Areopagus Honorand", 0) AS "As Areopagus Honorand",
       COALESCE(institution_sponsorship_stats."As Areopagus Non-Honorand", 0) AS "As Areopagus Non-Honorand",
       COALESCE(institution_sponsorship_stats."As Boule Honorand", 0) AS "As Boule Honorand",
       COALESCE(institution_sponsorship_stats."As Boule Non-Honorand", 0) AS "As Boule Non-Honorand",
       COALESCE(institution_sponsorship_stats."As Demos Honorand", 0) AS "As Demos Honorand",
       COALESCE(institution_sponsorship_stats."As Demos Non-Honorand", 0) AS "As Demos Non-Honorand",
       COALESCE(institution_sponsorship_stats."As Eumolpidai Honorand", 0) AS "As Eumolpidai Honorand",
       COALESCE(institution_sponsorship_stats."As Eumolpidai Non-Honorand", 0) AS "As Eumolpidai Non-Honorand",
       COALESCE(institution_sponsorship_stats."As Kerykes Honorand", 0) AS "As Kerykes Honorand",
       COALESCE(institution_sponsorship_stats."As Kerykes Non-Honorand", 0) AS "As Kerykes Non-Honorand"
FROM public."Person" AS person
LEFT JOIN public."Persons on Inscriptions Stats"() AS inscription_stats ON person."ID" = inscription_stats."Person ID"
LEFT JOIN public."Persons with Honor Stats"() AS honor_stats ON person."ID" = honor_stats."Person ID"
LEFT JOIN public."Persons on Institution Inscriptions Stats"() AS institution_sponsorship_stats ON person."ID" = institution_sponsorship_stats."Person ID"
$BODY$
LANGUAGE sql STABLE NOT LEAKPROOF;


-- Function from: /Users/davidthomas/Git/brown-diss/build_db/sql/functions/Earliest Date.sql

CREATE FUNCTION public."Earliest Date"(
    IN thing_id INTEGER,
    OUT "Date" REAL
) RETURNS REAL AS
$BODY$
SELECT MIN(inscription."Date") AS "Date"
FROM public."Person in Inscription" as person_appearance
INNER JOIN public."Inscription" AS inscription ON person_appearance."Inscription ID" = inscription."ID"
WHERE person_appearance."Person ID" = thing_id
UNION ALL
SELECT MIN(inscription."Date") AS "Date"
FROM public."Institution Sponsorship" as institution_sponsorship
INNER JOIN public."Inscription" AS inscription ON institution_sponsorship."Inscription ID" = inscription."ID"
WHERE institution_sponsorship."Institution ID" = thing_id
UNION ALL
SELECT MIN(inscription."Date") AS "Date"
FROM public."Honor in Inscription" as honor_appearance
INNER JOIN public."Inscription" AS inscription ON honor_appearance."Inscription ID" = inscription."ID"
WHERE honor_appearance."Honor ID" = thing_id
$BODY$
LANGUAGE sql STABLE NOT LEAKPROOF;



-- =============END OF FUNCTIONS=============


-- =============START OF VIEWS=============
-- View from: /Users/davidthomas/Git/brown-diss/build_db/sql/views/__ Inscription Co-Sponsorship __.sql

CREATE OR REPLACE VIEW public."__ Inscription Co-Sponsorship __" AS
-- Person to Person Cosponsorships
SELECT DISTINCT inscription."IE" AS "IE",
                'Person-Person' AS "Co-Sponsorship Type",
                sponsor."Person" AS "Sponsor",
                cosponsor."Person" AS "Co-Sponsor",
                inscription."Inscription" AS "Inscription",
                inscription."Object Type" AS "Object Type",
                inscription."Inscription Type" AS "Inscription Type",
                inscription."Location" AS "Location",
                inscription."Date" AS "Date",
                inscription."Date Span" AS "Date Span",
                inscription."Word Count" AS "Word Count",
                inscription."Character Count" AS "Character Count",
                inscription."Text" AS "Text",
                inscription."References" AS "References",
                'Person' AS "Sponsor Class",
                sponsor."Category" AS "Sponsor Origin",
                CASE
                    WHEN sponsor."Category" = 'Athenian'
                         AND sponsor."Roman Citizen" = FALSE THEN 'Athenian without Roman Citizenship'
                    WHEN sponsor."Category" = 'Athenian'
                         AND sponsor."Roman Citizen" = TRUE THEN 'Athenian with Roman Citizenship'
                    ELSE 'Non-Athenian'
                END AS "Sponsor Status",
                NULL AS "Sponsor Type",
                sponsor."Gender" AS "Sponsor Gender",
                sponsor."Family" AS "Sponsor Family",
                sponsor."Extended" AS "Sponsor Extended Family",
                sponsor."Deme" AS "Sponsor Deme",
                'Person' AS "Co-Sponsor Class",
                cosponsor."Category" AS "Co-Sponsor Origin",
                CASE
                    WHEN cosponsor."Category" = 'Athenian'
                         AND cosponsor."Roman Citizen" = FALSE THEN 'Athenian without Roman Citizenship'
                    WHEN cosponsor."Category" = 'Athenian'
                         AND cosponsor."Roman Citizen" = TRUE THEN 'Athenian with Roman Citizenship'
                    ELSE 'Non-Athenian'
                END AS "Co-Sponsor Status",
                NULL AS "Co-Sponsor Type",
                cosponsor."Gender" AS "Co-Sponsor Gender",
                cosponsor."Family" AS "Co-Sponsor Family",
                cosponsor."Extended" AS "Co-Sponsor Extended Family",
                cosponsor."Deme" AS "Co-Sponsor Deme",
                inscription."ID" AS "Inscription ID",
                sponsor."ID" AS "Sponsor ID",
                cosponsor."ID" AS "Co-Sponsor ID",
                sponsor."Uncertain Person" AS "Sponsor Uncertainty",
                cosponsor."Uncertain Person" AS "Co-Sponsor Uncertainty"
FROM
public."Person in Inscription" AS sponsorship
INNER JOIN public."Person in Inscription" AS cosponsorship ON sponsorship."Inscription ID" = cosponsorship."Inscription ID"
INNER JOIN public."Inscription Full"() AS inscription ON sponsorship."Inscription ID" = inscription."ID"
INNER JOIN public."Person" AS sponsor ON sponsorship."Person ID" = sponsor."ID"
INNER JOIN public."Person" AS cosponsor ON cosponsorship."Person ID" = cosponsor."ID"
WHERE sponsorship."Person ID" != cosponsorship."Person ID" AND sponsorship."Role" = 'Sponsor' AND cosponsorship."Role" = 'Sponsor'
UNION ALL
-- Person to Institution Cosponsorships
SELECT DISTINCT inscription."IE" AS "IE",
                'Person-Institution' AS "Co-Sponsorship Type",
                sponsor."Person" AS "Sponsor",
                cosponsor."Institution" AS "Co-Sponsor",
                inscription."Inscription" AS "Inscription",
                inscription."Object Type" AS "Object Type",
                inscription."Inscription Type" AS "Inscription Type",
                inscription."Location" AS "Location",
                inscription."Date" AS "Date",
                inscription."Date Span" AS "Date Span",
                inscription."Word Count" AS "Word Count",
                inscription."Character Count" AS "Character Count",
                inscription."Text" AS "Text",
                inscription."References" AS "References",
                'Person' AS "Sponsor Class",
                sponsor."Category" AS "Sponsor Origin",
                CASE
                    WHEN sponsor."Category" = 'Athenian'
                         AND sponsor."Roman Citizen" = FALSE THEN 'Athenian without Roman Citizenship'
                    WHEN sponsor."Category" = 'Athenian'
                         AND sponsor."Roman Citizen" = TRUE THEN 'Athenian with Roman Citizenship'
                    ELSE 'Non-Athenian'
                END AS "Sponsor Status",
                NULL AS "Sponsor Type",
                sponsor."Gender" AS "Sponsor Gender",
                sponsor."Family" AS "Sponsor Family",
                sponsor."Extended" AS "Sponsor Extended Family",
                sponsor."Deme" AS "Sponsor Deme",
                'Institution' AS "Co-Sponsor Class",
                cosponsor."Category" AS "Sponsor Origin",
                NULL AS "Co-Sponsor Status",
                cosponsor."Type" AS "Co-Sponsor Type",
                NULL AS "Co-Sponsor Gender",
                NULL AS "Co-Sponsor Family",
                NULL AS "Co-Sponsor Extended Family",
                NULL AS "Co-Sponsor Deme",
                inscription."ID" AS "Inscription ID",
                sponsor."ID" AS "Sponsor ID",
                cosponsor."ID" AS "Co-Sponsor ID",
                sponsor."Uncertain Person" AS "Sponsor Uncertainty",
                cosponsorship."Uncertain" AS "Co-Sponsor Uncertainty"
FROM
public."Person in Inscription" as sponsorship
INNER JOIN public."Institution Sponsorship" as cosponsorship ON sponsorship."Inscription ID" = cosponsorship."Inscription ID"
INNER JOIN public."Inscription Full"() as inscription on sponsorship."Inscription ID" = inscription."ID"
INNER JOIN public."Person" AS sponsor ON sponsorship."Person ID" = sponsor."ID"
INNER JOIN public."Institution" AS cosponsor ON cosponsorship."Institution ID" = cosponsor."ID"
WHERE sponsorship."Role" = 'Sponsor'
UNION ALL
-- Institution to Institution Co-Sponsorships
SELECT DISTINCT inscription."IE" AS "IE",
                'Institution-Institution' AS "Co-Sponsorship Type",
                sponsor."Institution" AS "Sponsor",
                cosponsor."Institution" AS "Co-Sponsor",
                inscription."Inscription" AS "Inscription",
                inscription."Object Type" AS "Object Type",
                inscription."Inscription Type" AS "Inscription Type",
                inscription."Location" AS "Location",
                inscription."Date" AS "Date",
                inscription."Date Span" AS "Date Span",
                inscription."Word Count" AS "Word Count",
                inscription."Character Count" AS "Character Count",
                inscription."Text" AS "Text",
                inscription."References" AS "References",
                'Institution' AS "Sponsor Class",
                sponsor."Category" AS "Sponsor Origin",
                NULL AS "Sponsor Status",
                sponsor."Type" AS "Sponsor Type",
                NULL AS "Sponsor Gender",
                NULL AS "Sponsor Family",
                NULL AS "Sponsor Extended Family",
                NULL AS "Sponsor Deme",
                'Institution' AS "Co-Sponsor Class",
                cosponsor."Category" AS "Sponsor Origin",
                NULL AS "Co-Sponsor Status",
                cosponsor."Type" AS "Co-Sponsor Type",
                NULL AS "Co-Sponsor Gender",
                NULL AS "Co-Sponsor Family",
                NULL AS "Co-Sponsor Extended Family",
                NULL AS "Co-Sponsor Deme",
                inscription."ID" AS "Inscription ID",
                sponsor."ID" AS "Sponsor ID",
                cosponsor."ID" AS "Co-Sponsor ID",
                sponsorship."Uncertain" AS "Sponsor Uncertainty",
                cosponsorship."Uncertain" AS "Co-Sponsor Uncertainty"
FROM
public."Institution Sponsorship" as sponsorship
INNER JOIN public."Institution Sponsorship" as cosponsorship ON sponsorship."Inscription ID" = cosponsorship."Inscription ID"
INNER JOIN public."Inscription Full"() as inscription on sponsorship."Inscription ID" = inscription."ID"
INNER JOIN public."Institution" AS sponsor ON sponsorship."Institution ID" = sponsor."ID"
INNER JOIN public."Institution" AS cosponsor ON cosponsorship."Institution ID" = cosponsor."ID"
WHERE sponsorship."Role" = 'Sponsor' AND sponsor."ID" != cosponsor."ID";


-- View from: /Users/davidthomas/Git/brown-diss/build_db/sql/views/__ Inscription Honor with Institution __.sql

CREATE OR REPLACE VIEW public."__ Inscription Honor with Institution __" AS
SELECT DISTINCT inscription."IE" AS "IE",
                honor."Honor" AS "Honor",
                institution."Institution" AS "Institution",
                inscription."Inscription" AS "Inscription",
                inscription."Object Type" AS "Object Type",
                inscription."Inscription Type" AS "Inscription Type",
                inscription."Location" AS "Location",
                inscription."Date" AS "Date",
                inscription."Date Span" AS "Date Span",
                inscription."Word Count" AS "Word Count",
                inscription."Character Count" AS "Character Count",
                inscription."Text" AS "Text",
                inscription."References" AS "References",
                honor."Type" AS "Honor Type",
                honor."Category" AS "Honor Origin",
                institution."Category" AS "Institution Origin",
                institution."Type" AS "Institution Type",
                inscription."ID" AS "Inscription ID",
                institution."ID" AS "Institution ID",
                honor."ID" AS "Honor ID"
FROM public."Honor in Inscription" AS honor_inscription
LEFT JOIN public."Institution Honor" AS institution_honor ON honor_inscription."Honor ID" = institution_honor."Honor ID"
INNER JOIN public."Inscription Full"() AS inscription ON honor_inscription."Inscription ID" = inscription."ID"
INNER JOIN public."Honor" AS honor ON institution_honor."Honor ID" = honor."ID"
LEFT JOIN public."Institution" AS institution ON institution_honor."Institution ID" = institution."ID"
ORDER BY inscription."ID",
         institution."ID",
         honor."ID";


-- View from: /Users/davidthomas/Git/brown-diss/build_db/sql/views/__ Inscription Person __.sql

CREATE OR REPLACE VIEW public."__ Inscription Person __" AS
SELECT DISTINCT inscription."IE" AS "IE",
                person."Person" AS "Person",
                inscription."Inscription" AS "Inscription",
                inscription."Object Type" AS "Object Type",
                inscription."Inscription Type" AS "Inscription Type",
                inscription."Location" AS "Location",
                inscription."Date" AS "Date",
                inscription."Date Span" AS "Date Span",
                inscription."Word Count" AS "Word Count",
                inscription."Character Count" AS "Character Count",
                inscription."Text" AS "Text",
                inscription."References" AS "References",
                person."Category" AS "Person Origin",
                CASE
                    WHEN person."Category" = 'Athenian'
                         AND person."Roman Citizen" = FALSE THEN 'Athenian without Roman Citizenship'
                    WHEN person."Category" = 'Athenian'
                         AND person."Roman Citizen" = TRUE THEN 'Athenian with Roman Citizenship'
                    ELSE 'Non-Athenian'
                END AS "Person Status",
                person."Gender" AS "Person Gender",
                person."Family" AS "Person Family",
                person."Extended" AS "Person Extended Family",
                person."Deme" AS "Person Deme",
                person_inscription."Role" AS "Person Role",
                inscription."ID" AS "Inscription ID",
                person."ID" AS "Person ID",
                person."Uncertain Person" AS "Person Uncertainty"
FROM public."Person in Inscription" AS person_inscription
INNER JOIN public."Inscription Full"() AS inscription ON person_inscription."Inscription ID" = inscription."ID"
INNER JOIN public."Person" AS person ON person_inscription."Person ID" = person."ID"
ORDER BY inscription."ID",
         person."ID";


-- View from: /Users/davidthomas/Git/brown-diss/build_db/sql/views/__ Inscription Sponsor __.sql

CREATE OR REPLACE VIEW public."__ Inscription Sponsor __" AS
SELECT DISTINCT inscription."IE" AS "IE",
                sponsor."Person" AS "Sponsor",
                inscription."Inscription" AS "Inscription",
                inscription."Object Type" AS "Object Type",
                inscription."Inscription Type" AS "Inscription Type",
                inscription."Location" AS "Location",
                inscription."Date" AS "Date",
                inscription."Date Span" AS "Date Span",
                inscription."Word Count" AS "Word Count",
                inscription."Character Count" AS "Character Count",
                inscription."Text" AS "Text",
                inscription."References" AS "References",
                'Person' AS "Sponsor Class",
                sponsor."Category" AS "Sponsor Origin",
                CASE
                    WHEN sponsor."Category" = 'Athenian'
                         AND sponsor."Roman Citizen" = FALSE THEN 'Athenian without Roman Citizenship'
                    WHEN sponsor."Category" = 'Athenian'
                         AND sponsor."Roman Citizen" = TRUE THEN 'Athenian with Roman Citizenship'
                    ELSE 'Non-Athenian'
                END AS "Sponsor Status",
                NULL AS "Sponsor Type",
                sponsor."Gender" AS "Sponsor Gender",
                sponsor."Family" AS "Sponsor Family",
                sponsor."Extended" AS "Sponsor Extended Family",
                sponsor."Deme" AS "Sponsor Deme",
                inscription."ID" AS "Inscription ID",
                sponsor."ID" AS "Sponsor ID",
                sponsor."Uncertain Person" AS "Sponsor Uncertainty"
FROM public."Person in Inscription" AS sponsor_inscription
INNER JOIN public."Inscription Full"() AS inscription ON sponsor_inscription."Inscription ID" = inscription."ID"
INNER JOIN public."Person" AS sponsor ON sponsor_inscription."Person ID" = sponsor."ID"
WHERE sponsor_inscription."Role" = 'Sponsor'
UNION ALL
SELECT DISTINCT inscription."IE" AS "IE",
                sponsor."Institution" AS "Sponsor",
                inscription."Inscription" AS "Inscription",
                inscription."Object Type" AS "Object Type",
                inscription."Inscription Type" AS "Inscription Type",
                inscription."Location" AS "Location",
                inscription."Date" AS "Date",
                inscription."Date Span" AS "Date Span",
                inscription."Word Count" AS "Word Count",
                inscription."Character Count" AS "Character Count",
                inscription."Text" AS "Text",
                inscription."References" AS "References",
                'Institution' AS "Sponsor Class",
                sponsor."Category" AS "Sponsor Origin",
                NULL AS "Sponsor Status",
                sponsor."Type" AS "Sponsor Type",
                NULL AS "Sponsor Gender",
                NULL AS "Sponsor Family",
                NULL AS "Sponsor Extended Family",
                NULL AS "Sponsor Deme",
                inscription."ID" AS "Inscription ID",
                sponsor."ID" AS "Sponsor ID",
                sponsor_inscription."Uncertain" AS "Sponsor Uncertainty"
FROM public."Institution Sponsorship" AS sponsor_inscription
INNER JOIN public."Inscription Full"() AS inscription ON sponsor_inscription."Inscription ID" = inscription."ID"
INNER JOIN public."Institution" AS sponsor ON sponsor_inscription."Institution ID" = sponsor."ID"
ORDER BY "Inscription ID",
         "Sponsor ID";


-- View from: /Users/davidthomas/Git/brown-diss/build_db/sql/views/__ Inscription Sponsorship of Honorand __.sql

CREATE OR REPLACE VIEW public."__ Inscription Sponsorship of Honorand __" AS
SELECT DISTINCT inscription."IE" AS "IE",
                sponsor."Person" AS "Sponsor",
                honorand."Person" AS "Honorand",
                inscription."Inscription" AS "Inscription",
                inscription."Object Type" AS "Object Type",
                inscription."Inscription Type" AS "Inscription Type",
                inscription."Location" AS "Location",
                inscription."Date" AS "Date",
                inscription."Date Span" AS "Date Span",
                inscription."Word Count" AS "Word Count",
                inscription."Character Count" AS "Character Count",
                inscription."Text" AS "Text",
                inscription."References" AS "References",
                'Person' AS "Sponsor Class",
                sponsor."Category" AS "Sponsor Origin",
                CASE
                    WHEN sponsor."Category" = 'Athenian'
                         AND sponsor."Roman Citizen" = FALSE THEN 'Athenian without Roman Citizenship'
                    WHEN sponsor."Category" = 'Athenian'
                         AND sponsor."Roman Citizen" = TRUE THEN 'Athenian with Roman Citizenship'
                    ELSE 'Non-Athenian'
                END AS "Sponsor Status",
                NULL AS "Sponsor Type",
                sponsor."Gender" AS "Sponsor Gender",
                sponsor."Family" AS "Sponsor Family",
                sponsor."Extended" AS "Sponsor Extended Family",
                sponsor."Deme" AS "Sponsor Deme",
                honorand."Category" AS "Honorand Origin",
                CASE
                    WHEN honorand."Category" = 'Athenian'
                         AND honorand."Roman Citizen" = FALSE THEN 'Athenian without Roman Citizenship'
                    WHEN honorand."Category" = 'Athenian'
                         AND honorand."Roman Citizen" = TRUE THEN 'Athenian with Roman Citizenship'
                    ELSE 'Non-Athenian'
                END AS "Honorand Status",
                NULL AS "Honorand Type",
                honorand."Gender" AS "Honorand Gender",
                honorand."Family" AS "Honorand Family",
                honorand."Extended" AS "Honorand Extended Family",
                honorand."Deme" AS "Honorand Deme",
                inscription."ID" AS "Inscription ID",
                sponsor."ID" AS "Sponsor ID",
                honorand."ID" AS "Honorand ID",
                sponsor."Uncertain Person" AS "Sponsor Uncertainty",
                honorand."Uncertain Person" AS "Honorand Uncertainty"
FROM public."Person in Inscription" AS sponsor_inscription
INNER JOIN public."Person in Inscription" AS honorand_inscription ON sponsor_inscription."Inscription ID" = honorand_inscription."Inscription ID"
INNER JOIN public."Inscription Full"() AS inscription ON sponsor_inscription."Inscription ID" = inscription."ID"
INNER JOIN public."Person" AS sponsor ON sponsor_inscription."Person ID" = sponsor."ID"
INNER JOIN public."Person" AS honorand ON honorand_inscription."Person ID" = honorand."ID"
WHERE sponsor_inscription."Role" = 'Sponsor' AND honorand_inscription."Role" = 'Honorand' AND sponsor."ID" != honorand."ID"
UNION ALL
SELECT DISTINCT inscription."IE" AS "IE",
                sponsor."Institution" AS "Sponsor",
                honorand."Person" AS "Honorand",
                inscription."Inscription" AS "Inscription",
                inscription."Object Type" AS "Object Type",
                inscription."Inscription Type" AS "Inscription Type",
                inscription."Location" AS "Location",
                inscription."Date" AS "Date",
                inscription."Date Span" AS "Date Span",
                inscription."Word Count" AS "Word Count",
                inscription."Character Count" AS "Character Count",
                inscription."Text" AS "Text",
                inscription."References" AS "References",
                'Institution' AS "Sponsor Class",
                sponsor."Category" AS "Sponsor Origin",
                NULL AS "Sponsor Status",
                sponsor."Type" AS "Sponsor Type",
                NULL AS "Sponsor Gender",
                NULL AS "Sponsor Family",
                NULL AS "Sponsor Extended Family",
                NULL AS "Sponsor Deme",
                honorand."Category" AS "Honorand Origin",
                CASE
                    WHEN honorand."Category" = 'Athenian'
                         AND honorand."Roman Citizen" = FALSE THEN 'Athenian without Roman Citizenship'
                    WHEN honorand."Category" = 'Athenian'
                         AND honorand."Roman Citizen" = TRUE THEN 'Athenian with Roman Citizenship'
                    ELSE 'Non-Athenian'
                END AS "Honorand Status",
                NULL AS "Honorand Type",
                honorand."Gender" AS "Honorand Gender",
                honorand."Family" AS "Honorand Family",
                honorand."Extended" AS "Honorand Extended Family",
                honorand."Deme" AS "Honorand Deme",
                inscription."ID" AS "Inscription ID",
                sponsor."ID" AS "Sponsor ID",
                honorand."ID" AS "Honorand ID",
                sponsor_inscription."Uncertain" AS "Sponsor Uncertainty",
                honorand."Uncertain Person" AS "Honorand Uncertainty"
FROM public."Institution Sponsorship" AS sponsor_inscription
INNER JOIN public."Person in Inscription" as honorand_inscription ON sponsor_inscription."Inscription ID" = honorand_inscription."Inscription ID"
INNER JOIN public."Inscription Full"() AS inscription ON sponsor_inscription."Inscription ID" = inscription."ID"
INNER JOIN public."Institution" AS sponsor ON sponsor_inscription."Institution ID" = sponsor."ID"
INNER JOIN public."Person" AS honorand ON honorand_inscription."Person ID" = honorand."ID"
WHERE honorand_inscription."Role" = 'Honorand'
ORDER BY "Inscription ID",
         "Sponsor ID";


-- View from: /Users/davidthomas/Git/brown-diss/build_db/sql/views/__ Institutional Honor __.sql

CREATE OR REPLACE VIEW public."__ Institutional Honor __" AS
SELECT DISTINCT institution."Institution" AS "Institution",
                honor."Honor" AS "Honor",
                institution."Category" AS "Institution Origin",
                institution."Type" AS "Institution Type",
                honor."Type" AS "Honor Type",
                honor."Category" AS "Honor Origin",
                institution."ID" AS "Institution ID",
                honor."ID" AS "Honor ID"
FROM public."Institution Honor" AS institution_honor
INNER JOIN public."Institution" AS institution ON institution_honor."Institution ID" = institution."ID"
INNER JOIN public."Honor" AS honor ON institution_honor."Honor ID" = honor."ID"
GROUP BY institution."ID",
         honor."ID"
ORDER BY institution."ID",
         honor."ID";


-- View from: /Users/davidthomas/Git/brown-diss/build_db/sql/views/__ Institutional Honor Appearance __.sql

CREATE OR REPLACE VIEW public."__ Institutional Honor Appearance __" AS
SELECT institution."Institution" AS "Institution",
        institution."Origin" AS "Institution Origin",
        institution."Type" AS "Institution Type",
        institution."Category" AS "Institution Category",
        honor."Honor" AS "Honor",
        honor."Origin" AS "Honor Origin",
        honor."Category" AS "Honor Category",
        honor."Type" AS "Honor Type",
        honor_inscription."Appearances" AS "Honor Appearances",
        inscription."IE" AS "IE",
        CAST(inscription."Inscription" AS TEXT) AS "Inscription",
        inscription."Object Type" AS "Object Type",
        inscription."Inscription Type" AS "Inscription Type",
        inscription."Location" AS "Location",
        inscription."Date" AS "Date",
        inscription."Date Span" AS "Date Span",
        inscription."Word Count" AS "Word Count",
        inscription."Character Count" AS "Character Count",
        inscription."Text" AS "Text",
        inscription."References" AS "References",
        institution."ID" AS "Institution ID",
        honor."ID" AS "Honor ID",
        inscription."ID" AS "Inscription ID"
FROM "public"."Institution Honor" AS institution_honor
  INNER JOIN "public"."Honor in Inscription" honor_inscription ON (institution_honor."Honor ID" = honor_inscription."Honor ID")
  INNER JOIN "public"."Honor" AS honor ON (honor_inscription."Honor ID" = honor."ID")
  INNER JOIN "public"."Institution" AS institution ON (institution_honor."Institution ID" = institution."ID")
  INNER JOIN "public"."Inscription Full"() AS inscription ON (honor_inscription."Inscription ID" = inscription."ID")
ORDER BY institution."ID",
       honor."ID";


-- View from: /Users/davidthomas/Git/brown-diss/build_db/sql/views/__ Institutional Inscription __.sql

CREATE OR REPLACE VIEW public."__ Institutional Inscription __" AS
SELECT DISTINCT sponsor."Institution" AS "Institution",
                inscription."IE" AS "IE",
                sponsor."Category" AS "Institution Origin",
                sponsor."Type" AS "Institution Type",
                inscription."Inscription" AS "Inscription",
                inscription."Object Type" AS "Object Type",
                inscription."Inscription Type" AS "Inscription Type",
                inscription."Location" AS "Location",
                inscription."Date" AS "Date",
                inscription."Date Span" AS "Date Span",
                inscription."Word Count" AS "Word Count",
                inscription."Character Count" AS "Character Count",
                inscription."Text" AS "Text",
                inscription."References" AS "References",
                inscription."ID" AS "Inscription ID",
                sponsor."ID" AS "Institution ID"
FROM public."Institution Sponsorship" AS institution_sponsorship
INNER JOIN public."Institution" AS sponsor ON institution_sponsorship."Institution ID" = sponsor."ID"
INNER JOIN public."Inscription Full"() AS inscription ON institution_sponsorship."Inscription ID" = inscription."ID"
ORDER BY sponsor."ID",
         inscription."ID";


-- View from: /Users/davidthomas/Git/brown-diss/build_db/sql/views/__ Institutional Inscription Honor __.sql

CREATE OR REPLACE VIEW public."__ Institutional Inscription Honor __" AS
SELECT DISTINCT sponsor."Institution" AS "Institution",
                honor."Honor" AS "Honor",
                sponsor."Category" AS "Institution Origin",
                sponsor."Type" AS "Institution Type",
                honor."Type" AS "Honor Type",
                honor."Category" AS "Honor Origin",
                SUM(honor_appearance."Appearances") AS "Appearances",
                sponsor."ID" AS "Institution ID",
                honor."ID" AS "Office ID"
FROM public."Institution Sponsorship" AS institution_sponsorship
INNER JOIN public."Honor in Inscription" AS honor_appearance ON institution_sponsorship."Inscription ID" = honor_appearance."Inscription ID"
INNER JOIN public."Institution" AS sponsor ON institution_sponsorship."Institution ID" = sponsor."ID"
INNER JOIN public."Inscription Full"() AS inscription ON institution_sponsorship."Inscription ID" = inscription."ID"
INNER JOIN public."Honor" AS honor ON honor_appearance."Honor ID" = honor."ID"
GROUP BY honor."ID",
         sponsor."ID"
ORDER BY sponsor."ID",
         honor."ID";


-- View from: /Users/davidthomas/Git/brown-diss/build_db/sql/views/__ Institutional Inscription Honor Appearance __.sql

CREATE OR REPLACE VIEW public."__ Institutional Inscription Honor Appearance __" AS
SELECT DISTINCT sponsor."Institution" AS "Institution",
                honor."Honor" AS "Honor",
                inscription."IE" AS "IE",
                sponsor."Category" AS "Institution Origin",
                sponsor."Type" AS "Institution Type",
                honor."Type" AS "Honor Type",
                honor."Category" AS "Honor Origin",
                honor_appearance."Appearances" AS "Appearances",
                inscription."Inscription" AS "Inscription",
                inscription."Object Type" AS "Object Type",
                inscription."Inscription Type" AS "Inscription Type",
                inscription."Location" AS "Location",
                inscription."Date" AS "Date",
                inscription."Date Span" AS "Date Span",
                inscription."Word Count" AS "Word Count",
                inscription."Character Count" AS "Character Count",
                inscription."Text" AS "Text",
                inscription."References" AS "References",
                sponsor."ID" AS "Institution ID",
                honor."ID" AS "Office ID",
                inscription."ID" AS "Inscription ID"
FROM public."Institution Sponsorship" AS institution_sponsorship
INNER JOIN public."Honor in Inscription" AS honor_appearance ON institution_sponsorship."Inscription ID" = honor_appearance."Inscription ID"
INNER JOIN public."Institution" AS sponsor ON institution_sponsorship."Institution ID" = sponsor."ID"
INNER JOIN public."Inscription Full"() AS inscription ON institution_sponsorship."Inscription ID" = inscription."ID"
INNER JOIN public."Honor" AS honor ON honor_appearance."Honor ID" = honor."ID"
ORDER BY sponsor."ID",
         honor."ID",
         inscription."ID";


-- View from: /Users/davidthomas/Git/brown-diss/build_db/sql/views/__ Institutional Inscription Person __.sql

CREATE OR REPLACE VIEW public."__ Institutional Inscription Person __" AS
SELECT DISTINCT sponsor."Institution" AS "Sponsor",
                person."Person" AS "Person",
                sponsor."Category" AS "Sponsor Origin",
                sponsor."Type" AS "Sponsor Type",
                person."Category" AS "Person Origin",
                CASE
                    WHEN person."Category" = 'Athenian'
                         AND person."Roman Citizen" = FALSE THEN 'Athenian without Roman Citizenship'
                    WHEN person."Category" = 'Athenian'
                         AND person."Roman Citizen" = TRUE THEN 'Athenian with Roman Citizenship'
                    ELSE 'Non-Athenian'
                END AS "Person Status",
                person."Gender" AS "Person Gender",
                person."Family" AS "Person Family",
                person."Extended" AS "Person Extended Family",
                person."Deme" AS "Person Deme",
                sponsor."ID" AS "Sponsor ID",
                person."ID" AS "Person ID",
                person."Uncertain Person" AS "Person Uncertainty"
FROM public."Institution Sponsorship" AS institution_sponsorship
INNER JOIN public."Person in Inscription" AS person_appearance ON institution_sponsorship."Inscription ID" = person_appearance."Inscription ID"
INNER JOIN public."Institution" AS sponsor ON institution_sponsorship."Institution ID" = sponsor."ID"
INNER JOIN public."Inscription Full"() AS inscription ON institution_sponsorship."Inscription ID" = inscription."ID"
INNER JOIN public."Person" AS person ON person_appearance."Person ID" = person."ID"
GROUP BY person."ID", sponsor."ID"
ORDER BY sponsor."ID",
         person."ID";


-- View from: /Users/davidthomas/Git/brown-diss/build_db/sql/views/__ Institutional Inscription Person Appearance __.sql

CREATE OR REPLACE VIEW public."__ Institutional Inscription Person Appearance__" AS
SELECT DISTINCT sponsor."Institution" AS "Sponsor",
                person."Person" AS "Person",
                inscription."IE" AS "IE",
                sponsor."Category" AS "Sponsor Origin",
                sponsor."Type" AS "Sponsor Type",
                person."Category" AS "Person Origin",
                CASE
                    WHEN person."Category" = 'Athenian'
                         AND person."Roman Citizen" = FALSE THEN 'Athenian without Roman Citizenship'
                    WHEN person."Category" = 'Athenian'
                         AND person."Roman Citizen" = TRUE THEN 'Athenian with Roman Citizenship'
                    ELSE 'Non-Athenian'
                END AS "Person Status",
                person."Gender" AS "Person Gender",
                person."Family" AS "Person Family",
                person."Extended" AS "Person Extended Family",
                person."Deme" AS "Person Deme",
                person_appearance."Role" AS "Person Role",
                inscription."Inscription" AS "Inscription",
                inscription."Object Type" AS "Object Type",
                inscription."Inscription Type" AS "Inscription Type",
                inscription."Location" AS "Location",
                inscription."Date" AS "Date",
                inscription."Date Span" AS "Date Span",
                inscription."Word Count" AS "Word Count",
                inscription."Character Count" AS "Character Count",
                inscription."Text" AS "Text",
                inscription."References" AS "References",
                sponsor."ID" AS "Sponsor ID",
                person."ID" AS "Person ID",
                inscription."ID" AS "Inscription ID",
                person."Uncertain Person" AS "Person Uncertainty"
FROM public."Institution Sponsorship" AS institution_sponsorship
INNER JOIN public."Person in Inscription" AS person_appearance ON institution_sponsorship."Inscription ID" = person_appearance."Inscription ID"
INNER JOIN public."Institution" AS sponsor ON institution_sponsorship."Institution ID" = sponsor."ID"
INNER JOIN public."Inscription Full"() AS inscription ON institution_sponsorship."Inscription ID" = inscription."ID"
INNER JOIN public."Person" AS person ON person_appearance."Person ID" = person."ID"
ORDER BY sponsor."ID",
         person."ID",
         inscription."ID";


-- View from: /Users/davidthomas/Git/brown-diss/build_db/sql/views/__ Institutional Inscription Person Honor __.sql

CREATE OR REPLACE VIEW public."__ Institutional Inscription Person Honor __" AS
SELECT DISTINCT sponsor."Institution" AS "Institution",
                honor."Honor" AS "Honor",
                person."Person" AS "Person",
                sponsor."Category" AS "Institution Origin",
                sponsor."Type" AS "Institution Type",
                honor."Type" AS "Honor Type",
                honor."Category" AS "Honor Origin",
                SUM(person_honor."Appearances") AS "Honor Appearances",
                person."Category" AS "Person Origin",
                CASE
                    WHEN person."Category" = 'Athenian'
                         AND person."Roman Citizen" = FALSE THEN 'Athenian without Roman Citizenship'
                    WHEN person."Category" = 'Athenian'
                         AND person."Roman Citizen" = TRUE THEN 'Athenian with Roman Citizenship'
                    ELSE 'Non-Athenian'
                END AS "Person Status",
                person."Gender" AS "Person Gender",
                person."Family" AS "Person Family",
                person."Extended" AS "Person Extended Family",
                person."Deme" AS "Person Deme",
                sponsor."ID" AS "Institution ID",
                honor."ID" AS "Office ID",
                person."ID" AS "Person ID",
                person."Uncertain Person" AS "Person Uncertainty"
FROM public."Institution Sponsorship" AS institution_sponsorship
INNER JOIN public."Person Honor Display" AS person_honor ON institution_sponsorship."Inscription ID" = person_honor."Inscription ID"
INNER JOIN public."Person in Inscription" AS person_appearance ON person_honor."Person ID" = person_appearance."Person ID"
AND person_honor."Inscription ID" = person_appearance."Inscription ID"
INNER JOIN public."Institution" AS sponsor ON institution_sponsorship."Institution ID" = sponsor."ID"
INNER JOIN public."Inscription Full"() AS inscription ON institution_sponsorship."Inscription ID" = inscription."ID"
INNER JOIN public."Person" AS person ON person_honor."Person ID" = person."ID"
AND person_appearance."Person ID" = person."ID"
INNER JOIN public."Honor" AS honor ON person_honor."Honor ID" = honor."ID"
GROUP BY honor."ID", person."ID", sponsor."ID"
ORDER BY sponsor."ID",
         honor."ID",
         person."ID";


-- View from: /Users/davidthomas/Git/brown-diss/build_db/sql/views/__ Institutional Inscription Person Honor Appearance __.sql

CREATE OR REPLACE VIEW public."__ Institutional Inscription Person Honor Appearance__" AS
SELECT DISTINCT sponsor."Institution" AS "Institution",
                honor."Honor" AS "Honor",
                person."Person" AS "Person",
                inscription."IE" AS "IE",
                sponsor."Category" AS "Institution Origin",
                sponsor."Type" AS "Institution Type",
                honor."Type" AS "Honor Type",
                honor."Category" AS "Honor Origin",
                person_honor."Appearances" AS "Honor Appearances",
                person."Category" AS "Person Origin",
                CASE
                    WHEN person."Category" = 'Athenian'
                         AND person."Roman Citizen" = FALSE THEN 'Athenian without Roman Citizenship'
                    WHEN person."Category" = 'Athenian'
                         AND person."Roman Citizen" = TRUE THEN 'Athenian with Roman Citizenship'
                    ELSE 'Non-Athenian'
                END AS "Person Status",
                person."Gender" AS "Person Gender",
                person."Family" AS "Person Family",
                person."Extended" AS "Person Extended Family",
                person."Deme" AS "Person Deme",
                person_appearance."Role" AS "Person Role",
                inscription."Inscription" AS "Inscription",
                inscription."Object Type" AS "Object Type",
                inscription."Inscription Type" AS "Inscription Type",
                inscription."Location" AS "Location",
                inscription."Date" AS "Date",
                inscription."Date Span" AS "Date Span",
                inscription."Word Count" AS "Word Count",
                inscription."Character Count" AS "Character Count",
                inscription."Text" AS "Text",
                inscription."References" AS "References",
                sponsor."ID" AS "Institution ID",
                honor."ID" AS "Office ID",
                person."ID" AS "Person ID",
                inscription."ID" AS "Inscription ID",
                person."Uncertain Person" AS "Person Uncertainty"
FROM public."Institution Sponsorship" AS institution_sponsorship
INNER JOIN public."Person Honor Display" AS person_honor ON institution_sponsorship."Inscription ID" = person_honor."Inscription ID"
INNER JOIN public."Person in Inscription" AS person_appearance ON person_honor."Person ID" = person_appearance."Person ID"
AND person_honor."Inscription ID" = person_appearance."Inscription ID"
INNER JOIN public."Institution" AS sponsor ON institution_sponsorship."Institution ID" = sponsor."ID"
INNER JOIN public."Inscription Full"() AS inscription ON institution_sponsorship."Inscription ID" = inscription."ID"
INNER JOIN public."Person" AS person ON person_honor."Person ID" = person."ID"
AND person_appearance."Person ID" = person."ID"
INNER JOIN public."Honor" AS honor ON person_honor."Honor ID" = honor."ID"
ORDER BY sponsor."ID",
         honor."ID",
         person."ID",
         inscription."ID";


-- View from: /Users/davidthomas/Git/brown-diss/build_db/sql/views/__ Institutional Officer __.sql

CREATE OR REPLACE VIEW public."__ Institutional Officer __" AS
SELECT DISTINCT institution."Institution" AS "Institution",
                office."Honor" AS "Office",
                officer."Person" AS "Officer",
                institution."Category" AS "Institution Origin",
                institution."Type" AS "Institution Type",
                office."Type" AS "Office Type",
                SUM(officer_office."Appearances") AS "Office Appearances",
                officer."Category" AS "Officer Origin",
                CASE
                    WHEN officer."Category" = 'Athenian'
                         AND officer."Roman Citizen" = FALSE THEN 'Athenian without Roman Citizenship'
                    WHEN officer."Category" = 'Athenian'
                         AND officer."Roman Citizen" = TRUE THEN 'Athenian with Roman Citizenship'
                    ELSE 'Non-Athenian'
                END AS "Officer Status",
                officer."Gender" AS "Officer Gender",
                officer."Family" AS "Officer Family",
                officer."Extended" AS "Officer Extended Family",
                officer."Deme" AS "Officer Deme",
                SUM(CASE WHEN officer_appearance."Role" = 'Sponsor' THEN 1 ELSE 0 END) AS "Officer as Sponsor",
                SUM(CASE WHEN officer_appearance."Role" = 'Honorand' THEN 1 ELSE 0 END) AS "Officer as Honorand",
                SUM(CASE WHEN officer_appearance."Role" = '' THEN 1 ELSE 0 END) AS "Officer as Other Role",
                institution."ID" AS "Institution ID",
                office."ID" AS "Office ID",
                officer."ID" AS "Officer ID",
                officer."Uncertain Person" AS "Officer Uncertainty"
FROM public."Institution Honor" AS institution_honor
INNER JOIN public."Person Honor Display" AS officer_office ON institution_honor."Honor ID" = officer_office."Honor ID"
INNER JOIN public."Person in Inscription" AS officer_appearance ON officer_office."Person ID" = officer_appearance."Person ID"
INNER JOIN public."Institution" AS institution ON institution_honor."Institution ID" = institution."ID"
INNER JOIN public."Honor" AS office ON institution_honor."Honor ID" = office."ID"
AND officer_office."Honor ID" = office."ID"
INNER JOIN public."Person" AS officer ON officer_office."Person ID" = officer."ID" AND officer_appearance."Person ID" = officer."ID"
GROUP BY officer."ID",
         institution."ID",
         office."ID"
ORDER BY institution."ID",
         office."ID",
         officer."ID";


-- View from: /Users/davidthomas/Git/brown-diss/build_db/sql/views/__ Institutional Officer Appearance __.sql

CREATE OR REPLACE VIEW public."__ Institutional Officer Appearance __" AS
SELECT DISTINCT institution."Institution" AS "Institution",
                office."Honor" AS "Office",
                officer."Person" AS "Officer",
                inscription."IE" AS "IE",
                institution."Category" AS "Institution Origin",
                institution."Type" AS "Institution Type",
                office."Type" AS "Office Type",
                officer_office."Appearances" AS "Office Appearances",
                officer."Category" AS "Officer Origin",
                CASE
                    WHEN officer."Category" = 'Athenian'
                         AND officer."Roman Citizen" = FALSE THEN 'Athenian without Roman Citizenship'
                    WHEN officer."Category" = 'Athenian'
                         AND officer."Roman Citizen" = TRUE THEN 'Athenian with Roman Citizenship'
                    ELSE 'Non-Athenian'
                END AS "Officer Status",
                officer."Gender" AS "Officer Gender",
                officer."Family" AS "Officer Family",
                officer."Extended" AS "Officer Extended Family",
                officer."Deme" AS "Officer Deme",
                officer_appearance."Role" AS "Officer Role",
                inscription."Inscription" AS "Inscription",
                inscription."Object Type" AS "Object Type",
                inscription."Inscription Type" AS "Inscription Type",
                inscription."Location" AS "Location",
                inscription."Date" AS "Date",
                inscription."Date Span" AS "Date Span",
                inscription."Word Count" AS "Word Count",
                inscription."Character Count" AS "Character Count",
                inscription."Text" AS "Text",
                inscription."References" AS "References",
                institution."ID" AS "Institution ID",
                office."ID" AS "Office ID",
                officer."ID" AS "Officer ID",
                inscription."ID" AS "Inscription ID",
                officer."Uncertain Person" AS "Officer Uncertainty"
FROM public."Institution Honor" AS institution_honor
INNER JOIN public."Person Honor Display" AS officer_office ON institution_honor."Honor ID" = officer_office."Honor ID"
INNER JOIN public."Person in Inscription" AS officer_appearance ON officer_office."Person ID" = officer_appearance."Person ID"
INNER JOIN public."Institution" AS institution ON institution_honor."Institution ID" = institution."ID"
INNER JOIN public."Honor" AS office ON institution_honor."Honor ID" = office."ID"
AND officer_office."Honor ID" = office."ID"
INNER JOIN public."Person" AS officer ON officer_office."Person ID" = officer."ID"
INNER JOIN public."Inscription Full"() AS inscription ON officer_appearance."Inscription ID" = inscription."ID"
ORDER BY institution."ID",
         office."ID",
         officer."ID",
         inscription."ID";


-- View from: /Users/davidthomas/Git/brown-diss/build_db/sql/views/__ Institutional Officer Appearance as Officer __.sql

CREATE OR REPLACE VIEW public."__ Institutional Officer Appearance as Officer __" AS
SELECT DISTINCT institution."Institution" AS "Institution",
                office."Honor" AS "Office",
                officer."Person" AS "Officer",
                inscription."IE" AS "IE",
                institution."Category" AS "Institution Origin",
                institution."Type" AS "Institution Type",
                office."Type" AS "Office Type",
                officer_office."Appearances" AS "Office Appearances",
                officer."Category" AS "Officer Origin",
                CASE
                    WHEN officer."Category" = 'Athenian'
                         AND officer."Roman Citizen" = FALSE THEN 'Athenian without Roman Citizenship'
                    WHEN officer."Category" = 'Athenian'
                         AND officer."Roman Citizen" = TRUE THEN 'Athenian with Roman Citizenship'
                    ELSE 'Non-Athenian'
                END AS "Officer Status",
                officer."Gender" AS "Officer Gender",
                officer."Family" AS "Officer Family",
                officer."Extended" AS "Officer Extended Family",
                officer."Deme" AS "Officer Deme",
                officer_appearance."Role" AS "Officer Role",
                inscription."Inscription" AS "Inscription",
                inscription."Object Type" AS "Object Type",
                inscription."Inscription Type" AS "Inscription Type",
                inscription."Location" AS "Location",
                inscription."Date" AS "Date",
                inscription."Date Span" AS "Date Span",
                inscription."Word Count" AS "Word Count",
                inscription."Character Count" AS "Character Count",
                inscription."Text" AS "Text",
                inscription."References" AS "References",
                inscription."ID" AS "Inscription ID",
                institution."ID" AS "Institution ID",
                office."ID" AS "Office ID",
                officer."ID" AS "Officer ID",
                officer."Uncertain Person" AS "Officer Uncertainty"
FROM public."Institution Honor" AS institution_honor
INNER JOIN public."Person Honor Display" AS officer_office ON institution_honor."Honor ID" = officer_office."Honor ID"
INNER JOIN public."Person in Inscription" AS officer_appearance ON officer_office."Person ID" = officer_appearance."Person ID" AND officer_office."Inscription ID" = officer_appearance."Inscription ID"
INNER JOIN public."Institution" AS institution ON institution_honor."Institution ID" = institution."ID"
INNER JOIN public."Honor" AS office ON institution_honor."Honor ID" = office."ID"
AND officer_office."Honor ID" = office."ID"
INNER JOIN public."Person" AS officer ON officer_office."Person ID" = officer."ID"
INNER JOIN public."Inscription Full"() AS inscription ON officer_office."Inscription ID" = inscription."ID"
ORDER BY institution."ID",
         office."ID",
         officer."ID",
         inscription."ID";


-- View from: /Users/davidthomas/Git/brown-diss/build_db/sql/views/__ Institutional Officer Other Honor __.sql

CREATE OR REPLACE VIEW public."__ Institutional Officer Other Honor __" AS
SELECT DISTINCT institution."Institution" AS "Institution",
                office."Honor" AS "Office",
                honor."Honor" AS "Other Honor",
                officer."Person" AS "Officer",
                institution."Category" AS "Institution Origin",
                institution."Type" AS "Institution Type",
                office."Type" AS "Office Type",
                honor."Type" AS "Other Honor Type",
                honor."Category" AS "Other Honor Origin",
                SUM(officer_honor."Appearances") AS "Other Honor Appearances",
                other_institution."Institution" AS "Other Institution",
                other_institution."Category" AS "Other Institution Origin",
                other_institution."Type" AS "Other Institution Type",
                officer."Category" AS "Officer Origin",
                CASE
                    WHEN officer."Category" = 'Athenian'
                         AND officer."Roman Citizen" = FALSE THEN 'Athenian without Roman Citizenship'
                    WHEN officer."Category" = 'Athenian'
                         AND officer."Roman Citizen" = TRUE THEN 'Athenian with Roman Citizenship'
                    ELSE 'Non-Athenian'
                END AS "Officer Status",
                officer."Gender" AS "Officer Gender",
                officer."Family" AS "Officer Family",
                officer."Extended" AS "Officer Extended Family",
                officer."Deme" AS "Officer Deme",
                SUM(CASE WHEN officer_appearance."Role" = 'Sponsor' THEN 1 ELSE 0 END) AS "Officer as Sponsor",
                SUM(CASE WHEN officer_appearance."Role" = 'Honorand' THEN 1 ELSE 0 END) AS "Officer as Honorand",
                SUM(CASE WHEN officer_appearance."Role" = '' THEN 1 ELSE 0 END) AS "Officer as Other Role",
                institution."ID" AS "Institution ID",
                office."ID" AS "Office ID",
                honor."ID" AS "Honor ID",
                other_institution."ID" AS "Other Institution ID",
                officer."ID" AS "Officer ID",
                officer."Uncertain Person" AS "Officer Uncertainty"
FROM public."Institution Honor" AS institution_office
INNER JOIN public."Person Honor Display" AS officer_office ON institution_office."Honor ID" = officer_office."Honor ID"
INNER JOIN public."Person Honor Display" AS officer_honor ON officer_office."Person ID" = officer_honor."Person ID"
AND officer_office."Honor ID" != officer_honor."Honor ID"
INNER JOIN public."Person in Inscription" AS officer_appearance ON officer_honor."Inscription ID" = officer_appearance."Inscription ID"
AND officer_honor."Person ID" = officer_appearance."Person ID"
INNER JOIN public."Institution" AS institution ON institution_office."Institution ID" = institution."ID"
INNER JOIN public."Honor" AS office ON institution_office."Honor ID" = office."ID"
AND officer_office."Honor ID" = office."ID"
INNER JOIN public."Honor" AS honor ON officer_honor."Honor ID" = honor."ID"
INNER JOIN public."Person" AS officer ON officer_office."Person ID" = officer."ID"
AND officer_honor."Person ID" = officer."ID"
AND officer_appearance."Person ID" = officer."ID"
INNER JOIN public."Institution Honor" as institution_honor ON honor."ID" = institution_honor."Honor ID"
INNER JOIN public."Institution" as other_institution ON institution_honor."Institution ID" = other_institution."ID"
GROUP BY honor."ID", office."ID", institution."ID", officer."ID", other_institution."ID"
ORDER BY institution."ID",
         office."ID",
         honor."ID",
         officer."ID",
         other_institution."ID";


-- View from: /Users/davidthomas/Git/brown-diss/build_db/sql/views/__ Institutional Officer Other Honor Appearance __.sql

CREATE OR REPLACE VIEW public."__ Institutional Officer Other Honor Appearance __" AS
SELECT DISTINCT institution."Institution" AS "Institution",
                office."Honor" AS "Office",
                honor."Honor" AS "Other Honor",
                officer."Person" AS "Officer",
                inscription."IE" AS "IE",
                institution."Category" AS "Institution Origin",
                institution."Type" AS "Institution Type",
                office."Type" AS "Office Type",
                honor."Type" AS "Other Honor Type",
                honor."Category" AS "Other Honor Origin",
                officer_honor."Appearances" AS "Other Honor Appearances",
                other_institution."Institution" AS "Other Institution",
                other_institution."Category" AS "Other Institution Origin",
                other_institution."Type" AS "Other Institution Type",
                officer."Category" AS "Officer Origin",
                CASE
                    WHEN officer."Category" = 'Athenian'
                         AND officer."Roman Citizen" = FALSE THEN 'Athenian without Roman Citizenship'
                    WHEN officer."Category" = 'Athenian'
                         AND officer."Roman Citizen" = TRUE THEN 'Athenian with Roman Citizenship'
                    ELSE 'Non-Athenian'
                END AS "Officer Status",
                officer."Gender" AS "Officer Gender",
                officer."Family" AS "Officer Family",
                officer."Extended" AS "Officer Extended Family",
                officer."Deme" AS "Officer Deme",
                officer_appearance."Role" AS "Officer Role",
                inscription."Inscription" AS "Inscription",
                inscription."Object Type" AS "Object Type",
                inscription."Inscription Type" AS "Inscription Type",
                inscription."Location" AS "Location",
                inscription."Date" AS "Date",
                inscription."Date Span" AS "Date Span",
                inscription."Word Count" AS "Word Count",
                inscription."Character Count" AS "Character Count",
                inscription."Text" AS "Text",
                inscription."References" AS "References",
                institution."ID" AS "Institution ID",
                office."ID" AS "Office ID",
                honor."ID" AS "Honor ID",
                other_institution."ID" AS "Other Institution ID",
                officer."ID" AS "Officer ID",
                inscription."ID" AS "Inscription ID",
                officer."Uncertain Person" AS "Officer Uncertainty"
FROM public."Institution Honor" AS institution_office
INNER JOIN public."Person Honor Display" AS officer_office ON institution_office."Honor ID" = officer_office."Honor ID"
INNER JOIN public."Person Honor Display" AS officer_honor ON officer_office."Person ID" = officer_honor."Person ID"
AND officer_office."Honor ID" != officer_honor."Honor ID"
INNER JOIN public."Person in Inscription" AS officer_appearance ON officer_honor."Inscription ID" = officer_appearance."Inscription ID"
AND officer_honor."Person ID" = officer_appearance."Person ID"
INNER JOIN public."Institution" AS institution ON institution_office."Institution ID" = institution."ID"
INNER JOIN public."Honor" AS office ON institution_office."Honor ID" = office."ID"
AND officer_office."Honor ID" = office."ID"
INNER JOIN public."Honor" AS honor ON officer_honor."Honor ID" = honor."ID"
INNER JOIN public."Person" AS officer ON officer_office."Person ID" = officer."ID"
AND officer_honor."Person ID" = officer."ID"
AND officer_appearance."Person ID" = officer."ID"
INNER JOIN public."Institution Honor" AS institution_honor ON honor."ID" = institution_honor."Honor ID"
INNER JOIN public."Institution" AS other_institution ON institution_honor."Institution ID" = other_institution."ID"
INNER JOIN public."Inscription Full"() AS inscription ON officer_honor."Inscription ID" = inscription."ID"
ORDER BY institution."ID",
         office."ID",
         honor."ID",
         officer."ID",
         inscription. "ID";


-- View from: /Users/davidthomas/Git/brown-diss/build_db/sql/views/__ Personal Honor __.sql

CREATE OR REPLACE VIEW public."__ Personal Honor __" AS
SELECT DISTINCT person."Person" AS "Person",
                honor."Honor" AS "Honor",
                institution."Institution" AS "Honor Institution",
                SUM(person_honor."Appearances") AS "Honor Appearances",
                person."Category" AS "Person Origin",
                CASE
                    WHEN person."Category" = 'Athenian'
                         AND person."Roman Citizen" = FALSE THEN 'Athenian without Roman Citizenship'
                    WHEN person."Category" = 'Athenian'
                         AND person."Roman Citizen" = TRUE THEN 'Athenian with Roman Citizenship'
                    ELSE 'Non-Athenian'
                END AS "Person Status",
                person."Gender" AS "Person Gender",
                person."Family" AS "Person Family",
                person."Extended" AS "Person Extended Family",
                person."Deme" AS "Person Deme",
                honor."Type" AS "Honor Type",
                honor."Category" AS "Honor Origin",
                institution."Category" AS "Honor Institution Origin",
                institution."Type" AS "Honor Institution Type",
                institution."ID" AS "Institution ID",
                person."ID" AS "Person ID",
                honor."ID" AS "Honor ID",
                person."Uncertain Person" AS "Person Uncertainty"
FROM public."Person Honor Display" AS person_honor
INNER JOIN public."Person" AS person ON person_honor."Person ID" = person."ID"
INNER JOIN public."Honor" AS honor ON person_honor."Honor ID" = honor."ID"
LEFT JOIN public."Institution Honor" AS institution_honor ON honor."ID" = institution_honor."Honor ID"
LEFT JOIN public."Institution" AS institution ON institution_honor."Institution ID" = institution."ID"
GROUP BY
    person."ID",
    honor."ID",
    institution."ID"
ORDER BY
    person."ID",
    honor."ID";


-- View from: /Users/davidthomas/Git/brown-diss/build_db/sql/views/__ Personal Honor Appearance __.sql

CREATE OR REPLACE VIEW public."__ Personal Honor Appearance __" AS
SELECT DISTINCT person."Person" AS "Person",
                honor."Honor" AS "Honor",
                institution."Institution" AS "Honor Institution",
                inscription."IE" AS "IE",
                person."Category" AS "Person Origin",
                CASE
                    WHEN person."Category" = 'Athenian'
                         AND person."Roman Citizen" = FALSE THEN 'Athenian without Roman Citizenship'
                    WHEN person."Category" = 'Athenian'
                         AND person."Roman Citizen" = TRUE THEN 'Athenian with Roman Citizenship'
                    ELSE 'Non-Athenian'
                END AS "Person Status",
                person."Gender" AS "Person Gender",
                person."Family" AS "Person Family",
                person."Extended" AS "Person Extended Family",
                person."Deme" AS "Person Deme",
                honor."Type" AS "Honor Type",
                honor."Category" AS "Honor Origin",
                institution."Category" AS "Honor Institution Origin",
                institution."Type" AS "Honor Institution Type",
                institution."ID" AS "Institution ID",
                inscription."Inscription" AS "Inscription",
                inscription."Object Type" AS "Object Type",
                inscription."Inscription Type" AS "Inscription Type",
                inscription."Location" AS "Location",
                inscription."Date" AS "Date",
                inscription."Date Span" AS "Date Span",
                inscription."Word Count" AS "Word Count",
                inscription."Character Count" AS "Character Count",
                inscription."Text" AS "Text",
                inscription."References" AS "References",
                person."ID" AS "Person ID",
                honor."ID" AS "Honor ID",
                inscription."ID" AS "Inscription ID",
                person."Uncertain Person" AS "Person Uncertainty"
FROM public."Person Honor Display" AS person_honor
INNER JOIN public."Person" AS person ON person_honor."Person ID" = person."ID"
INNER JOIN public."Honor" AS honor ON person_honor."Honor ID" = honor."ID"
INNER JOIN public."Inscription Full"() AS inscription ON person_honor."Inscription ID" = inscription."ID"
LEFT JOIN public."Institution Honor" AS institution_honor ON honor."ID" = institution_honor."Honor ID"
LEFT JOIN public."Institution" AS institution ON institution_honor."Institution ID" = institution."ID"
ORDER BY
    person."ID",
    honor."ID",
    inscription."ID";


-- View from: /Users/davidthomas/Git/brown-diss/build_db/sql/views/- Gephi Coappearances Edges -.sql

CREATE OR REPLACE VIEW public."- Gephi Coappearance Edges -" AS
SELECT appearance."Sponsor ID" AS "Source",
        appearance."Honorand ID" AS "Target",
        'Directed' AS "Type",
        CONCAT('IE ', inscription."ID", ': ', inscription."Object Type") AS "Label",
        CAST(inscription."Date" AS double precision) AS "Start",
        350.0 AS "Stop",
        1 AS "Weight",
        inscription."ID" AS "Inscription ID",
        inscription."IE" AS "IE",
        inscription."Inscription" AS "Inscription",
        inscription."Object Type" AS "Object",
        inscription."Inscription Type" AS "Inscription Type",
        inscription."Location" AS "Location",
        inscription."Date" AS "Date",
        inscription."Date Span" AS "Date Span",
        inscription."Word Count" AS "Word Count",
        inscription."Character Count" AS "Character Count",
        inscription."Text" AS "Text",
        inscription."References" AS "References"
 FROM (
           (SELECT sponsor_appearance."Person ID" AS "Sponsor ID",
                   honorand_appearance."Person ID" AS "Honorand ID",
                   sponsor_appearance."Inscription ID" AS "Inscription ID"
            FROM public."Person in Inscription" AS sponsor_appearance
            INNER JOIN public."Person in Inscription" AS honorand_appearance ON sponsor_appearance."Inscription ID" = honorand_appearance."Inscription ID"
            AND sponsor_appearance."Person ID" != honorand_appearance."Person ID") AS appearance
       INNER JOIN public."Inscription Full"() AS inscription ON appearance."Inscription ID" = inscription."ID")
 UNION ALL SELECT appearance."Sponsor ID" AS "Source",
                  appearance."Honorand ID" AS "Target",
                  'Directed' AS "Type",
                  CONCAT('IE ', inscription."ID", ': ', inscription."Object Type") AS "Label",
                  CAST(inscription."Date" AS double precision) AS "Start",
                  350.0 AS "Stop",
                  1 AS "Weight",
                  inscription."ID" AS "Inscription ID",
                  inscription."IE" AS "IE",
                  inscription."Inscription" AS "Inscription",
                  inscription."Object Type" AS "Object",
                  inscription."Inscription Type" AS "Inscription Type",
                  inscription."Location" AS "Location",
                  inscription."Date" AS "Date",
                  inscription."Date Span" AS "Date Span",
                  inscription."Word Count" AS "Word Count",
                  inscription."Character Count" AS "Character Count",
                  inscription."Text" AS "Text",
                  inscription."References" AS "References"
 FROM (
           (SELECT sponsor_appearance."Institution ID" AS "Sponsor ID",
                   honorand_appearance."Person ID" AS "Honorand ID",
                   sponsor_appearance."Inscription ID" AS "Inscription ID"
            FROM public."Institution Sponsorship" AS sponsor_appearance
            INNER JOIN public."Person in Inscription" AS honorand_appearance ON sponsor_appearance."Inscription ID" = honorand_appearance."Inscription ID") AS appearance
       INNER JOIN public."Inscription Full"() AS inscription ON appearance."Inscription ID" = inscription."ID");


-- View from: /Users/davidthomas/Git/brown-diss/build_db/sql/views/- Gephi Coappearances Nodes -.sql

CREATE OR REPLACE VIEW public."- Gephi Coappearance Nodes -" AS
SELECT DISTINCT sponsor."ID" AS "ID",
                sponsor."Person" AS "Label",
                public."Earliest Date"(sponsor."ID") AS "Start",
                350.0 AS "Stop",
                'Person' AS "Class",
                NULL AS "Type",
                (CASE
                     WHEN sponsor."Category" = 'Athenian'
                          OR sponsor."Category" = 'Eleusinian' THEN 'Athenian'
                     WHEN sponsor."Category" = 'Other'
                          OR sponsor."Category" = 'Uncertain' THEN 'Other/Uncertain'
                     WHEN sponsor."Category" = 'Roman'
                          OR sponsor."Category" = 'Imperial Family' THEN 'Roman'
                     WHEN sponsor."Category" = 'Greek'
                          OR sponsor."Category" = 'Other Greek'
                          OR sponsor."Category" = 'Panhellenic' THEN 'Other Greek'
                     ELSE 'Other/Uncertain'
                 END) AS "Origin",
                sponsor."Gender" AS "Gender",
                (CASE
                     WHEN sponsor."Category" = 'Athenian'
                          AND sponsor."Roman Citizen" = TRUE THEN 'TRUE'
                     ELSE 'FALSE'
                 END) AS "Athenian with Roman Citizenship",
                sponsor."Family" AS "Family",
                sponsor."Extended" AS "Extended",
                sponsor."Deme" AS "Deme"
FROM public."Person in Inscription" AS sponsor_appearance
INNER JOIN public."Person in Inscription" AS honorand_appearance ON sponsor_appearance."Inscription ID" = honorand_appearance."Inscription ID"
INNER JOIN public."Person" AS sponsor ON sponsor_appearance."Person ID" = sponsor."ID"
WHERE sponsor_appearance."Person ID" != honorand_appearance."Person ID"
UNION
SELECT DISTINCT honorand."ID" AS "ID",
                honorand."Person" AS "Label",
                public."Earliest Date"(honorand."ID") AS "Start",
                350.0 AS "Stop",
                'Person' AS "Class",
                NULL AS "Type",
                (CASE
                     WHEN honorand."Category" = 'Athenian'
                          OR honorand."Category" = 'Eleusinian' THEN 'Athenian'
                     WHEN honorand."Category" = 'Other'
                          OR honorand."Category" = 'Uncertain' THEN 'Other/Uncertain'
                     WHEN honorand."Category" = 'Roman'
                          OR honorand."Category" = 'Imperial Family' THEN 'Roman'
                     WHEN honorand."Category" = 'Greek'
                          OR honorand."Category" = 'Other Greek'
                          OR honorand."Category" = 'Panhellenic' THEN 'Other Greek'
                     ELSE 'Other/Uncertain'
                 END) AS "Origin",
                honorand."Gender" AS "Gender",
                (CASE
                     WHEN honorand."Category" = 'Athenian'
                          AND honorand."Roman Citizen" = TRUE THEN 'TRUE'
                     ELSE 'FALSE'
                 END) AS "Athenian with Roman Citizenship",
                honorand."Family" AS "Family",
                honorand."Extended" AS "Extended",
                honorand."Deme" AS "Deme"
FROM public."Person in Inscription" AS honorand_appearance
INNER JOIN public."Person in Inscription" AS sponsor_appearance ON honorand_appearance."Inscription ID" = sponsor_appearance."Inscription ID"
INNER JOIN public."Person" AS honorand ON honorand_appearance."Person ID" = honorand."ID"
WHERE sponsor_appearance."Person ID" != honorand_appearance."Person ID"
UNION
SELECT DISTINCT sponsor."ID" AS "ID",
                sponsor."Institution" AS "Label",
                public."Earliest Date"(sponsor."ID") AS "Start",
                350.0 AS "Stop",
                'Institution' AS "Class",
                sponsor."Type" AS "Type",
                (CASE
                     WHEN sponsor."Category" = 'Athenian'
                          OR sponsor."Category" = 'Eleusinian' THEN 'Athenian'
                     WHEN sponsor."Category" = 'Other'
                          OR sponsor."Category" = 'Uncertain' THEN 'Other/Uncertain'
                     WHEN sponsor."Category" = 'Roman'
                          OR sponsor."Category" = 'Imperial Family' THEN 'Roman'
                     WHEN sponsor."Category" = 'Greek'
                          OR sponsor."Category" = 'Other Greek'
                          OR sponsor."Category" = 'Panhellenic' THEN 'Other Greek'
                     ELSE 'Other/Uncertain'
                 END) AS "Origin",
                NULL AS "Gender",
                NULL AS "Athenian with Roman Citizenship",
                NULL AS "Family",
                NULL AS "Extended",
                NULL AS "Deme"
FROM public."Institution Sponsorship" AS sponsor_appearance
INNER JOIN public."Person in Inscription" AS honorand_appearance ON sponsor_appearance."Inscription ID" = honorand_appearance."Inscription ID"
INNER JOIN public."Institution" AS sponsor ON sponsor_appearance."Institution ID" = sponsor."ID"
INNER JOIN public."Person" AS honorand ON honorand_appearance."Person ID" = honorand."ID"
UNION
SELECT DISTINCT honorand."ID" AS "ID",
                honorand."Person" AS "Label",
                public."Earliest Date"(honorand."ID") AS "Start",
                350.0 AS "Stop",
                'Person' AS "Class",
                NULL AS "Type",
                (CASE
                     WHEN honorand."Category" = 'Athenian'
                          OR honorand."Category" = 'Eleusinian' THEN 'Athenian'
                     WHEN honorand."Category" = 'Other'
                          OR honorand."Category" = 'Uncertain' THEN 'Other/Uncertain'
                     WHEN honorand."Category" = 'Roman'
                          OR honorand."Category" = 'Imperial Family' THEN 'Roman'
                     WHEN honorand."Category" = 'Greek'
                          OR honorand."Category" = 'Other Greek'
                          OR honorand."Category" = 'Panhellenic' THEN 'Other Greek'
                     ELSE 'Other/Uncertain'
                 END) AS "Origin",
                honorand."Gender" AS "Gender",
                (CASE
                     WHEN honorand."Category" = 'Athenian'
                          AND honorand."Roman Citizen" = TRUE THEN 'TRUE'
                     ELSE 'FALSE'
                 END) AS "Athenian with Roman Citizenship",
                honorand."Family" AS "Family",
                honorand."Extended" AS "Extended",
                honorand."Deme" AS "Deme"
FROM public."Person in Inscription" AS honorand_appearance
INNER JOIN public."Institution Sponsorship" AS sponsor_appearance ON honorand_appearance."Inscription ID" = sponsor_appearance."Inscription ID"
INNER JOIN public."Person" AS honorand ON honorand_appearance."Person ID" = honorand."ID";


-- View from: /Users/davidthomas/Git/brown-diss/build_db/sql/views/- Gephi Sponsorship and People Appearing Edges -.sql

CREATE OR REPLACE VIEW public."- Gephi Sponsorship of People Appearing Edges -" AS
SELECT appearance."Sponsor ID" AS "Source",
       appearance."Honorand ID" AS "Target",
       'Directed' AS "Type",
       CONCAT('IE ', inscription."ID", ': ', inscription."Object Type") AS "Label",
       CAST(inscription."Date" AS double precision) AS "Start",
       350.0 AS "Stop",
       1 AS "Weight",
       inscription."ID" AS "Inscription ID",
       inscription."IE" AS "IE",
       inscription."Inscription" AS "Inscription",
       inscription."Object Type" AS "Object",
       inscription."Inscription Type" AS "Inscription Type",
       inscription."Location" AS "Location",
       inscription."Date" AS "Date",
       inscription."Date Span" AS "Date Span",
       inscription."Word Count" AS "Word Count",
       inscription."Character Count" AS "Character Count",
       inscription."Text" AS "Text",
       inscription."References" AS "References"
FROM (
          (SELECT sponsor_appearance."Person ID" AS "Sponsor ID",
                  honorand_appearance."Person ID" AS "Honorand ID",
                  sponsor_appearance."Inscription ID" AS "Inscription ID"
           FROM public."Person in Inscription" AS sponsor_appearance
           INNER JOIN public."Person in Inscription" AS honorand_appearance ON sponsor_appearance."Inscription ID" = honorand_appearance."Inscription ID"
           AND sponsor_appearance."Role" = 'Sponsor'
           AND sponsor_appearance."Person ID" != honorand_appearance."Person ID") AS appearance
      INNER JOIN public."Inscription Full"() AS inscription ON appearance."Inscription ID" = inscription."ID")
UNION ALL
SELECT appearance."Sponsor ID" AS "Source",
       appearance."Honorand ID" AS "Target",
       'Directed' AS "Type",
       CONCAT('IE ', inscription."ID", ': ', inscription."Object Type") AS "Label",
       CAST(inscription."Date" AS double precision) AS "Start",
       350.0 AS "Stop",
       1 AS "Weight",
       inscription."ID" AS "Inscription ID",
       inscription."IE" AS "IE",
       inscription."Inscription" AS "Inscription",
       inscription."Object Type" AS "Object",
       inscription."Inscription Type" AS "Inscription Type",
       inscription."Location" AS "Location",
       inscription."Date" AS "Date",
       inscription."Date Span" AS "Date Span",
       inscription."Word Count" AS "Word Count",
       inscription."Character Count" AS "Character Count",
       inscription."Text" AS "Text",
       inscription."References" AS "References"
FROM (
          (SELECT sponsor_appearance."Institution ID" AS "Sponsor ID",
                  honorand_appearance."Person ID" AS "Honorand ID",
                  sponsor_appearance."Inscription ID" AS "Inscription ID"
           FROM public."Institution Sponsorship" AS sponsor_appearance
           INNER JOIN public."Person in Inscription" AS honorand_appearance ON sponsor_appearance."Inscription ID" = honorand_appearance."Inscription ID"
           AND sponsor_appearance."Role" = 'Sponsor') AS appearance
      INNER JOIN public."Inscription Full"() AS inscription ON appearance."Inscription ID" = inscription."ID");


-- View from: /Users/davidthomas/Git/brown-diss/build_db/sql/views/- Gephi Sponsorship and People Appearing Nodes -.sql

CREATE OR REPLACE VIEW public."- Gephi Sponsorship of People Appearing Nodes -" AS
SELECT DISTINCT sponsor."ID" AS "ID",
                sponsor."Person" AS "Label",
                public."Earliest Date"(sponsor."ID") AS "Start",
                350.0 AS "Stop",
                'Person' AS "Class",
                NULL AS "Type",
                (CASE
                     WHEN sponsor."Category" = 'Athenian'
                          OR sponsor."Category" = 'Eleusinian' THEN 'Athenian'
                     WHEN sponsor."Category" = 'Other'
                          OR sponsor."Category" = 'Uncertain' THEN 'Other/Uncertain'
                     WHEN sponsor."Category" = 'Roman'
                          OR sponsor."Category" = 'Imperial Family' THEN 'Roman'
                     WHEN sponsor."Category" = 'Greek'
                          OR sponsor."Category" = 'Other Greek'
                          OR sponsor."Category" = 'Panhellenic' THEN 'Other Greek'
                     ELSE 'Other/Uncertain'
                 END) AS "Origin",
                sponsor."Gender" AS "Gender",
                (CASE
                     WHEN sponsor."Category" = 'Athenian'
                          AND sponsor."Roman Citizen" = TRUE THEN 'TRUE'
                     ELSE 'FALSE'
                 END) AS "Athenian with Roman Citizenship",
                sponsor."Family" AS "Family",
                sponsor."Extended" AS "Extended",
                sponsor."Deme" AS "Deme"
FROM public."Person in Inscription" AS sponsor_appearance
INNER JOIN public."Person in Inscription" AS honorand_appearance ON sponsor_appearance."Inscription ID" = honorand_appearance."Inscription ID"
INNER JOIN public."Person" AS sponsor ON sponsor_appearance."Person ID" = sponsor."ID"
WHERE sponsor_appearance."Role" = 'Sponsor'
    AND sponsor_appearance."Person ID" != honorand_appearance."Person ID"
UNION
SELECT DISTINCT honorand."ID" AS "ID",
                honorand."Person" AS "Label",
                public."Earliest Date"(honorand."ID") AS "Start",
                350.0 AS "Stop",
                'Person' AS "Class",
                NULL AS "Type",
                (CASE
                     WHEN honorand."Category" = 'Athenian'
                          OR honorand."Category" = 'Eleusinian' THEN 'Athenian'
                     WHEN honorand."Category" = 'Other'
                          OR honorand."Category" = 'Uncertain' THEN 'Other/Uncertain'
                     WHEN honorand."Category" = 'Roman'
                          OR honorand."Category" = 'Imperial Family' THEN 'Roman'
                     WHEN honorand."Category" = 'Greek'
                          OR honorand."Category" = 'Other Greek'
                          OR honorand."Category" = 'Panhellenic' THEN 'Other Greek'
                     ELSE 'Other/Uncertain'
                 END) AS "Origin",
                honorand."Gender" AS "Gender",
                (CASE
                     WHEN honorand."Category" = 'Athenian'
                          AND honorand."Roman Citizen" = TRUE THEN 'TRUE'
                     ELSE 'FALSE'
                 END) AS "Athenian with Roman Citizenship",
                honorand."Family" AS "Family",
                honorand."Extended" AS "Extended",
                honorand."Deme" AS "Deme"
FROM public."Person in Inscription" AS honorand_appearance
INNER JOIN public."Person in Inscription" AS sponsor_appearance ON honorand_appearance."Inscription ID" = sponsor_appearance."Inscription ID"
INNER JOIN public."Person" AS honorand ON honorand_appearance."Person ID" = honorand."ID"
WHERE sponsor_appearance."Role" = 'Sponsor'
    AND sponsor_appearance."Person ID" != honorand_appearance."Person ID"
UNION
SELECT DISTINCT sponsor."ID" AS "ID",
                sponsor."Institution" AS "Label",
                public."Earliest Date"(sponsor."ID") AS "Start",
                350.0 AS "Stop",
                'Institution' AS "Class",
                sponsor."Type" AS "Type",
                (CASE
                     WHEN sponsor."Category" = 'Athenian'
                          OR sponsor."Category" = 'Eleusinian' THEN 'Athenian'
                     WHEN sponsor."Category" = 'Other'
                          OR sponsor."Category" = 'Uncertain' THEN 'Other/Uncertain'
                     WHEN sponsor."Category" = 'Roman'
                          OR sponsor."Category" = 'Imperial Family' THEN 'Roman'
                     WHEN sponsor."Category" = 'Greek'
                          OR sponsor."Category" = 'Other Greek'
                          OR sponsor."Category" = 'Panhellenic' THEN 'Other Greek'
                     ELSE 'Other/Uncertain'
                 END) AS "Origin",
                NULL AS "Gender",
                NULL AS "Athenian with Roman Citizenship",
                NULL AS "Family",
                NULL AS "Extended",
                NULL AS "Deme"
FROM public."Institution Sponsorship" AS sponsor_appearance
INNER JOIN public."Person in Inscription" AS honorand_appearance ON sponsor_appearance."Inscription ID" = honorand_appearance."Inscription ID"
INNER JOIN public."Institution" AS sponsor ON sponsor_appearance."Institution ID" = sponsor."ID"
INNER JOIN public."Person" AS honorand ON honorand_appearance."Person ID" = honorand."ID"
WHERE sponsor_appearance."Role" = 'Sponsor'
UNION
SELECT DISTINCT honorand."ID" AS "ID",
                honorand."Person" AS "Label",
                public."Earliest Date"(honorand."ID") AS "Start",
                350.0 AS "Stop",
                'Person' AS "Class",
                NULL AS "Type",
                (CASE
                     WHEN honorand."Category" = 'Athenian'
                          OR honorand."Category" = 'Eleusinian' THEN 'Athenian'
                     WHEN honorand."Category" = 'Other'
                          OR honorand."Category" = 'Uncertain' THEN 'Other/Uncertain'
                     WHEN honorand."Category" = 'Roman'
                          OR honorand."Category" = 'Imperial Family' THEN 'Roman'
                     WHEN honorand."Category" = 'Greek'
                          OR honorand."Category" = 'Other Greek'
                          OR honorand."Category" = 'Panhellenic' THEN 'Other Greek'
                     ELSE 'Other/Uncertain'
                 END) AS "Origin",
                honorand."Gender" AS "Gender",
                (CASE
                     WHEN honorand."Category" = 'Athenian'
                          AND honorand."Roman Citizen" = TRUE THEN 'TRUE'
                     ELSE 'FALSE'
                 END) AS "Athenian with Roman Citizenship",
                honorand."Family" AS "Family",
                honorand."Extended" AS "Extended",
                honorand."Deme" AS "Deme"
FROM public."Person in Inscription" AS honorand_appearance
INNER JOIN public."Institution Sponsorship" AS sponsor_appearance ON honorand_appearance."Inscription ID" = sponsor_appearance."Inscription ID"
INNER JOIN public."Person" AS honorand ON honorand_appearance."Person ID" = honorand."ID"
WHERE sponsor_appearance."Role" = 'Sponsor';


-- View from: /Users/davidthomas/Git/brown-diss/build_db/sql/views/- Gephi Sponsorship of Honorands Edges -.sql

CREATE OR REPLACE VIEW public."- Gephi Sponsorship of Honorands Edges -" AS
SELECT appearance."Sponsor ID" AS "Source",
       appearance."Honorand ID" AS "Target",
       'Directed' AS "Type",
       CONCAT('IE ', inscription."ID", ': ', inscription."Object Type") AS "Label",
       CAST(inscription."Date" AS double precision) AS "Start",
       350.0 AS "Stop",
       1 AS "Weight",
       inscription."ID" AS "Inscription ID",
       inscription."IE" AS "IE",
       inscription."Inscription" AS "Inscription",
       inscription."Object Type" AS "Object",
       inscription."Inscription Type" AS "Inscription Type",
       inscription."Location" AS "Location",
       inscription."Date" AS "Date",
       inscription."Date Span" AS "Date Span",
       inscription."Word Count" AS "Word Count",
       inscription."Character Count" AS "Character Count",
       inscription."Text" AS "Text",
       inscription."References" AS "References"
FROM (
          (SELECT sponsor_appearance."Person ID" AS "Sponsor ID",
                  honorand_appearance."Person ID" AS "Honorand ID",
                  sponsor_appearance."Inscription ID" AS "Inscription ID"
           FROM public."Person in Inscription" AS sponsor_appearance
           INNER JOIN public."Person in Inscription" AS honorand_appearance ON sponsor_appearance."Inscription ID" = honorand_appearance."Inscription ID"
           AND sponsor_appearance."Role" = 'Sponsor'
           AND honorand_appearance."Role" = 'Honorand') AS appearance
      INNER JOIN public."Inscription Full"() AS inscription ON appearance."Inscription ID" = inscription."ID")
UNION ALL
SELECT appearance."Sponsor ID" AS "Source",
       appearance."Honorand ID" AS "Target",
       'Directed' AS "Type",
       CONCAT('IE ', inscription."ID", ': ', inscription."Object Type") AS "Label",
       CAST(inscription."Date" AS double precision) AS "Start",
       350.0 AS "Stop",
       1 AS "Weight",
       inscription."ID" AS "Inscription ID",
       inscription."IE" AS "IE",
       inscription."Inscription" AS "Inscription",
       inscription."Object Type" AS "Object",
       inscription."Inscription Type" AS "Inscription Type",
       inscription."Location" AS "Location",
       inscription."Date" AS "Date",
       inscription."Date Span" AS "Date Span",
       inscription."Word Count" AS "Word Count",
       inscription."Character Count" AS "Character Count",
       inscription."Text" AS "Text",
       inscription."References" AS "References"
FROM (
          (SELECT sponsor_appearance."Institution ID" AS "Sponsor ID",
                  honorand_appearance."Person ID" AS "Honorand ID",
                  sponsor_appearance."Inscription ID" AS "Inscription ID"
           FROM public."Institution Sponsorship" AS sponsor_appearance
           INNER JOIN public."Person in Inscription" AS honorand_appearance ON sponsor_appearance."Inscription ID" = honorand_appearance."Inscription ID"
           AND sponsor_appearance."Role" = 'Sponsor'
           AND honorand_appearance."Role" = 'Honorand') AS appearance
      INNER JOIN public."Inscription Full"() AS inscription ON appearance."Inscription ID" = inscription."ID");


-- View from: /Users/davidthomas/Git/brown-diss/build_db/sql/views/- Gephi Sponsorship of Honorands Nodes -.sql

CREATE OR REPLACE VIEW public."- Gephi Sponsorship of Honorands Nodes -" AS
SELECT DISTINCT sponsor."ID" AS "ID",
                sponsor."Person" AS "Label",
                public."Earliest Date"(sponsor."ID") AS "Start",
                350.0 AS "Stop",
                'Person' AS "Class",
                NULL AS "Type",
                CASE
                    WHEN sponsor."Category" = 'Athenian'
                         OR sponsor."Category" = 'Eleusinian' THEN 'Athenian'
                    WHEN sponsor."Category" = 'Other'
                         OR sponsor."Category" = 'Uncertain' THEN 'Other/Uncertain'
                    WHEN sponsor."Category" = 'Roman'
                         OR sponsor."Category" = 'Imperial Family' THEN 'Roman'
                    WHEN sponsor."Category" = 'Greek'
                         OR sponsor."Category" = 'Other Greek'
                         OR sponsor."Category" = 'Panhellenic' THEN 'Other Greek'
                    ELSE 'Other/Uncertain'
                END AS "Origin",
                sponsor."Gender" AS "Gender",
                (CASE
                     WHEN sponsor."Category" = 'Athenian'
                          AND sponsor."Roman Citizen" = TRUE THEN 'TRUE'
                     ELSE 'FALSE'
                 END) AS "Athenian with Roman Citizenship",
                sponsor."Family" AS "Family",
                sponsor."Extended" AS "Extended",
                sponsor."Deme" AS "Deme"
FROM public."Person in Inscription" AS sponsor_appearance
INNER JOIN public."Person in Inscription" AS honorand_appearance ON sponsor_appearance."Inscription ID" = honorand_appearance."Inscription ID"
INNER JOIN public."Person" AS sponsor ON sponsor_appearance."Person ID" = sponsor."ID"
WHERE sponsor_appearance."Role" = 'Sponsor'
    AND honorand_appearance."Role" = 'Honorand'
UNION
SELECT DISTINCT honorand."ID" AS "ID",
                honorand."Person" AS "Label",
                public."Earliest Date"(honorand."ID") AS "Start",
                350.0 AS "Stop",
                'Person' AS "Class",
                NULL AS "Type",
                CASE
                    WHEN honorand."Category" = 'Athenian'
                         OR honorand."Category" = 'Eleusinian' THEN 'Athenian'
                    WHEN honorand."Category" = 'Other'
                         OR honorand."Category" = 'Uncertain' THEN 'Other/Uncertain'
                    WHEN honorand."Category" = 'Roman'
                         OR honorand."Category" = 'Imperial Family' THEN 'Roman'
                    WHEN honorand."Category" = 'Greek'
                         OR honorand."Category" = 'Other Greek'
                         OR honorand."Category" = 'Panhellenic' THEN 'Other Greek'
                    ELSE 'Other/Uncertain'
                END AS "Origin",
                honorand."Gender" AS "Gender",
                CASE
                    WHEN honorand."Category" = 'Athenian'
                         AND honorand."Roman Citizen" = TRUE THEN 'TRUE'
                    ELSE 'FALSE'
                END AS "Athenian with Roman Citizenship",
                honorand."Family" AS "Family",
                honorand."Extended" AS "Extended",
                honorand."Deme" AS "Deme"
FROM public."Person in Inscription" AS honorand_appearance
INNER JOIN public."Person in Inscription" AS sponsor_appearance ON honorand_appearance."Inscription ID" = sponsor_appearance."Inscription ID"
INNER JOIN public."Person" AS honorand ON honorand_appearance."Person ID" = honorand."ID"
WHERE sponsor_appearance."Role" = 'Sponsor'
    AND honorand_appearance."Role" = 'Honorand'
UNION
SELECT DISTINCT sponsor."ID" AS "ID",
                sponsor."Institution" AS "Label",
                public."Earliest Date"(sponsor."ID") AS "Start",
                350.0 AS "Stop",
                'Institution' AS "Class",
                sponsor."Type" AS "Type",
                CASE
                    WHEN sponsor."Category" = 'Athenian'
                         OR sponsor."Category" = 'Eleusinian' THEN 'Athenian'
                    WHEN sponsor."Category" = 'Other'
                         OR sponsor."Category" = 'Uncertain' THEN 'Other/Uncertain'
                    WHEN sponsor."Category" = 'Roman'
                         OR sponsor."Category" = 'Imperial Family' THEN 'Roman'
                    WHEN sponsor."Category" = 'Greek'
                         OR sponsor."Category" = 'Other Greek'
                         OR sponsor."Category" = 'Panhellenic' THEN 'Other Greek'
                    ELSE 'Other/Uncertain'
                END AS "Origin",
                NULL AS "Gender",
                NULL AS "Athenian with Roman Citizenship",
                NULL AS "Family",
                NULL AS "Extended",
                NULL AS "Deme"
FROM public."Institution Sponsorship" AS sponsor_appearance
INNER JOIN public."Person in Inscription" AS honorand_appearance ON sponsor_appearance."Inscription ID" = honorand_appearance."Inscription ID"
INNER JOIN public."Institution" AS sponsor ON sponsor_appearance."Institution ID" = sponsor."ID"
INNER JOIN public."Person" AS honorand ON honorand_appearance."Person ID" = honorand."ID"
WHERE sponsor_appearance."Role" = 'Sponsor'
    AND honorand_appearance."Role" = 'Honorand'
UNION
SELECT DISTINCT honorand."ID" AS "ID",
                honorand."Person" AS "Label",
                public."Earliest Date"(honorand."ID") AS "Start",
                350.0 AS "Stop",
                'Person' AS "Class",
                NULL AS "Type",
                CASE
                    WHEN honorand."Category" = 'Athenian'
                         OR honorand."Category" = 'Eleusinian' THEN 'Athenian'
                    WHEN honorand."Category" = 'Other'
                         OR honorand."Category" = 'Uncertain' THEN 'Other/Uncertain'
                    WHEN honorand."Category" = 'Roman'
                         OR honorand."Category" = 'Imperial Family' THEN 'Roman'
                    WHEN honorand."Category" = 'Greek'
                         OR honorand."Category" = 'Other Greek'
                         OR honorand."Category" = 'Panhellenic' THEN 'Other Greek'
                    ELSE 'Other/Uncertain'
                END AS "Origin",
                honorand."Gender" AS "Gender",
                CASE
                    WHEN honorand."Category" = 'Athenian'
                         AND honorand."Roman Citizen" = TRUE THEN 'TRUE'
                    ELSE 'FALSE'
                END AS "Athenian with Roman Citizenship",
                honorand."Family" AS "Family",
                honorand."Extended" AS "Extended",
                honorand."Deme" AS "Deme"
FROM public."Person in Inscription" AS honorand_appearance
INNER JOIN public."Institution Sponsorship" AS sponsor_appearance ON honorand_appearance."Inscription ID" = sponsor_appearance."Inscription ID"
INNER JOIN public."Person" AS honorand ON honorand_appearance."Person ID" = honorand."ID"
WHERE sponsor_appearance."Role" = 'Sponsor'
    AND honorand_appearance."Role" = 'Honorand';



-- =============END OF VIEWS=============
