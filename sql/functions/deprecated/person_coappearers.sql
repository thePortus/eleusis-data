CREATE FUNCTION public.person_coappearers(
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
    OUT "Demotic" character varying,
    OUT "Role" character varying
) RETURNS SETOF record AS
$BODY$
SELECT coappearer."ID",
       'Person',
       coappearer."Name",
       coappearer."Origin",
       NULL,
       coappearer."Gender",
       coappearer."Athenian Citizen",
       coappearer."Roman Citizen",
       coappearer."Family",
       coappearer."Extended",
       coappearer."Demotic",
       coappearance."Role"
FROM (((public."Person" AS person
        INNER JOIN public."Person in Inscription" AS person_appearance ON person_appearance."Person ID" = Person."ID")
       INNER JOIN public."Person in Inscription" AS coappearance ON person_appearance."Inscription ID" = coappearance."Inscription ID"
       AND person_appearance."Person ID" != coappearance."Person ID")
      INNER JOIN public."Person" AS coappearer ON coappearance."Person ID" = coappearer."ID")
WHERE person."ID" = person_id
    UNION ALL
    SELECT coappearer."ID",
           'Institution',
           coappearer."Name",
           coappearer."Origin",
           coappearer."Type",
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           'Sponsor'
    FROM (((public."Person" AS person
            INNER JOIN public."Person in Inscription" AS person_appearance ON person_appearance."Person ID" = Person."ID")
           INNER JOIN public."Institution Sponsorship" AS coappearance ON person_appearance."Inscription ID" = coappearance."Inscription ID")
          INNER JOIN public."Institution" AS coappearer ON coappearance."Institution ID" = coappearer."ID") WHERE person."ID" = person_id

$BODY$
LANGUAGE sql STABLE NOT LEAKPROOF;
