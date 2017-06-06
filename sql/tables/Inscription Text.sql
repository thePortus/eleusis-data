-- Table: public."Text"

-- DROP TABLE public."Text";

CREATE TABLE public."Text"
(
  "Raw Text" text,
  "Text" text,
  "Lemmata" text,
  "ID" integer NOT NULL,
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
ALTER TABLE public."Text"
  OWNER TO postgres;
