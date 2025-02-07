list:
    just --list

run-pytest-tests *args:
    uv run pytest {{args}}

run-cram-tests:
    uv run cram tests/cram/*t

test: run-pytest-tests run-cram-tests

build-examples:
  uv run cram -i -y doc/examples/*.t

build-readme:
   compudoc README.md.cd --comment-line-pattern="<!--{{{{CODE}}-->"
