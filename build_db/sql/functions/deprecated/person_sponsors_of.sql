CREATE FUNCTION public.person_sponsors_of(
    IN person_id integer,
    OUT "ID" integer,
    OUT "Category" character varying,
    OUT "Name" character varying,
    OUT "Origin" character varying,
    OUT "Type" character varying,
    OUT "Gender" character varying,
    OUT "Athenian Citizen" boolean,
    OUT "Roman Citizen" boolean,
    OUT "Family" character varying,
    OUT "Extended" character varying,
    OUT "Demotic" character varying
) RETURNS SETOF record AS
$BODY$
SELECT DISTINCT sponsor."ID",
       'Person',
       sponsor."Name",
       sponsor."Origin",
       NULL,
       sponsor."Gender",
       sponsor."Athenian Citizen",
       sponsor."Roman Citizen",
       sponsor."Family",
       sponsor."Extended",
       sponsor."Demotic"
FROM (((public."Person" AS person
        INNER JOIN public."Person in Inscription" AS person_appearance ON person_appearance."Person ID" = Person."ID")
       INNER JOIN public."Person in Inscription" AS coappearance ON person_appearance."Inscription ID" = coappearance."Inscription ID"
       AND person_appearance."Person ID" != coappearance."Person ID" AND coappearance."Role" = 'Sponsor')
      INNER JOIN public."Person" AS sponsor ON coappearance."Person ID" = sponsor."ID")
WHERE person."ID" = person_id AND person_appearance."Role" = 'Honoree'
    UNION ALL
    SELECT DISTINCT sponsor."ID",
           'Institution',
           sponsor."Name",
           sponsor."Origin",
           sponsor."Type",
           NULL,
           NULL::boolean,
           NULL::boolean,
           NULL,
           NULL,
           NULL
    FROM (((public."Person" AS person
            INNER JOIN public."Person in Inscription" AS person_appearance ON person_appearance."Person ID" = Person."ID")
           INNER JOIN public."Institution Sponsorship" AS coappearance ON person_appearance."Inscription ID" = coappearance."Inscription ID" AND coappearance."Role" = 'Sponsor')
          INNER JOIN public."Institution" AS sponsor ON coappearance."Institution ID" = sponsor."ID") WHERE person."ID" = person_id AND person_appearance."Role" = 'Honoree'
$BODY$
LANGUAGE sql STABLE NOT LEAKPROOF;
