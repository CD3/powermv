import pathlib

from unittest_utils import working_dir

from powermv.operations import *


def test_construct(tmp_path):
    with working_dir(tmp_path):
        m1 = MoveOp("file-1.txt", "file-2.txt")
        m2 = MoveOp("file-1.log", "mydir/")
        m3 = MoveOp("dir1/", "new-dir/")

        moves = MoveOpSet()
        moves.add(m1)
        moves.add(m2)
        moves.add(m3)

        ops = list(moves.iter_ops_with_missing_input())
        assert m1 in ops
        assert m2 in ops
        assert m3 in ops

        ops = list(moves.iter_ops_with_dir_input())
        assert m1 not in ops
        assert m2 not in ops
        assert m3 in ops

        ops = list(moves.iter_ops_with_dir_output())
        assert m1 not in ops
        assert m2 in ops
        assert m3 in ops

        m1.input.write_text("file-1.txt")
        m2.input.write_text("file-1.log")
        m3.input.mkdir()
        (m3.input / "file.txt").write_text("dir1/")

        moves.exec()

        assert Path("file-2.txt").exists()
        assert Path("file-2.txt").is_file()
        assert Path("file-2.txt").read_text() == "file-1.txt"

        assert Path("file-2.txt").exists()
        assert Path("file-2.txt").is_file()
        assert Path("file-2.txt").read_text() == "file-1.txt"


