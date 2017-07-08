-- Table: public."Text"

-- DROP TABLE public."Text";

CREATE TABLE public."Text"
(
  "ID" integer NOT NULL,
  "Raw Text" text,
  "Text" text,
  "Lemmata" text,
  "Word Count" integer,
  "Character Count" integer,
  CONSTRAINT "Text_pkey" PRIMARY KEY ("ID"),
  CONSTRAINT "ID" FOREIGN KEY ("ID")
      REFERENCES public."Inscription" ("ID") MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE
)
WITH (
  OIDS=FALSE
);
