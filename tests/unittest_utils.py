import contextlib
import os


@contextlib.contextmanager
def working_dir(path):
    old_path = os.getcwd()
    os.chdir(path)
    try:
        yield
    finally:
        os.chdir(old_path)
