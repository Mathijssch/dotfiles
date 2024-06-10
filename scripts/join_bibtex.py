#! python

import bibtexparser
import os
from bibtexparser.bwriter import BibTexWriter
from bibtexparser.bibdatabase import BibDatabase


def collect_bibtex(dirname: str) -> list:
    res = []
    for root, _, files in os.walk(dirname):
        for file in files:
            if file.endswith(".bib"):
                res.append(os.path.join(root, file))
    return res


def join(bibtex_files, out_file: str = "all_bibtexs.bib"):

    entries_dict = {}

    for file in bibtex_files:
        with open(file, "r") as bib:
            bibtex_str = bib.read()
        bib_database = bibtexparser.loads(bibtex_str)
        entries_dict.update(bib_database.get_entry_dict())

    bib = BibDatabase()
    bib.entries_dict = entries_dict

    writer = BibTexWriter()
    with open(out_file, 'w') as bibfile:
        bibfile.write(writer.write(bib))


if __name__ == "__main__":

    bibtex_files = collect_bibtex(".")
    join(bibtex_files)
