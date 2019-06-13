-- Table: public."Inscription Reference"

DROP TABLE IF EXISTS public."Inscription Reference";

CREATE TABLE public."Inscription Reference"
(
  "Inscription ID" character varying(100) NOT NULL,
  "Publication" character varying(50),
  "Number" character varying(50),
  "Additional" character varying(50),
  "Notes" character varying(500),
  CONSTRAINT "Inscription Reference_pkey" PRIMARY KEY ("Inscription ID", "Publication", "Number"),
  CONSTRAINT "Ref_Inscription Reference_to_Inscription" FOREIGN KEY ("Inscription ID")
      REFERENCES public."Inscription" ("ID") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
