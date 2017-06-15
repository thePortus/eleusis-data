CREATE OR REPLACE VIEW public."__ Institutional Honor __" AS
SELECT DISTINCT institution."Institution" AS "Institution",
                honor."Honor" AS "Honor",
                institution."Category" AS "Institution Origin",
                institution."Type" AS "Institution Type",
                honor."Type" AS "Honor Type",
                honor."Category" AS "Honor Origin",
                institution."ID" AS "Institution ID",
                honor."ID" AS "Honor ID"
FROM public."Institution Honor" AS institution_honor
INNER JOIN public."Institution" AS institution ON institution_honor."Institution ID" = institution."ID"
INNER JOIN public."Honor" AS honor ON institution_honor."Honor ID" = honor."ID"
GROUP BY institution."ID",
         honor."ID"
ORDER BY institution."ID",
         honor."ID"
