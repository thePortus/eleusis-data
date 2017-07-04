# -*- coding: utf-8 -*-
"""build_db/paths.py

By David Jason Thomas (thePortus.com, dave.a.base@gmail.com)
``
Builds the directory and filepaths necessary for loading and saving the
.sql and data files in order to build the build_database script.
"""
import os

from . import build_order

# Get the directory of this file
CURRENT_DIR = os.path.dirname(os.path.abspath(__file__))

# Move up one directory (to the SQL directory)
ROOT_DIR = os.path.join(CURRENT_DIR, '..')

# Move into the 'data' subdirectory of the root folder
DATA_DIR = os.path.join(ROOT_DIR, 'data')

# Move into the 'sql' subdirectory of the current folder
SQL_DIR = os.path.join(CURRENT_DIR, 'sql')

# Move into the 'tables' subdirectory of the sql folder
TABLES_DIR = os.path.join(SQL_DIR, 'tables')

# Move into the 'functions' subdirectory of the sql folder
FUNCTIONS_DIR = os.path.join(SQL_DIR, 'functions')

# Move into the 'views' subdirectory of the sql folder
VIEWS_DIR = os.path.join(SQL_DIR, 'views')

# The final SQL file for export
SQL_EXPORT_FILE = os.path.join(ROOT_DIR, 'build_database.sql')


def table_paths():
    """Uses build_order to join filenams with directorys for tables"""
    paths = []
    # Build list of filepaths
    for table_name in build_order.tables:
        paths.append(os.path.join(TABLES_DIR, table_name + '.sql'))
    # Return list of filepaths for each table
    return paths


def function_paths():
    """Uses build_order to join filenams with directorys for functions"""
    paths = []
    # Build list of filepaths
    for function_name in build_order.functions:
        paths.append(os.path.join(FUNCTIONS_DIR, function_name + '.sql'))
    # Return list of filepaths for each table
    return paths


def view_paths():
    """Uses build_order to join filenams with directorys for paths"""
    paths = []
    # Build list of filepaths
    for view_name in build_order.views:
        paths.append(os.path.join(VIEWS_DIR, view_name + '.sql'))
    # Return list of filepaths for each table
    return paths
