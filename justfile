list:
    just --list

run-pytest-tests *args:
    uv run pytest {{args}}

run-cram-tests *args:
    uv run cram tests/cram/*t {{args}}

test: run-pytest-tests run-cram-tests

build-examples:
  uv run cram -i -y doc/examples/*.t

build-readme: build-examples
   compudoc README.md.cd --comment-line-pattern="<!--{{{{CODE}}-->"
   pandoc README.md -o README.pdf

publish:
   rm dist -r
   uv build
   uv publish
