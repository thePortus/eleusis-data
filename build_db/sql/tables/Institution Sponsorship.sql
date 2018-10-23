-- Table: public."Institution Sponsorship"

DROP TABLE IF EXISTS public."Institution Sponsorship";

CREATE TABLE public."Institution Sponsorship"
(
  "Institution ID" character varying(50) NOT NULL,
  "Inscription ID" character varying(10) NOT NULL,
  "Role" character varying(20),
  "Uncertain" boolean,
  "Notes" character varying(1000),
  CONSTRAINT "Institution Sponsorship_pkey" PRIMARY KEY ("Institution ID", "Inscription ID"),
  CONSTRAINT "Ref_Institution Sponsorship_to_Inscriptions" FOREIGN KEY ("Inscription ID")
      REFERENCES public."Inscription" ("ID") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "Ref_Institution Sponsorship_to_Institutions" FOREIGN KEY ("Institution ID")
      REFERENCES public."Institution" ("ID") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
