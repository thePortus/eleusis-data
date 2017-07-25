-- Table: public."Inscription"

DROP TABLE IF EXISTS public."Inscription";

CREATE TABLE public."Inscription"
(
  "ID" integer NOT NULL,
  "IE" character varying(10),
  "Inscription" character varying(500),
  "Object Type" character varying(200),
  "Inscription Type" character varying(200),
  "Location" character varying(200),
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
