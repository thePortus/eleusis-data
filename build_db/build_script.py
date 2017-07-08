# -*- coding: utf-8 -*-
"""build_db/build_script.py

By David Jason Thomas (thePortus.com, dave.a.base@gmail.com)
``
Contains the core functions to assemble the .sql scripts into a single file
and save it to the root directory's build_database.sql file.
"""
from . import paths


def read_sql_file(filepath):
    """Reads .sql file at given path and returns contents as a list of lines"""
    # Open as unicode file
    with open(filepath, 'r+', encoding='utf-8') as sql_file:
        # Return contents as list of strings
        return sql_file.readlines()


def build_sql_type(list_of_paths, type_of_paths):
    """Joins together the individual files of either tables, functions, or
    views"""
    # Raising exception if improper type_of_paths is specified
    if (
        type_of_paths != 'Table' and
        type_of_paths != 'Function' and
        type_of_paths != 'View'
    ):
        raise Exception(
            'type_of_paths must either be Table, Function, or View'
        )
    # tables_sql will contain list of lines of SQL from all tables
    sql_lines = []
    # Loop through filepaths for each table
    for table_path in list_of_paths:
        # Preceed each table SQL with comment indicating source file
        sql_lines.append(
            '-- ' + type_of_paths + ' from: ' + table_path + '\n\n'
        )
        # Add list of SQL lines from the table
        sql_lines += read_sql_file(table_path)
        # Add blank line for readability
        sql_lines.append('\n\n')
    # Return list of strings with all files of a particular SQL type
    return sql_lines


def assemble_file():
    # List which will contain strings of every line of SQL
    master_sql = []
    # Add SQL file headings
    master_sql.append('-- Roman Eleusis build_database.sql\n')
    master_sql.append('-- by David J. Thomas, thePortus.com\n')
    master_sql.append('\n')
    # Section heading for readability
    master_sql.append('\n-- =============START OF TABLES=============\n')
    # Add SQL for all tables
    master_sql += build_sql_type(paths.table_paths(), 'Table')
    # Section headings for readability
    master_sql.append('-- =============END OF TABLES=============\n')
    master_sql.append('\n')
    master_sql.append('-- =============START OF FUNCTIONS=============\n')
    # Add SQL for all functions
    master_sql += build_sql_type(paths.function_paths(), 'Function')
    # Section headings for readability
    master_sql.append('\n-- =============END OF FUNCTIONS=============\n')
    master_sql.append('\n')
    master_sql.append('\n-- =============START OF VIEWS=============\n')
    # Add SQL for all views
    master_sql += build_sql_type(paths.view_paths(), 'View')
    # Section headings for readability
    master_sql.append('\n-- =============END OF VIEWS=============\n')
    # Return list of strings with all file's SQL
    return master_sql


def export_file():
    # Open file for export
    with open(paths.SQL_EXPORT_FILE, 'w+', encoding='utf-8') as sql_file:
        # Invoke assemble_file and write list of strings it returns to file
        sql_file.writelines(assemble_file())
    # Return true on success
