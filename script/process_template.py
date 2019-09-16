import os
import sys
import re
import argparse
import json


def main():
    parser = argparse.ArgumentParser()
    args = parser.parse_args()

    config_file_path = os.path.expanduser("~/.dotfiles.json")

    if not os.path.exists(config_file_path):
        print(sys.stdin.read(), end=None)
        return

    infile = sys.stdin
    text = infile.read()
    with open(config_file_path) as config_file:
        config = json.load(config_file)

    variables = config.get("variables", {})

    def replace_var(match):
        if match.group(1):
            return "@" + match.group(0)[2:]
        if match.group(2) in variables:
            return variables[match.group(2)]
        elif match.group(3):
            return match.group(4)
        else:
            return match.group(0)

    text = re.sub(r"(\@\\{[^}]*})|\@\{([a-zA-Z0-9_]+)(-([^}]*))?}", replace_var, text)

    print(text, end=None)


if __name__ == "__main__":
    main()
