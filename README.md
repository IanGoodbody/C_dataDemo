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

Fundamentally, a computer sotores, receives, transmits, and reads bits.  However, to say that a comptuer strores hexidecimal numbers is only half wrong.  Hexidecimal maps groups of 4 bits to a single charcter, which makes it much easier for a person to ready and ultimatley type into code file.  The computer does not store hexidecimal number in the sense that with `0x12AB` there is no `1` or `B` printed onto the disk or memory, rather they are bit strings like `0001` and `1011` which map to `1` and `B` respectively.  When we ask the computer the number is, the computer translates the data to a format that we want so we can read it as hexidecimal, decimal, or even octal, but that does not change the fact that we can perform bitwise `and`, `or`, or `not` operations on those numbers when we need to.

### Working with Integers


