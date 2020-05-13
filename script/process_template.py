import os
import sys
import re
import argparse
import json


def main():
    parser = argparse.ArgumentParser()
    args = parser.parse_args()

    config_file_path = os.path.expanduser("~/.dotfiles.json")

    infile = sys.stdin
    text = infile.read()
    config = {}
    if os.path.exists(config_file_path):
        with open(config_file_path) as config_file:
            config = json.load(config_file)

    variables = config.get("variables", {})

    def replace_var(match):
        if match.group(1):
            return "@" + match.group(0)[2:]
        if match.group(3) in variables:
            return variables[match.group(3)]
        elif match.group(4):
            return match.group(5)
        else:
            return match.group(0)

    text = re.sub(r"""
        ( \\@\{ [^}]* } ) |                       # escaped: \@{....}
        ( @\{ ([a-zA-Z0-9_]+) (- ([^}]*) )? } )   # match with optional default: @{foo-default}
    """, replace_var, text, flags=re.VERBOSE)

    print(text, end=None)


if __name__ == "__main__":
    main()
