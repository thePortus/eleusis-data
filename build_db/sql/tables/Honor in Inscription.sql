-- Table: public."Honor in Inscription"

-- DROP TABLE public."Honor in Inscription";

CREATE TABLE public."Honor in Inscription"
(
  "Honor ID" integer NOT NULL,
  "Inscription ID" integer NOT NULL,
  "Appearances" integer,
  "Notes" character varying(1000),
  CONSTRAINT "Honor in Inscription_pkey" PRIMARY KEY ("Inscription ID", "Honor ID"),
  CONSTRAINT "Ref_Honor in Inscription_to_Honor" FOREIGN KEY ("Honor ID")
      REFERENCES public."Honor" ("ID") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "Ref_Honor in Inscription_to_Inscriptions" FOREIGN KEY ("Inscription ID")
      REFERENCES public."Inscription" ("ID") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
