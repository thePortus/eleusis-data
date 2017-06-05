CREATE OR REPLACE VIEW public."- Gephi Coappearance Edges -" AS
SELECT appearance."Sponsor ID" AS "Source",
        appearance."Honorand ID" AS "Target",
        'Directed' AS "Type",
        CONCAT('IE ', inscription."ID", ': ', inscription."Object Type") AS "Label",
        CAST(inscription."Date" AS double precision) AS "Start",
        350.0 AS "Stop",
        1 AS "Weight",
        inscription."ID" AS "Inscription ID",
        inscription."IE" AS "IE",
        inscription."Inscription" AS "Inscription",
        inscription."Object Type" AS "Object",
        inscription."Inscription Type" AS "Inscription Type",
        inscription."Location" AS "Location",
        inscription."Date" AS "Date",
        inscription."Date Span" AS "Date Span"
 FROM (
           (SELECT sponsor_appearance."Person ID" AS "Sponsor ID",
                   honorand_appearance."Person ID" AS "Honorand ID",
                   sponsor_appearance."Inscription ID" AS "Inscription ID"
            FROM public."Person in Inscription" AS sponsor_appearance
            INNER JOIN public."Person in Inscription" AS honorand_appearance ON sponsor_appearance."Inscription ID" = honorand_appearance."Inscription ID"
            AND sponsor_appearance."Person ID" != honorand_appearance."Person ID") AS appearance
       INNER JOIN public."Inscription with Text"() AS inscription ON appearance."Inscription ID" = inscription."ID")
 UNION ALL SELECT appearance."Sponsor ID" AS "Source",
                  appearance."Honorand ID" AS "Target",
                  'Directed' AS "Type",
                  CONCAT('IE ', inscription."ID", ': ', inscription."Object Type") AS "Label",
                  CAST(inscription."Date" AS double precision) AS "Start",
                  350.0 AS "Stop",
                  1 AS "Weight",
                  inscription."ID" AS "Inscription ID",
                  inscription."IE" AS "IE",
                  inscription."Inscription" AS "Inscription",
                  inscription."Object Type" AS "Object",
                  inscription."Inscription Type" AS "Inscription Type",
                  inscription."Location" AS "Location",
                  inscription."Date" AS "Date",
                  inscription."Date Span" AS "Date Span"
 FROM (
           (SELECT sponsor_appearance."Institution ID" AS "Sponsor ID",
                   honorand_appearance."Person ID" AS "Honorand ID",
                   sponsor_appearance."Inscription ID" AS "Inscription ID"
            FROM public."Institution Sponsorship" AS sponsor_appearance
            INNER JOIN public."Person in Inscription" AS honorand_appearance ON sponsor_appearance."Inscription ID" = honorand_appearance."Inscription ID") AS appearance
       INNER JOIN public."Inscription with Text"() AS inscription ON appearance."Inscription ID" = inscription."ID")
