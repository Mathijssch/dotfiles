#!/usr/bin/env python3

import biblib.bib
import argparse
import sys


def main():
    arg_parser = argparse.ArgumentParser(
        description='Flatten macros, combine, and pretty-print .bib database(s)')
    arg_parser.add_argument('bib', nargs='+', help='.bib file(s) to process',
                            type=open)
    arg_parser.add_argument('--min-crossrefs', type=int,
                            help='minimum number of cross-referencing entries'
                            ' required to expand a crossref; if omitted, no'
                            ' expansion occurs', default=None)
    args = arg_parser.parse_args()

    try:
        # Load databases
        db = biblib.bib.Parser().parse(args.bib, log_fp=sys.stderr).get_entries()

        # Optionally resolve cross-references
        if args.min_crossrefs is not None:
            db = biblib.bib.resolve_crossrefs(
                db, min_crossrefs=args.min_crossrefs)
    except biblib.messages.InputError:
        sys.exit(1)

    # Pretty-print entries
    for ent in db.values():
        print(ent.to_bib())
        print()


if __name__ == '__main__':
    main()
