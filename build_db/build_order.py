# -*- coding: utf-8 -*-
"""build_db/build_order.py

By David Jason Thomas (thePortus.com, dave.a.base@gmail.com)
``
Contains the order in which files should be appended to create the master
SQL script. This ensures that no files which are dependent upon others will
be run before the files upon which they are dependent. Tables will be added
first, then functions, then views, in the order in which they appear below.
"""

tables = [
    'Inscription',
    'Inscription Text',
    'Inscription Reference',
    'Inscription Feature',
    'Inscription Macroscopic',
    'Institution',
    'Honor',
    'Person',
    'Institution Honor',
    'Honor in Inscription',
    'Institution Sponsorship',
    'Person in Inscription',
    'Person Honor Display'
]

functions = [
    'Inscription Full',
    'Inscription Honors Stats',
    'Inscription Institutions Stats',
    'Inscription People Stats',
    'Persons on Inscriptions Stats',
    'Persons on Institution Inscriptions Stats',
    'Persons with Honor Stats',
    'Persons Combined Stats',
    'Earliest Date'
]

views = [
    '__ Inscription Co-Sponsorship __',
    '__ Inscription Honor with Institution __',
    '__ Inscription Person __',
    '__ Inscription Sponsor __',
    '__ Inscription Sponsorship of Honorand __',
    '__ Institutional Honor __',
    '__ Institutional Honor Appearance __',
    '__ Institutional Inscription __',
    '__ Institutional Inscription Honor __',
    '__ Institutional Inscription Honor Appearance __',
    '__ Institutional Inscription Person __',
    '__ Institutional Inscription Person Appearance __',
    '__ Institutional Inscription Person Honor __',
    '__ Institutional Inscription Person Honor Appearance __',
    '__ Institutional Officer __',
    '__ Institutional Officer Appearance __',
    '__ Institutional Officer Appearance as Officer __',
    '__ Institutional Officer Other Honor __',
    '__ Institutional Officer Other Honor Appearance __',
    # '__ Institutional Officer Sponsor __',
    # '__ Institutional Officer Co-Appearer',
    # '__ Institutional Officer Co-Appearer Honor __',
    # '__ Institutional Officer Co-Appearer Honor Appearance __',
    '__ Personal Honor __',
    '__ Personal Honor Appearance __',
    '- Gephi Coappearances Edges -',
    '- Gephi Coappearances Nodes -',
    '- Gephi Sponsorship and People Appearing Edges -',
    '- Gephi Sponsorship and People Appearing Nodes -',
    '- Gephi Sponsorship of Honorands Edges -',
    '- Gephi Sponsorship of Honorands Nodes -',
]
