# The Networks of Roman Eleusis

By [David J. Thomas](mailto:dave.a.base@gmail.com), [thePortus](http://thePortus.com)

This repository contains data related to the dissertation of David J. Thomas for Brown University. Data is posted here for academic transparency. You may use this data according to Fair Use practice. You may distribute your own derived data and works, but please do not redistribute the raw data located here. If you notice any issues or wish to make corrections, fork this repository, make changes, and issue a pull request with comments. See the [contribution guidelines](CONTRIBUTING.md) for more information.

---
## Abstract (From Dissertation)

This is a history of Eleusis, of the people it connected, and of Athenian dynamism amidst the fluctuating power currents of the Roman world, from the sack of Sulla in 87/6 BCE to the universal grant of Roman citizenship in 212 CE. This study explores why Eleusis was simultaneously hyper-Athenian yet increasingly Roman, what role the pressures surrounding social status had in shaping this picture, and what combinations of associations individuals and elite families invoked in their commemorations at the site and its urban counterpart, the City Eleusinion. Examining the physical changes of Eleusis, the evolving features of its inscriptions, and the activities of the individuals associated with the sanctuary, we will see a mounting game of social competition in which civic, religious, elite, Athenian, and Roman statuses all became progressively intertwined.

In addition to close readings of many inscriptions, this project also explores a new possibility for understanding long-term trends by employing dynamic network analysis to visually map changes in the complex combinations of statuses and the reciprocal connections between individuals and institutions recorded on stone. Inscriptions are not merely passive records but also persuasive documents, selectively foregrounding some social realities while eliding others. Tracing these constellations of associations, we can put our finger on the pulse of social competition and status display and understand precisely why 'Romanization' is a difficult term to explain change at the sanctuary.

Epigraphic trends provide clues to the social pressures shaping aristocratic competition, but leave little room to understand the motivation of individual actors. Accordingly, this project also details how several families responded to changing conditions and new opportunities. Linking numerous forms of status: Athenian, Roman, and Eleusinian, was increasingly necessary. The intensity of elite competition over status, given new dimensions by imperial incorporation, stratified the Eleusinian elite.

Status claims not only mounted in intensity over time, they became increasingly interdependent. This was possible because Eleusis bridged city and empire, past and present, individual and institution, civic and sacred. Eleusis' audience was at once intensely local and broadly 'global.' The site was a nexus, ultra-Roman yet supremely Athenian, because it was a pronounced space in which competitive families could acquire and display constellations of statuses more intensely than in the city itself. The renaissance of the sanctuary is part of the story of Athens, of a vibrant polis and its community capitalizing on imperial opportunities.

---

## Installation

The installation directions below are intended for Digital Humanists who may or may not have had direct experience with PostgreSQL databases or their related tool. If you are experienced with these tools, this is the shortened version: create a blank postgres database, run the `build_database.sql` to create empty tables, functions, and views. Finally, import the data tables using the `data_raw` directory.

### Cloning the Repository

Open your terminal (or command prompt), and navigate to the directory where you want to store this repository and enter `git clone https://github.com/thePortus/brown-diss.git`

### Installing PostgreSQL and PGAdmin

[PostgreSQL 9.0 or later](https://www.postgresql.org/) is required to use this repository. Once you have installed the database, you need to install a tool to interact with it, such as [PGAdmin](https://www.pgadmin.org/).

### Connecting to the Server and Creating the Database

Once installed, start PGAdmin, click the `File` menu and choose `Add Server...`. Here, enter the information of the PostgreSQL server... If you installed it on your own machine, enter `127.0.0.1` for the `Host` field. Unless you changed it during installation, the default `Port` should be `5432`. You can enter whatever you wish in the `Name` field, this is just for your reference inside of PGAdmin. Enter your username, if you set one during installation (if not, the default is `postgres`). If you were asked to set a password during installation, enter that, otherwise leave it blank. Then click `Ok`. Now, whenever you open PGAdmin, double-click the name of the server you just added in the main window and you will connect to it.

Now, if you have not already, double-click the server in the main window to connect. Then right-click `Databases` and choose `New Database...`. Choose the name of your database (e.g. Roman Eleusis). If you are using a username other than postgres, set the owner to that username. Then click `Ok`. You now have a brand new empty database.

### Creating Tables, Functions, and Views

There should be an icon in the top toolbar (just below the menus) that looks like a magnifying class which read 'SQL'. Click that icon to bring up to SQL window. This allows you to directly issue SQL statements to the server. Now, open build_database.sql (located in the main directory of this repository) in a text editor, and copy the contents. Paste this into PGAdmin's SQL editor and click `Run`. If all goes well, it should say something about the operation returning successfully.

### Uploading Data

The last major step in setting up the database is to import the data into the raw SQL tables. To do this, connect to the server, click on `Databases`, then click on the name of your database (e.g. `Roman Eleusis`). Next, click `Schemas`, and then `Public`, and then `Tables`. You should see a list of tables corresponding with the .CSV files located in the `import_data` directory of this repository. For each table, right-click on it and choose `Import`.

On the pop-up menu (for each table), next to the `Filename` field, choose `Browse...` and select the file in this repository's `import_data` folder corresponding to the table. Set `format` to `csv` and `encoding` to `utf_8`. Under the `Misc. Options` tab, click the `Header` box and set `Delimiter` to `,`. Then click the `Quote Options` tab and set `Quote` to `"`. Finally, click import. You must repeat this step for each of the data tables.

*Note, the data from some tables are dependent upon other tables which must be added first. Following the list below should ensure that importation works correctly*
1. Inscription
2. Inscription Text
3. Inscription Reference
4. Inscription Feature
5. Inscription Macroscopic
6. Institution
7. Honor
8. Person
9. Institution Honor
10. Honor in Inscription
11. Institution Sponsorship
12. Person in Inscription
13. Person Honor Display

---

## Repository Contents

```bash
./build_db/ # Python module to create the master build_database.sql
./build_db/sql/ # SQL statements which go into making build_database.sql
./import_data/ # Data tables to be imported to the PostgreSQL server
./export_data/ # Data produced by dB views (warning: may be out of date)
./eleusis_master.xlsx # Excel file with all the data tables (save text table)
```

---
## Rebuilding Master SQL File

To rebuild the master SQL file from the component SQL files, you need to do the
following...
1. Install [Python 3.6x](https://python.org)
2. Navigate to the directory repository in your terminal or command prompt
3. Enter `pip install -r requirements.txt`
3. Enter `python run_to_rebuild_sql.py`
4. That's it, you should see a message saying the build and export worked.

---

## Credits

Much of this data is based off of Kevin Clinton's _Eleusis the Inscriptions on Stone_, Sean Byrne's _Roman Citizens of Athens_, and Geoffrey C.R. Schmalz's _Augustan and Julio-Claudian Athens: A New Epigraphy and Prosopography_, with additions and emmendations from numerous other works. I am deeply indebted to their valuable work which has shed light on the individuals and institutions of Roman Athens. For a full bibliography, see my forthcoming dissertation.
