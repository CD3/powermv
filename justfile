list:
    just --list

run-pytest-tests *args:
    uv run pytest {{args}}

run-cram-tests:
    uv run cram tests/cram/*t

test: run-pytest-tests run-cram-tests
