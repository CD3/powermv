import importlib.metadata
import pathlib
import sys

import cyclopts
import rich.console

__version__ = importlib.metadata.version("powermv")

app = cyclopts.App(
    name="powermv",
    version=__version__,
)


@app.default
def main(
    pattern: str,
    template: str,
    file: list[pathlib.Path] = [],
    /,
    execute: bool = False,
    overwrite: bool = False,
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
    """
