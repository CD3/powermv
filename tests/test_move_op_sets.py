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


def test_graph(tmp_path):
    m1 = MoveOp("file-1.txt", "file-2.txt")
    m2 = MoveOp("file-2.txt", "file-3.txt")
    m3 = MoveOp("file-3.txt", "file-4.txt")

    moves = MoveOpSet()
    moves.add(m1)
    moves.add(m2)
    moves.add(m3)

    graph = moves.graph
    assert len(graph.edges) == 2
    assert len(list(networkx.simple_cycles(graph))) == 0

    m4 = MoveOp("file-4.txt", "file-1.txt")
    moves.add(m4)

    assert len(graph.edges) == 4
    assert len(list(networkx.simple_cycles(graph))) == 1

    for cycle in networkx.simple_cycles(graph):
        print(cycle)
        print(list(graph.successors(cycle[0])))
