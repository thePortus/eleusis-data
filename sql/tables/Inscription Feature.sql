-- Table: public."Inscription Feature"

-- DROP TABLE public."Inscription Feature";

CREATE TABLE public."Inscription Feature"
(
  "ID" integer NOT NULL,
  "Inscription ID" integer,
  "Feature" Text,
  "Uncertain" boolean,
  "Notes" text,
  CONSTRAINT "Inscription Feature_pkey" PRIMARY KEY ("ID"),
  CONSTRAINT "Ref_Inscription Feature_to_Inscription" FOREIGN KEY ("Inscription ID")
      REFERENCES public."Inscription" ("ID") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public."Inscription Feature"
  OWNER TO postgres;
