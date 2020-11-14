# Syntax parser with flex/bison
By Jimmy Teillard and Nicolas Atrax

* [The language](#the-language)
* [Building and launching the syntax parser](*building-and-launching-the-syntax-parser)
* [Automatic testing](#automatic-testing)

## The language
The language is a subset of the C language, defined by the grammar in `src/as.y`.\
The syntax parser is defined to follow the grammar in `src/as.l`

## Building and launching the syntax parser
Go in the `src/` directory, and launch the following commands:
```Bash
make
./as < [path_to_file]
```
where `[path_to_file]` is the file you want to analyze.\
If you want to clean the directory, launch this command:
```Bash
make clean
```

## Automatic testing
First, you need to put the files you want to test in both `test/valid` and `test/invalid`
accordingly. Files must have the `.tpc` extension to be analyzed.\
Position yourself in the `src/` and do as follow:
```Bash
chmod +x buildntest.sh
./buildntest.sh
```
