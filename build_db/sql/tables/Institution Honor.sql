-- Table: public."Institution Honor"

DROP TABLE IF EXISTS public."Institution Honor";

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
