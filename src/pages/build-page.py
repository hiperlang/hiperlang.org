#!/usr/bin/python3

import sys
import re
import os


def process_fn(match):
    """
    This function processes the matched content from the input file and replaces the placeholders with the actual values.

    Args:
        match: A match object containing the matched content from the input file.

    Returns:
        The processed content with the placeholders replaced with the actual values.
    """
    if match.group() is not None:
        params = match.group(1)
        param_dict = {}

        # get params
        if params != "":
            param_pattern = r'(\w+)="([^"]+)"'
            param_matches = re.findall(param_pattern, params)
            for param in param_matches:
                key, value = param
                param_dict[key] = value

        assert (
            "src" in param_dict
        ), 'Error: One of the <include> is missing src="path" attribute.'

        input_file = param_dict["src"]

        assert os.path.isfile(
            input_file
        ), f"Error: Input file '{input_file}' does not exist."

        try:
            with open(input_file, "r") as file:
                content = file.read()
                for key, value in param_dict.items():
                    pattern = f"<!-- %{key}[ ]*-->"
                    content = re.sub(pattern, value, content)
                return content[:-1]

        except Exception as e:
            print(f"Error: {e}")
            exit(1)


if len(sys.argv) != 4:
    print("Usage: engine.py input.html --output output.html")
else:
    input_file = sys.argv[1]
    output_file = sys.argv[3]

    assert os.path.isfile(
        input_file
    ), f"Error: Input file '{input_file}' does not exist."

    try:
        with open(input_file, "r") as file:
            pattern = r"<include\s*(.+?)[ ]*>(.*?)</include>"
            res = re.sub(pattern, process_fn, file.read(), flags=re.DOTALL)

            # flash
            with open(output_file, "w") as file:
                file.write(res)

    except Exception as e:
        print(f"Error: {e}")
