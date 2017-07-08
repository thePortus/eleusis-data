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
