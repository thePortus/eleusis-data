import os
import csv
import re

load_path = os.path.join(
    os.path.abspath(os.getcwd()),
    'import_data',
    'Text.csv'
)
save_path = os.path.join(
    os.path.abspath(os.getcwd()),
    'export_data',
    'Text.csv'
)
cleaned_records = []
with open(load_path, 'r+', encoding='utf-8') as readfile:
    fieldnames = [
        "ID", "Raw Text", "Text", "Lemmata", "Word Count", "Character Count"
    ]
    reader = csv.DictReader(readfile, fieldnames=fieldnames)
    for record in reader:
        clean_record = record
        clean_record['Raw Text'] = re.sub(
            r'\n+', '\n', record['Raw Text']
        ).strip()
        cleaned_records.append(clean_record)
with open(save_path, 'w+', encoding='utf=8') as savefile:
    fieldnames = [
        "ID", "Raw Text", "Text", "Lemmata", "Word Count", "Character Count"
    ]
    writer = csv.DictWriter(savefile, fieldnames=fieldnames)
    writer.writeheader()
    for record in cleaned_records:
        writer.writerow(record)
print('Done')
