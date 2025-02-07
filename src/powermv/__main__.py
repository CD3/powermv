import importlib.metadata
import pathlib
import sys
from collections import Counter
from typing import Annotated

import cyclopts
import rich.console

from powermv.matching import *
from powermv.operations import *
from powermv.rendering import *

__version__ = importlib.metadata.version("powermv")

app = cyclopts.App(
    name="powermv",
    version=__version__,
)


def make_move_operations_set(match_pattern, replace_template, files, match_name_only):
    matcher = RegexMatcher(match_pattern)
    renderer = Jinja2Renderer(replace_template)
    moves = MoveOpSet()

    processed_files = []
    # keeping track of files we have seen to keep from adding duplicates.
    for file in files:
        if file in processed_files:
            continue

        str_to_match = str(file) if not match_name_only else file.name
        ctx = matcher.get_match_tokens(str_to_match)
        if ctx is None:
            continue

        replacement_text = renderer.render(ctx)
        str_to_insert = str_to_match.replace(ctx["_0"], replacement_text, 1)
        outfile = (
            str_to_insert
            if not match_name_only
            else str(file.parent) + "/" + str_to_insert
        )
        if file.is_dir():
            outfile += "/"

        op = MoveOp(file, outfile)

        moves.add(op)

        processed_files.append(file)

    return moves


@app.default
def main(
    match_pattern: str,
    replace_template: str,
    files: list[pathlib.Path],
    /,
    execute: Annotated[bool, cyclopts.Parameter(name=["--execute", "-x"])] = False,
    name_only: Annotated[bool, cyclopts.Parameter(name=["--name-only", "-n"])] = False,
    overwrite: Annotated[bool, cyclopts.Parameter(name=["--overwrite"])] = False,
    quiet: bool = False,
):
    """
    Batch move files with the power of jinja2 templates.

    With great power comes great responsibility...

    Parameters
    ----------

    match_pattern
        Pattern to match input filenames against.
    replace_template
        Jinja2 template to render output filename with.
    execute
        Execute move operations (by default, nothing is moved, only a dry-run is performed).
    name-only
        Apply match pattern to the file/dir name only, not the entire path.
    overwrite
        Proceed with executing operations even if they would overwrite existing files.
    quiet
        Don't print status information.
    """

    console = rich.console.Console(stderr=False, quiet=quiet)
    econsole = rich.console.Console(stderr=True)

    console.print("Building move operations set")
    try:
        moves = make_move_operations_set(
            match_pattern,
            replace_template,
            files,
            match_name_only=name_only,
        )
    except RuntimeError as e:
        econsole.print(f"{e}")
        return 1
    except Exception as e:
        econsole.print(
            f"An unknown error occured while building the move operation set: {e}"
        )
        return 1

    if len(moves) == 0:
        console.print("No files to move")
        return 1

    ##########ERROR DETECTION###########
    console.print("Analyzing move operations set")

    def print_errors(errors):
        econsole.print("Errors detected in move set")
        for error in errors:
            econsole.print(f"  {error}")

    errors = []
    for op in moves.iter_ops():
        if not op.input.exists():
            errors.append(f"Input '{op.input}' does not exist")
    if len(errors):
        print_errors(errors)
        return 1
    inputs = {}

    inputs = Counter([op.input for op in moves.iter_ops()])
    for file, count in filter(lambda item: item[1] > 1, inputs.items()):
        errors.append(f"Input '{file}' appears {count} times in opertion set")

    if len(errors):
        print_errors(errors)
        return 1

    # check if multiple operations have the same output
    outputs = Counter([op.output for op in moves.iter_ops()])
    for file, count in filter(lambda item: item[1] > 1, outputs.items()):
        if not file.is_dir():
            errors.append(f"Output: {file}")
            for _op in moves.iter_ops(lambda o: o.output == file):
                errors.append(f"  {_op.input} -> {_op.output}")
        else:
            ops = list(moves.iter_ops(lambda o: o.output == file))
            msg = []
            msg.append(
                f"NOTE: '{file}' is a directory that is given as the output for {len(ops)} move operations.\n"
            )
            msg.append(
                f"      It is assumed that you want to move all inputs (including directories) into this directory.\n"
            )
            msg.append(
                f"      If you were trying to rename a directory, then there was an error mapping inputs to outputs,\n"
            )
            msg.append(
                f"      multiple files and/or directories mapped to this output.\n"
            )
            console.print(" ".join(msg))
            for op in ops:
                # enable flag to make sure operations that have a directory as input will move
                # the directory _into_ the output, even if it does not exist.
                if op.input.is_dir():
                    op.enable_move_input_into_output()

    if len(errors) > 0:
        errors = (
            ["Multiple move operations produce the same output"]
            + errors
            + ["Output must be a directory if multiple move operations point to it"]
        )

    if len(errors):
        print_errors(errors)
        return 1

    if not overwrite:
        for file in outputs:
            if file not in inputs and file.exists() and not file.is_dir():
                errors.append(
                    f"Output '{file}' already exists and is not the input for another move operation. Which means it would be overwritten. If this is intentional, use --overwrite."
                )

    if len(errors):
        print_errors(errors)
        return 1

    ####################################
    console.print("Ordering move operations")
    try:
        moves.order()
    except RuntimeError as e:
        econsole.print(str(e))
        return 2
    except Exception as e:
        econsole.print("An unknown error occurred while ordering move operations: {e}")
        return 2

    console.print("Ready to perform move operations")
    for move in moves.iter_ops():
        print(f"{move.input} -> {move.output}")

    if execute:
        for move in moves.iter_ops():
            move.exec()
