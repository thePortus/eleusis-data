-- Table: public."Person"

DROP TABLE IF EXISTS public."Person";

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
