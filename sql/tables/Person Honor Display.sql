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
ALTER TABLE public."Person Honor Display"
  OWNER TO postgres;
