# C_dataDemo
#### A quick primer on manipulating integer data C

So I came to the pedagogical realization that giving you a book on C for UNIX 
and letting you wander into the frightening land that is C programming for 
embedded systems (without telling you how they were different) was a bit 
irresponsible.  Hopefully this C demo, complete with example code that you 
should be able to run on your machine, will give you a bit of a jump start with 
what is going on.

---

### C in Embedded Systems vs C in Computers

Okay so technically an embedded system is a computer, but it is far simpler 
than the computers you are used to (like the one you are sitting in front of 
now).  A desktop or laptop computer is a general purpose computer capable of 
running a variety of applications at one time.  It has an operating system that 
divides up resources between multiple processes, several gigabytes of 
memory, and usually multiple processors running at a few billion clock cycles 
per second.

The flexibility of a desktop or laptop computer comes with notable power use 
and weight.  However, say we needed a computer that did one fairly simple task: 
there is no need for interface devices like a mouse, keyboard, or monitor; 
nanosecond execution times are excessive and pointless; we have a 180 kg mass 
limit; and our only power comes from side-mounted solar panels, most of which is 
funneled into a thruster.

Enter the microprocessor as an embedded system.

Microprocessors are incredibly ubiquitous in most modern applications, from 
cars to washing machines to toasters. (Yes, [toasters](http://cache.freescale.com/files/microcontrollers/doc/app_note/AN3414.pdf).  
I guess it must control for crispiness or turn off near bathtubs or something).
The point being that a microprocessor is a small, lightweight, low-power 
computer  perfectly suited for doing simple and straightforward computer things;
providing just enough computing power a well defined task.  Like your laptop, a 
microprocessor is a computer, that is it broadly uses the same system 
architecture with a processor, memory, and a primitive IO; 
most importantly, it can be 
programed with a (relatively) high level language like C.  What you can do with 
C will be limited by the functions of the microprocessor (I once worked with a 
microprocessor that couldn't multiply unless you got really creative),
but overall the control flow and structure of your C program can be translated
to work on your microprocessor just the same as with your laptop.

### Wait what is C?

```
  C is a general-purpose programming language which features 
  economy of expression, modern control flow and data 
  strucutres, and a rich set of operators.  C is not a "very
  high level" language, nor a "big" one, and it is not specalized
  to any particular area of application.  But its absence of
  restructions and its generality make it convenient and effective
  for many tasks than supposedly more powerful languages.
```

Most every modern computer stores programs as *machine code*, basically a series 
of bytes stored on a disk or flash memory that tells the processor hardware what 
to do.  You can program in machine code if you have a few hours, know the 
instruction set architecture, and need to atone for some sin against computers.
While the early computer pioneers used machine code to program, they quickly 
invented *assembly code* to make their jobs a bit easier.  Honestly, assembly is
practically a direct translation of machine code, but it has just enough words 
that you can make sense of it with enough training.  A sample (that was
generated using a compiler) is given in `arrayDemo.s`.

The problem with assembly code is that it is specific to the computer you are 
using.  `arrayDemo.s` was created for an Intel processor with the dreaded x86 
architecture and is meaningless to any other computer using a different 
architecture.  Also because assembly interacts directly with the hardware, 
the nice for loops, if statements, and functional decomposition that make 
programming easy have to be accomplished by telling the chip to jump around in 
the program's memory.

The only reason one would ever program in assembly is for super low level 
functions, super fast program execution, pedagogy, or self loathing.  The next 
jump then is to a high level language that is *portable* (can be read by 
different computers with different architectures) and provides a level of 
*abstraction* to simplify the task of programming (we don't have to worry about
details of our processor's registers, program heaps, and memory call protocols).
C is high level enough to offer portability and abstraction; however, C offers
enough low level functionality to make it useful for low level applications 
such as microprocessor or  operating system programing.

The story is that Brian Kernighan and Dennis Ritchie were building an operating 
system called UNIX in 1972.  They had assembly code and a high level language 
called B.  B wasn't quite working on the computer where they were building UNIX,
so they created C to make their work simpler.  UNIX was a bit of a side project
and was made available for free in the US.  UNIX  became fairly popular and C 
proliferated with it.

When you write a program in C, you write it as a human readable text file.  
This text file is completely meaningless to the hardware of your computer or any
machine.  To create an *executable* file
you must run a *compiler* that will translate C code into the
machine code that a computer can make sense of.  Specific architectures will 
have specific compilers, so the compiler you use to create executables on your 
computer will likely be different from the compiler used to build an executable
for your microprocessor.  Now, you will likely be programming your 
microprocessor using an specialized text editor called an IDE which will 
pre-compile, compile, assemble, link, and run your program with you just 
clicking a "play" button.  Theoretically, you will never need to worry about the
compiler, however, knowing that your C code must be translated to device
specific machine code before it is useful to that device will help you 
understand what is going on behind the scenes.

C for microprocessors will be distinct from C for desktops in that you will need
to use device specific libraries to access its particular functions.  Functions
like `printf()` and `read()` that require operating system calls probably won't
work for your microprocessor (microprocessors usually don't have operating 
systems).

### C programming basics

Let us start diving into the code with the file `demo.c`.  Lines 1 and 2 
contain the library and headers (more on these later), lines 5 through 11 
contain a comment surrounded by the "slash star" characters `/* ... */` which 
the compiler simply ignores, and at line 12 we reach the `int main()` function. 
```c
int main(){
	helloWorld();
	printSizes();
	intDemo();
	arrayDemo();
	return 0;
}
```
Software is sequential, meaning the computer will execute one instruction at a 
time in a specific order; for C this is the first line in the `main()` 
function.  Which in this case is another function call but don't worry about 
that yet.  Every C program must have a `main` function.  `int` indicates that 
the function will return an integer which is accomplished with `return 0;`.  
This integer is usually used to indicate something to the process that called 
the program.  This is usually a 0 and anything else is usually regarded as an 
error.  Your embedded system probably won't use this, but you will see it while
studying C.

The first line in `main()` is a function call to `helloWorld()` on lines 20 to 
22.
```c
void helloWorld(){
	printf("Hello Wolrd!\n");
}
```
`helloWorld()` is traditionally your first program, it prints "Hello World" to 
the console.  `void` indicates that the function returns nothing, that is gives 
no value to the function that called it, it simply executes code.  In this case 
the code is a call to a function `printf()`.  `printf()` is not defined in any 
of the code written in this project so don't start looking.  Remember the 
library declaration on line 1 `#include <stdio.h>`?  This line imported a header
(code that is basically pasted to the top of the file) that defines the IO 
functions for the operating system, including `printf()` which writes to the 
console.  Notice that because this function is a `void` there is no `return` 
statement.

In the program output, the console will print `Hello World!`.  The character
`'\n'` prints a new line.  I built this on a UNIX VM, for a windows machine you 
will need to use the characters `\n\r`, it is just a difference between
operating systems. 

### Data Types

One of the things I love about C is that everything is bits.  We choose to read
those bits as characters, decimal numbers, or hexadecimal, but at the end of the
day C will allow you to do bitwise operations on `char`s, `int`s, `short`, and 
`long`.  The main difference between these data types is their size in bytes 
(8 bits = 1 byte).  The function `printSizes()` displays the number of bytes 
that make up each of these data types.  Unfortunately, these sizes often vary 
between machines and processors so after you compile and run the code you may 
see different numbers from what I got.

| Data Type | Size (bytes) |
| :-------- | -----------: |
| char   | 1 |
| int    | 4 |
| short  | 2 |
| long   | 8 |
| float  | 4 |
| double | 8 |
	
`float` and `double` are how C stores fractional or floating point numbers. 
They do not translate directly or simply to binary code and thus you cannot use
bitwise operators on them, but are useful for things like control systems.  

#### A Note on Hexadecimal

Fundamentally, a computer stores, receives, transmits, and reads binary data.  
However, to say that a computer stores hexadecimal numbers isn't exactly wrong.
Hexadecimal maps groups of 4 bits to a single character which makes it much 
easier for a person to ready and ultimately type as code.  The computer does not
store a hexadecimal number in the sense that `0x12AB` is written to memory as a
`1` and `B` characters.  Rather those characters are sequences of bits like 
`0001` and `1011` which map to `1` and `B` respectively.  When we ask the 
computer to retrieve the number, the computer translates the data to whatever 
format that we want.  We can represent the number as hexadecimal, decimal, or 
even octal.  We can write code for "is integer `a` equal to 15?" using a 
hexadecimal number `(a == 0x0F)` or using a decimal number `(a == 15)`.  The 
`0x` indicates to the computer that the programmer is writing a hexadecimal 
number.

### Working with Integers

The next function call in `main()` is `intDemo()` which I created to show how
you would manipulate information that may be given as a complete integer.  You
will receive some sort of input from an external device, it will be most likely
be stored as a binary value, but I am less certain about the data type (the 
size in bytes of your data) that the microprocessor will provide.  An integer
is unlikely, however understanding how data is stored as an integer and how to 
manipulate smaller units of data within the integer will be an important tool.

#### Representing an Integer

Lines 9 through 14 print out different representations of an integer.  The 
console prints the integer in different formats indicated by the `%` tags.  
There is a call to a function called `intToBin()` which converts an 
integer to a string of binary characters; don't worry about how that function 
works for now just know that there is no native way to produce a bunch of binary
digits.  

Hexadecimal, like I said before, is simply a mapping of bits to characters. 
Hexadecimal most easily translates to bits and is the most compact
representation of bits.

Decimal numbers, both signed and unsigned, represent bits as a base 10 number 
comfortably read by humans.  You will notice that the signed number is negative
while the unsigned number is positive.  By default C treats integers as signed, 
or two's complement, numbers.  There is some math behind the encoding of these 
numbers but suffice to say that signed numbers can be read as negative or 
positive and the easy way to tell the difference is that the first bit 
determines the sign of the number.  Because `0xD` is encoded as `1101` the our 
number is negative when read as a signed number.  An unsigned number takes the
same data but does not treat it as a two's complement; unsigned numbers can
only be positive.  Remember that this is the same data, but the computer is 
interpreting it differently.  Signed and unsigned numbers actually use the same
arithmetic functions for addition and subtraction, the computer or programmer
simply has to interpret the result as signed or unsigned.  For logical bitwise 
operators, and `&`, or `|`, and xor `^` 
there is no difference between signed and unsigned
numbers because these operate on the data as binary information.  There is
some difference with the bit shift operators `>>` and `<<`, my best advice is
to declare or cast the variable as an `unsigned int` before using those 
operators.

Octal numbers are sets of three binary digits mapped to a character (0 through 
7) in stead of the four binary digits used for hexadecimal.  You probably won't
use this for many applications but know that it exists.

The binary representation takes the 4 bytes of an integer and maps it to 
32 bits.  You will notice that the binary string is backwards, that is the
least significant bit is the leftmost position and the most significant bit
is in the rightmost position contrary to how you usually read a number.  
This order is more representative to how you would see information laid out in
little-endian memory systems, and in C array indexing, where higher order bits
or array values are in higher value memory addresses.

#### Bit Masking

Oftentimes with embedded systems we have limited amount of memory and therefore
attempt to cram as much data together as possible.  Say we have two pieces of 
data that are each four bits long and our word size is eight bits.  In a desktop
computer we can comfortably assign each of these values to a full 8 bit `char`
or even a 4 byte `int` and not worry about the demand on the system.  For 
microprocessors it is often advantageous to store both 4 bit values in one 8-bit
`char`.  Bit masking uses __bitwise__ logical operators to manipulate 
segments of data that are smaller than the minimum data size in C.

##### Bitwise Versus Logical Operators

So C has no data type that represents a boolean true and false, what C does is 
it treats a `0` value as **FALSE** and any nonzero value as **TRUE**.  So the 
code `(3 > 9)` is read by C as a `0` and `(3 < 9)` as `1` (1 is a fairly common
default for a nonzero value).  These are referred to as *logical* values and
the logical operators like *logical and* `&&`, *logical not* `!`,
and *logical or* `||` will 
perform boolean operations on the integer as a whole; `(a > 7 && a <= 16)`.

In contrast, **bitwise** operators perform logical operations on each bit in
an integer.  Logical operators use the double symbol while **bitwise operators
use a single symbol**.  (Using a logical operator in place of a bitwise 
operator will drive you to insanity looking for an error).  *Bitwise and* is 
`&`, *bitwise or* is `|`, *bitwise xor* is '^', and *bitwise not* is '~'. 

```c
char a, b;
char n, o, p, q;

a = 0x17; 		// binary 0001 0111
b = 0x3E; 		// binary 0011 1110

n = a & b; // n = 0x18 or 0001 0110 
o = a | b; // n = 0x3F or 0011 1111
p = a ^ b; // n = 0x29 or 0010 1001
q = ~a;	   // n = 0xE8 or 1110 1000
```

##### Bit Masking Examples

The function `intDemo()` defines three bit masks that isolate different
parts of the integer `0xDFEC1234`.  The most common mask uses the hexadecimal
digit `0xF` because it represents a block of four `1`s.  Masking is done by 
performing a bitwise and with the data you wish to mask and a mask integer 
(the mask must be the same size as your data) with the bits you wish to mask 
set to `1`.  Another way to look at bit masking is that any mask bit set to 
`0` will set the corresponding bit in the result of the mask to zero.

The first example masks the center bits of `0xDFEC1234`.
```
Mask:	0000 0000 0000 1111 1111 0000 0000 0000
Data:	1101 1111 1110 1100 0001 0010 0011 0100
     &------------------------------------------
Result:	0000 0000 0000 1100 0001 0000 0000 0000
```
The bit mask kept the 8 bits in the center and set ever other bit to `0`.


Bit making allows us to only look at certain bits while temporarily disregarding
the other bits.  Say we wanted to test if the first 16 bits of this integer 
were `0xDFEC`, we can "mask out" the 16 least significant bits.
```c
int a = 0xDFEC1234;

if(a & 0xFFFF0000 == 0xDFEC0000)
	printf("True\n");
```
A slightly more elegant version takes advantage of the bitwise not to simplify
the mask and remove 
the extraneous zeros.
```c
int a = 0xDFEC1234;

if(a & ~0xFFFF == 0xDFEC0000)
	printf("True\n");
```

##### Changing Bits

Because we often cram several pieces of data into larger data type the ability
to set, clear, and toggle individual bits within an integer is useful for 
data processing.

Setting bits guarantees that bits are set to `1`.  This is accomplished using
a logical or, `|`, and a mask of the bits you want to set set to `1`.
```c
int a = 0xDFEC1234;

a |= ~0xFFFF;
// a = 0xFFFF1234
```
(Operators followed by an equals sign follow the form `a += b` -> `a = a + b`)

Clearing bits guarantees that bits are set to `0`.  This is accomplished using
a bitwise and with a mask with the bits you want cleared set to zero
```c
int a = 0xDFEC1234;

a &= ~0xFFFF
// a = 0xDFEC0000
```
This process is the same as the "bit masking" in the previous section.

Toggling bits switches the selected bits from `0` to `1` or from `1` to `0`. 
This is done using the bitwise xor with a mask of the bits you want toggled set
to `1`.
```c
int a = 0xDFEC1234;

a ^= ~0xFFFF;
// a = 0x20131234
```

#### Arrays

The last section of code in `main()` calls `arrayDemo()`. The most common IO 
interface in C is an array of bytes or an array of `char`s.  An array in C is
a sequence of data values set sequentially in memory.  Practically, it provides
a way of storing data in an arbitrary number of bytes.  

`arrayDemo()` creates an array of type `char` (each array element is 1 byte 
long) containing 5 elements.  (`DATA_BYTES` is "defined" as 5 in the file
demo.h; I will cover this in the next section).
Note that there is not native data type in C that is 5 bytes long.
```c
char arrayData[5] = {
	0x01, 0x02, 0x33, 0xDF, 0xEC};
```

Arrays don't need to be initialized (set to specific values) when they are 
declared (telling the compiler to allocate the memory) as it is here.  Equally
valid syntaxes are:
```c
char array1[] = {
	0x01, 0x02, 0x33, 0xDF, 0xEC};

char array2[5];
array2[0] = 0x01;
array2[1] = 0x02;
array2[2] = 0x33;
array2[3] = 0xDF;
array2[4] = 0xEC;
```

The initialization of `array2` highlights how to access individual members of
an array using the `[x]` syntax.  There are more complicated ways to access
arrays called *pointers* and are shown by the `*` operator; we won't cover
pointers in this document but the conversion is possible.  Accessing 
members of an array with integer indexes allows us to use a `for` loop
to iterate through the values fairly easily.  Also note that **array indexes in
C start with 0**, this is distinct from MATLAB where indexes start at 1. 

##### Testing Individual Bits

Lines 17 and 18 demonstrate testing individual bits using bitwise operators.
Oftentimes a `char` will be designated as *flag bits* and we want to see if 
a flag is raised, set to `1`.  Values like `BIT7` are defined in demo.h, we will
get there in a minute, to have only one bit set in a specifc position.  the code
`a & BIT3` will return `0x00` if the bit at index 3 (fourth least significant
bit) is cleared to `0`, and `0x08` if that bit is set to `1`.  Remember that
for logical boolean values, `0` maps to false and anything else maps to 
ture.  So abbreviated code like this is valid:
```c
#define BIT3 0x08

char flags = 0x6A; // 0110 1010

// We are interest if bit 3 is set
if(flags & BIT3)
	printf("Bit 3 is set\n");

// To see if bit 3 is cleared
if(!(flags & BIT3))
	printf("Bit 3 is cleared\n");
```

#### Programming Notes for C

One of a computer programmer's tools is the ability to break a program down
into logical blocks of code called functions.  It is often easier to separate 
related functions into their own files to make things easy to work on.
While the compiler can easily link files together during compilation, there
is common code often needed by all the files that is defined in a header or
`.h` file.

##### The Pre-compiler

Header files contain mostly type definitions and pre-compiler commands which
are prefaced by an octothorpe  `#`.  The pre-compiler's main job is to simply 
paste text into a file.  `#include` effectively "pastes" a header file
into the top of your program, which allows you to access all the functions
defined in that specific header and associated libraries.  A pre-compiled
C file is given in `arrayDemoPC.c`.

The other important pre-compiler command is `#define` which replaces one block
of text with another.  We usually don't want to put straight numbers into
our code because it is difficult to read and if we use the number several times
we have to change every applicable reference to that number.  Usually the 
solution is to declare a variable and use that variable throughout the program,
but it adds an extra variable to your system.  `#define` is commonly used to 
paste a number into a specific tag (by convention the tag is all capital 
letters) without declaring a variable.

Consider the following two blocks of code:
```c
char readBuffer[4096];

int i;
for(i = 0; i < 4096; i++)
	readBuffer[i] = 0x0;
```
Changing the buffer size here requires changing `4096` twice in the code, and
if the array declaration and for loop are far apart we can have all sorts of
errors emerge if only one is changed.
```c
#define BUFFER_SIZE 4096

char readBuffer[BUFFER_SIZE];

int i;
for(i = 0; i < BUFFER_SIZE; i++)
	readBuffer[i] = 0x0;
```
We now only have to change one line of code.  Also if `BUFFER_SIZE` were defined
in a header file, we could standardize the buffer size in all our code files.

#### Conclusion

Well, I hope this helps.  Remember the two reference books that are good for C
are *The C Programming Langguage* by Brian Kernighan and Dennis Ritchie, and 
Appendix C in *Digital Desin and COmputer Architecture* by Harris and Harris.
Both these books are available on Safari books.
