obfus-sloc
==========

My entry to the [International Obfuscated C Code Contest 2012](http://www.ioccc.org/) which did not win.

The following is the attached remarks that I submitted as part of the contest submission package.

The actual program is in one file - [prog.c](prog.c)

## Summary/ Abstract

Calculates Lines of Code (LOC) and total number of lines metrics of C/C++ source and header files similar to [CLOC](http://cloc.sourceforge.net/ "CLOC"), [SLOCCount](http://www.dwheeler.com/sloccount/ "SLOCCount") or [loc](http://freecode.com/projects/loc "loc"). This has different obfuscation from my other entry.

## License

This work (prog.c and all files, except test files with license text in them) is licensed under:

[Creative Commons Attribution-ShareAlike 3.0 Unported License](http://creativecommons.org/licenses/by-sa/3.0/ "Creative Commons Attribution-ShareAlike 3.0 Unported License")

Test files with license text in them were taken from sqlite3 and therefore, are available in the public domain.

## To build

Any of the following:

`gcc -Wall -W -ansi  -O2 prog.c -o prog`

`clang -Wall -W -ansi  -O2 prog.c -o prog`

## To run

Running without arguments will print out the decorative text (be sure to try this!) and a help message:

`./prog`

Run with the first argument as the path to a C/C++ source or header file:

`./prog filename.c`

It will produce an output in the format of:

`filename.c;100;200`

Where 100 is the Lines of Code (LOC) and 200 is the total number of lines of the file.

C/C++ source and header files with Linux, Windows and Mac end-of-line characters may be used.

## Try

The helper tool runoversrc.sh is provided to run the program over multiple files beneath a base path.

Run it like this:

`./runoversrc.sh ./prog ./src`

To save the output to a file:

`./runoversrc.sh ./prog ./src > report.csv`

The file report.csv may be opened using a spreadsheet program, with the import delimiter set to semicolons. This would be a useful code metrics report.

## Limitations

This program has only been tested on Ubuntu 12.04 32-bit x86 (with gcc and clang) and Windows XP (with mingw). It has not been tested on 64-bit platforms. However, since it is ANSI-C (C90) compliant (according to gcc and clang), it should be possible to build and run it on other platforms with minimum porting.

The LOC calculation algorithm does not consider trigraphs.

## Remarks

### Usefulness and Performance

This program runs with the speed and results accuracy comparable to leading open source tools such as [CLOC](http://cloc.sourceforge.net/ "CLOC"), despite obfuscation. It is also very portable, and may be used to produce code metrics reports. Hence, this program is useful in the real world.

The use of the Lines of Code (LOC) metric in a software development project is described in [this page](http://en.wikipedia.org/wiki/Source_lines_of_code "Source_lines_of_code").

### LOC algorithm considerations

The calculation of LOC for a C/C++ source or header file excludes:

* Lines which contain comments only (`/**/` and `//`)
* Empty lines (with only a newline character or EOF)
* Lines with only spaces or tabs

It must also consider the following:

* Comment characters inside double quotes and single quotes should be ignored e.g. `"/** // **/"`
* Escape sequences inside double quotes and single quotes should be considered
* Different line-endings for Linux, Windows and Mac (LF, CRLF, CR)
* Multi-line strings and macros
* The last line (with End-Of-File) but no newline character should not be missed out

### Dedication

The code contains a decorative string which includes a dedication to the late Dennis Ritchie, co-inventor of C and Unix. This string is printed out as part of the help message when the program is run without arguments. It is also readable from the source.

Well, I needed some kind of entertainment value in the program, since counting LOC is a rather boring task. And furthermore, I feel Dennis Ritchie's passing was overshadowed by Steve Jobs and he deserves more attention for his contribution to C and Unix, and after all, this contest is about obfuscation in C (preferably built on POSIX systems) and this program is about C code.

## Obfuscation

There are (at least) 3 levels of obfuscation:

### Level 1 Obfuscation

This file includes itself! Isn't that clever?

Yes, I know that a C preprocessor and code beautifer can remove the mystery behind it.

But still! Isn't it really clever? A file within a file.

The main file's macros implement functions and the included version of the file would use the same macros to generate an array of function pointers.

Apart from that, the variable names and macros are meant to be confusing.

### Level 2 Obfuscation

The use of ternary operators, operator precedence, funky pointer arithmetics, redundant use of assignment (`x=0;x|=d` is `x=d`), redundant boolean comparison (`x && 1` is `x`) and useless sequences that would be optimized out by the compiler (for e.g. `'x'/'('-' '-' '-' '` is the same as `-']'` i.e. each ASCII character is a number and operations can be done on them, also bit-shifting for multiplication or division by 2,4,8... , modulo etc).

The reader should be able to manually reduce these by hand and convert the pointer arithmetics to array accesses.

But even after this, the LOC calculation algorithm is still not visible!

HINT: It's hidden in plain sight both to the reader of the code and the user of the program.

### Level 3 Obfuscation (spoiler alert!)

The C code is not a LOC calculation program. It's actually a tiny virtual machine. The characters in the decorative string is actually its bytecode. A bytecode sequence is composed of a one-byte opcode and a one-byte operand. So, the decorative string is not really for decoration only. It's actually the program that contains the LOC calculation algorithm. A program within a program.

In cases where the opcode does not need an operand, the operand is a random character generated within a certain range. Invalid opcodes are used as nops. The dedication strings are also embedded into the bytecode. The bytecode program tries its best to jump over the dedication strings wherever possible. Some unused randomly generated opcodes and operands are added to the end of the bytecode program to pad it, to complete the border for the decorative string. The values used for opcode and operand are within the printable range below ASCII 128 and should not require escape sequences in C strings.

Obfuscation theme: A file within a file. A program within a program.
So, it's like the [Inception](http://www.rottentomatoes.com/m/inception/ "Inception") (a dream within a dream) version of obfuscation.

The reader is challenged to try to disassemble the bytecode program. ;-)

