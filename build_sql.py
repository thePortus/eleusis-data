import build_db

print('Rebuilding SQL queries and exporting to file...')
build_db.build()
print('Success! Exported to', build_db.paths.SQL_EXPORT_FILE)
exit()
