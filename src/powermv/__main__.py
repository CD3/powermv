import importlib.metadata
import pathlib
import sys
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
    moves = make_operations_set(pattern, template, files)

    ##########ERROR DETECTION###########
    console.print("Analyzing move operations set")
    issues = []
    inputs = {}
    outputs = {}
    for op in moves.iter_ops():
        if op.input not in inputs:
            inputs[op.input] = 0
        if op.output not in outputs:
            outputs[op.output] = 0
        inputs[op.input] += 1
        outputs[op.output] += 1
    for input in inputs:
        if not input.exists():
            issues.append(f"Input '{input}' does not exist.")
        if inputs[input] > 1:
            issues.append(
                f"Input '{input}' appears multiple times with different outputs."
            )
            for op in moves.iter_ops(lambda o: o.input == input):
                issues.append(f"  '{op.input}' -> '{op.output}'.")

    if len(issues) > 0:
        econsole.print("Errors detected with move set.")
        for issue in issues:
            econsole.print(f"  {issue}")

        return 1

    for output in outputs:
        if output.exists():
            if output not in inputs:
                issues.append(
                    f"Output '{output}' exists and is not an input that will be moved, so this file would be overwritten. Use --overwrite to overwrite."
                )

    if len(issues) > 0:
        econsole.print("Errors detected with move set.")
        for issue in issues:
            econsole.print(f"  {issue}")

        return 1

    ####################################

    console.print("Ready to perform move operations")
    for move in moves.iter_ops():
        print(f"{move.input} -> {move.output}")

    if execute:
        for move in moves.iter_ops():
            move.exec()
