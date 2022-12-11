# Word Count
Implementation of word-count program in Nim, by Jakob Friedl.

This programm takes in a starting directory and a file extension as arguments. The directory is then recursively traversed and all words of files with the supplied extension are counted. The ordered output is then written to `out.txt`

## Dependencies

Install Nim
```sh
curl https://nim-lang.org/choosenim/init.sh -sSf | sh
```

## Usage

```sh
nim c -r wordcount.nim <directory> <extension>
```
