# -*- coding: utf-8 -*-
"""build_db/__init__.py

By David Jason Thomas (thePortus.com, dave.a.base@gmail.com)
``
The initialization script for the build_db module. build_script.py contains
code which calls other files and exports the finished data. This file
merely exposes the central function (export_file) for importation from an
outside script.
"""
from .build_script import export_file as build
