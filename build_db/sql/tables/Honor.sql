-- Table: public."Honor"

DROP TABLE IF EXISTS public."Honor";

CREATE TABLE public."Honor"
(
  "ID" character varying(100) NOT NULL,
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
