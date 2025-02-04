import shutil
from pathlib import Path

import networkx


class File(Path):
    pass


class Dir(Path):
    def is_dir(self):
        return True


def make_path(f: str | Path):
    if type(f) == Path:
        # argument is a path.
        # check if the path is a directory,
        # which will only be true if it exists already.
        if f.is_dir():
            return Dir(f)
        # otherwise assume its a file.
        return File(f)

    # argument is a string.
    # check to see if the name ends with a "/" OR
    # if it is a directory that already exists.
    if str(f).endswith("/") or Path(f).is_dir():
        return Dir(f)

    return File(f)


class MoveOp:
    """
    A single move operations. A move operations consists of an input and an output.
    """

    def __init__(self, input: str | Path, output: str):
        self.__input = make_path(input)  # .absolute()
        self.__output = make_path(output)  # .absolute()
        if self.__input.is_dir() and not self.__output.is_dir():
            raise RuntimeError(
                f"Cannot move a directory ({self.__input}) to a file ({self.__output}). Did you forget a '/' at the end of the output name?"
            )

        if not self.__input.is_dir() and self.__output.is_dir():
            self.__output = self.__output / self.__input.name

    @property
    def input(self):
        return self.__input

    @property
    def output(self):
        return self.__output

    def __repr__(self):
        return f"MoveOp({self.id})"

    @property
    def id(self):
        return f"{self.input}>>{self.output}"

    def need_to_make_output_parent(self):
        if not self.__output.parent.exists():
            return True
        return False

    def exec(self):
        """
        Execute move.
        """
        if self.need_to_make_output_parent():
            self.__output.parent.mkdir(parents=True)
        shutil.move(self.__input, self.__output)


class MoveOpSet:
    def __init__(self):
        self.__ops: dict[MoveOp] = {}
        self.__graph = networkx.DiGraph()

    @property
    def graph(self):
        return self.__graph

    def add(self, op: MoveOp):
        # note: this does not check that a move operation
        # already exists in the set because if it does, it will have the
        # same id, so it won't be duplicated. there may be reasons why
        # the same operation gets added multiple times, so for now we don't
        # consider it an error.
        self.__ops[op.id] = op
        self.__graph.add_node(op)
        # if any operations have in input path that is equal to this operation's output
        # path, then this operation should be executed first and we say that those operations
        # _depend_ on this one.
        for o in self.iter_ops(lambda o: o.input == op.output):
            self.__graph.add_edge(o, op)
        # likewise, this operation will depend on any operations
        # that have an output path equal to its input path.
        for o in self.iter_ops(lambda o: o.output == op.input):
            self.__graph.add_edge(op, o)

    def exec(self):
        for op in self.iter_ops():
            op.exec()

    def iter_ops(self, cond=lambda op: True):
        """
        Return all move operations. If `cond` is given, only operations
        that return true when passed to `cond` will be returned.
        """
        for k in self.__ops:
            op = self.__ops[k]
            if cond(op):
                yield op

    def iter_ops_with_missing_input(self):
        """
        Return all move operations with an input that does not exist.
        """
        return self.iter_ops(lambda op: not op.input.exists())

    def iter_ops_with_dir_input(self):
        """
        Return all move operations that have a directory input.
        """
        return self.iter_ops(lambda op: op.input.is_dir())

    def iter_ops_with_dir_output(self):
        """
        Return all move operations that have a directory output.
        """
        return self.iter_ops(lambda op: op.output.is_dir())
