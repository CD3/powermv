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


def make_operations_set(pattern, template, files):
    matcher = RegexMatcher(pattern)
    renderer = Jinja2Renderer(template)
    moves = MoveOpSet()
    for file in files:
        ctx = matcher.get_match_tokens(str(file))
        if ctx is None:
            continue

        outfile = renderer.render(ctx)

        op = MoveOp(file, outfile)
        moves.add(op)

    return moves


@app.default
def main(
    pattern: str,
    template: str,
    files: list[pathlib.Path],
    /,
    execute: Annotated[bool, cyclopts.Parameter(name=["--execute", "-x"])] = False,
    # overwrite: Annotated[bool, cyclopts.Parameter(name=["--overwrite", "-x"])] = False,
    quiet: bool = False,
):
    """
    Batch move files with the power of jinja2 templates.

    With great power comes great responsibility...

    Parameters
    ----------

    pattern
        Pattern to match input filenames against.
    template
        Jinja2 template to render output filename with.
    execute
        Execute move operations (by default, nothing is moved, only a dry-run is performed).
    overwrite
        Proceed with executing operations even if they would overwrite existing files.
    quiet
        Don't print status information.
    """

    console = rich.console.Console(stderr=False, quiet=quiet)
    econsole = rich.console.Console(stderr=True)

    console.print("Building move operations set")
    try:
        moves = make_operations_set(pattern, template, sorted(set(files)))
    except RuntimeError as e:
        econsole.print(f"{e}")
        return 1
    except Exception as e:
        econsole.print(
            f"An unknown error occured while building the move operation set"
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
            errors.append(f"Output: {op.output}")
            for _op in moves.iter_ops(lambda o: o.output == file):
                errors.append(f"  {_op.input} -> {_op.output}")
        else:
            ops = list(moves.iter_ops(lambda o: o.output == file))
            console.print(
                f"NOTE: '{file}' is a directory that is given as the output for {len(ops)} move operations. It is assumed that you want to move all inputs (including directores) into this directory."
            )
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
