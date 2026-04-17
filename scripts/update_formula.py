#!/usr/bin/env python3

from __future__ import annotations

import argparse
import pathlib
import re
import sys


def update_formula(path: pathlib.Path, version: str, source_url: str, sha256: str) -> None:
    contents = path.read_text()
    contents, url_count = re.subn(
        r'^  url ".*"$',
        f'  url "{source_url}"',
        contents,
        count=1,
        flags=re.MULTILINE,
    )
    contents, sha_count = re.subn(
        r'^  sha256 ".*"$',
        f'  sha256 "{sha256}"',
        contents,
        count=1,
        flags=re.MULTILINE,
    )
    if url_count != 1 or sha_count != 1:
        raise ValueError("failed to update formula url/sha256")
    path.write_text(contents)


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--formula", required=True)
    parser.add_argument("--version", required=True)
    parser.add_argument("--url", required=True)
    parser.add_argument("--sha256", required=True)
    args = parser.parse_args()

    formula_path = pathlib.Path(args.formula)
    update_formula(formula_path, args.version, args.url, args.sha256)
    print(f"updated {formula_path} to {args.version}")
    return 0


if __name__ == "__main__":
    sys.exit(main())

