-- Table: public."Person in Inscription"

-- DROP TABLE public."Person in Inscription";

CREATE TABLE public."Person in Inscription"
(
  "Person ID" integer NOT NULL,
  "Inscription ID" integer NOT NULL,
  "Role" character varying(50),
  "Notes" character varying(500),
  CONSTRAINT "People in Inscriptions_pkey" PRIMARY KEY ("Inscription ID", "Person ID"),
  CONSTRAINT "Ref_People in Inscriptions_to_Inscription" FOREIGN KEY ("Inscription ID")
      REFERENCES public."Inscription" ("ID") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "Ref_People in Inscriptions_to_Person" FOREIGN KEY ("Person ID")
      REFERENCES public."Person" ("ID") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public."Person in Inscription"
  OWNER TO postgres;
