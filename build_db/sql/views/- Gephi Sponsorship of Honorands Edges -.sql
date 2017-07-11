DROP VIEW public."- Gephi Sponsorship of Honorands Edges -" IF EXISTS;
CREATE OR REPLACE VIEW public."- Gephi Sponsorship of Honorands Edges -" AS
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
       inscription."Date Span" AS "Date Span",
       inscription."Word Count" AS "Word Count",
       inscription."Character Count" AS "Character Count",
       inscription."Text" AS "Text",
       inscription."References" AS "References"
FROM (
          (SELECT sponsor_appearance."Person ID" AS "Sponsor ID",
                  honorand_appearance."Person ID" AS "Honorand ID",
                  sponsor_appearance."Inscription ID" AS "Inscription ID"
           FROM public."Person in Inscription" AS sponsor_appearance
           INNER JOIN public."Person in Inscription" AS honorand_appearance ON sponsor_appearance."Inscription ID" = honorand_appearance."Inscription ID"
           AND sponsor_appearance."Role" = 'Sponsor'
           AND honorand_appearance."Role" = 'Honorand') AS appearance
      INNER JOIN public."Inscription Full"() AS inscription ON appearance."Inscription ID" = inscription."ID")
UNION ALL
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
       inscription."Date Span" AS "Date Span",
       inscription."Word Count" AS "Word Count",
       inscription."Character Count" AS "Character Count",
       inscription."Text" AS "Text",
       inscription."References" AS "References"
FROM (
          (SELECT sponsor_appearance."Institution ID" AS "Sponsor ID",
                  honorand_appearance."Person ID" AS "Honorand ID",
                  sponsor_appearance."Inscription ID" AS "Inscription ID"
           FROM public."Institution Sponsorship" AS sponsor_appearance
           INNER JOIN public."Person in Inscription" AS honorand_appearance ON sponsor_appearance."Inscription ID" = honorand_appearance."Inscription ID"
           AND sponsor_appearance."Role" = 'Sponsor'
           AND honorand_appearance."Role" = 'Honorand') AS appearance
      INNER JOIN public."Inscription Full"() AS inscription ON appearance."Inscription ID" = inscription."ID");
