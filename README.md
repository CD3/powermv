# A powerful renaming utility

`powermv` has goals similar to

- [rnr](https://github.com/ismaelgv/rnr)
- [nomino](https://github.com/yaa110/nomino)
- [brename](https://github.com/shenwei356/brename)
- [rename](https://metacpan.org/pod/rename)
- [rnm](https://github.com/neurobin/rnm)

Of these utilities, I have used `rename` the most, and recently started using `rnr`.
Both tools are nice and work for 99% of my use cases. However, there is one specfic use
case that I occationally have when working with files created by/for some physics
simulation or demos for [Phys 312
class](https://hostcat.fhsu.edu/cdclark/website.fcgi/classes/Phys_312), and that is
batch renaming with increment/decrement of integers in the filename. For example, say
I have some demo files:

```bash
$ ls
01-text_files.sh
02-text_editors.sh
03-file_redirection.sh
```

I have these files named so that they will be loaded (by my [pygsc](https://github.com/CD3/pygsc) utility)
in order. Now say I want to add a demo at the beginning of the tutorial for some
preliminary stuff. I create a filed named `01-preliminaries.sh`. But before I do, I
would like to rename all of the existing scripts to increment their index:

```bash
01-text_files.sh       -> 02-text_files.sh
02-text_editors.sh     -> 03-text_editors.sh
03-file_redirection.sh -> 04-file_redirection.sh
```

I would like to have way to do this rename automatically. There are some tools (like
[ranger](https://github.com/ranger/ranger)) that allow you to do batch renaming and edit
the file rename operations in a text file, so you can use vim's ctl-a and ctl-x to help
do the rename quickly. However, there are some situations that you need to be careful
with.

Let say I have a set of enumerated input configuration files.

```bash
$ ls
config-01.yml
config-02.yml
config-03.yml
config-04.yml
config-05.yml
```

If I want to rename these to

```bash
$ ls
config-02.yml
config-03.yml
config-04.yml
config-05.yml
config-06.yml
```

there is a possibility that I will accidentally delete files. If `config-01.yml` gets
renamed to `config-02.yml` _first_, then when `config-02.yml` is renamed to
`config-03.yml`, it will actually be a copy of the original `config-01.yml`. If all
operations go in order, you will end up with one file.

```bash
$ ls
config-06.yml
```

where the contents of `config-06.yml` will be the contents of the original
`config-01.yml`. Clearly not what was intended.

PowerMv aims to address these problems and make file renaming with
incremented/decremented enumeration indecies possible and easy.

## Install

You can install PowerMv with `pip`, `pipx`, or `uv`

```bash
$ pip install powermv
```

```bash
$ pipx install powermv
```

```bash
$ uv tool install powermv
```

## Usage
