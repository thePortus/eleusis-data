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
ALTER TABLE public."Institution"
  OWNER TO postgres;
