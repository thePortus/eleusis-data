CREATE OR REPLACE VIEW public."__ Institutional Honor Appearance __" AS
SELECT institution."Institution" AS "Institution",
        institution."Origin" AS "Institution Origin",
        institution."Type" AS "Institution Type",
        institution."Category" AS "Institution Category",
        honor."Honor" AS "Honor",
        honor."Origin" AS "Honor Origin",
        honor."Category" AS "Honor Category",
        honor."Type" AS "Honor Type",
        honor_inscription."Appearances" AS "Honor Appearances",
        inscription."IE" AS "IE",
        CAST(inscription."Inscription" AS TEXT) AS "Inscription",
        inscription."Object Type" AS "Object Type",
        inscription."Inscription Type" AS "Inscription Type",
        inscription."Location" AS "Location",
        inscription."Date" AS "Date",
        inscription."Date Span" AS "Date Span",
        inscription."Word Count" AS "Word Count",
        inscription."Character Count" AS "Character Count",
        inscription."Text" AS "Text",
        institution."ID" AS "Institution ID",
        honor."ID" AS "Honor ID",
        inscription."ID" AS "Inscription ID"
FROM "public"."Institution Honor" AS institution_honor
  INNER JOIN "public"."Honor in Inscription" honor_inscription ON (institution_honor."Honor ID" = honor_inscription."Honor ID")
  INNER JOIN "public"."Honor" AS honor ON (honor_inscription."Honor ID" = honor."ID")
  INNER JOIN "public"."Institution" AS institution ON (institution_honor."Institution ID" = institution."ID")
  INNER JOIN "public"."Inscription with Text"() AS inscription ON (honor_inscription."Inscription ID" = inscription."ID")
ORDER BY institution."ID",
       honor."ID"
