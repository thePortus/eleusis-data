-- Table: public."Person Honor Display"

DROP TABLE IF EXISTS public."Person Honor Display";

CREATE TABLE public."Person Honor Display"
(
  "Person ID" character varying(100) NOT NULL,
  "Honor ID" character varying(50) NOT NULL,
  "Inscription ID" character varying(10) NOT NULL,
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
