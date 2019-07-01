-- Table: public."Inscription Macroscopic"

DROP TABLE IF EXISTS public."Inscription Macroscopic";

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
