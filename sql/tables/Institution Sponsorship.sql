-- Table: public."Institution Sponsorship"

-- DROP TABLE public."Institution Sponsorship";

CREATE TABLE public."Institution Sponsorship"
(
  "Institution ID" integer NOT NULL,
  "Inscription ID" integer NOT NULL,
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
ALTER TABLE public."Institution Sponsorship"
  OWNER TO postgres;
