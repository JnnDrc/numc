# NUMC

The number "compiler"

numc is a colection of "compilers" that transform numbers writen in plain text
to raw data

## How to use

[base]c input.txt -o output.o -f size [8,16,32,64]\(default: 8\)

## Compile

to compile you will need zig installed

````sh
git clone https://github.com/JnnDrc/numc
cd numc
zig build
````

move the contents of zig-out/bin to your PATH to use from anywhere

## Programs

### BINC

Converts a file with plain binary numbers to a file of raw data

`binc data.mcb -o out.bin -f 16`
### DECC

Converts a file with plain binary numbers to a file of raw data

`decc data.mcd -o out.bin -f 8`
### HEXC

Converts a file with plain binary numbers to a file of raw data

`hexc data.mch -o out.bin -f 16`
### OCTC

Converts a file with plain binary numbers to a file of raw data

`octc data.mco -o out.bin -f 8`
