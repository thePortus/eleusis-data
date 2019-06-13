-- Table: public."Inscription Multistone"

DROP TABLE IF EXISTS public."Inscription Multistone";

CREATE TABLE public."Inscription  Multistone"
(
  "ID" character varying(100),
  "IE" character varying(10),
  "Notes" integer,
  CONSTRAINT "Inscription Multistone_pkey" PRIMARY KEY ("ID")
)
WITH (
  OIDS=FALSE
);
