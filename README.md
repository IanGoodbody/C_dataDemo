# C_dataDemo
#### A quick primer on manipulating integer data C

So I came to the pedigogical realization that giving you a book on C for UNIX and letting you wander into the frightening land that is C programming for embedded systems without telling you how they were different was a bit irresponsible.  Hopefully this C demo, complete with example code that you should be able to run on your machine, will give you a bit of a jump start with what is going on.

---

### C in Embedded Systems vs C in Computers

Ok so technically an embedded system is a computer, but it is far simpler than the computers you are used to (like the one you are sitting in front of now).  A desktop or laptop computer is a general purpose computer capable of running a variety of applications at one time.  It has an operating system that divides up resources between multiple programs, usually several gigabytes of memory, and usually several processors running at a few billion clock cycles per second.

The flexability of a desktop or laptop computer comes with notable power use and weight.  However, say we needed a computer that did one fairly simple task: no interface devices like a mouse, keyboard, or monitor to worry about; nanosecond execution times are excessive and pointless; and we have a 180 kg mass limit with power coming from side-mounted solar panels that we have to dump into a thruster.

Enter the microprocessor/embedded system.

Microprocessors are increadibly ubiqutous, from cars to washing machines to toasters. (Yes, [toasters](http://cache.freescale.com/files/microcontrollers/doc/app_note/AN3414.pdf).  I guess it must control for crispiness or turn off near bathtubs or something).  The point being that a microprocessor is a small, lightweight, low-power comptuer perfectly suited for doing simple and straightforward comptuer things; providing just enough computing power a well defined task.  Like your laptop a microprocessor is a computer, that is it broadly uses the same system architecutre with a processor, memory, and IO; most importantly, it can be programed with a (relatively) high level language like C.  What you can do with C will be limited by the functions of the microprocessor (I once worked with a TI MSP430 microprocessor that couldn't multiply unless you got really creative), but overall the structure and functionality of C will work on a microprocessor just the same as with your laptop.

### Wait what is C?

```
  C is a general-purpose programming language which features 
  economy of expression, modern control flow and data 
  strucutres, and a rich set of operators.  C is not a "very
  high level language, nor a "big" one, and it is not specalized
  to any particular area of application.  But its absence of
  restructions and its generality make it convenient and effective
  for many tasks than supposedly more powerful languages.
```

Most every moden computer stores programs as *machine code*, basically a series of bits stored on a disk or flash memory that tells the processor hardware what to do.  You can program in machine code if you have a few extra hours, know the instruction set architecture, and need to atone for some sin against computers.  While the early pioneers used machine code to program, they quickly invented *assembly code* to make their jobs a bit easier.  Honestly, assembly is practically a direct translation of machine code, but it has just enough words that you can make sense of it with enough training.  A sample is given in `arrayDemo.s`.

The problem with assembly code is that it is specific to the computer you are using.  `arrayDemo.s` was created for an Intel processor with the dreaded x86 architecture and is meaningless to any other computer using a different architecture.  Also because assembly interacts directly with the hardware, the nice loops, branches, and functions that make programming easy have to be accomplished by telling the chip to jump around in the program's memory.

The only reason one would ever program in assembly is for super low level functions, super fast program execution, pedagogy, or self loathing.  The next jump then is to a high level language where you can easy visualize and write high level programing structures and allow a comptuer program, called a compiler, to build assembly and machine code programs for you.  Enter C.

The story is that Brian Kernighan and Dennis Ritchie were building an operating system called UNIX in 1972.  They had assembly code and a high level langauge called B.  B wasn't quite working for the computer they were building UNIX for, so they created C to make thier lives simpler.  UNIX is a free operating system and became fairly popular and C proliferated with it.  The advantage to C is that it is very simple (compared to the DoD's Ada which is still popular in Europe), provides a good abstraction of programming functionality, and it is portable.  C is not too far removed from the most common assembly instructions on most every chip, and thus can be easily compiled into most any version of assembly for most any microprocessor.

Here is what it comes down to.  Processors for desktops and laptops and microprocessors for embeded systems are both computers but have different sets of instructions to run their specific computer hardware.  C is a fairly simple way to define a program (a .c file is only text and cannot be run on its own) which can be translated into assembly code for most any chip as long as a compiler exists for that specific system.

C in microcontrollers will be unique in that you must use libraries specific to the microcontroller to access it's specific hardware, say outputing a signal to a pin rather than to a monitor.  For loops and if statemnets will all function the same however, so as long as you grasp how to use a program to solve a problem adapting to the new semantics is fairly easy.

### C programming basics

Let us start diving into the code with the file `demo.c`.  Lines 1 and 2 contain the library and headers (more on these later), lines 5 through 11 contain a comment contained within the "slash star" characters `/* ... */` which the compiler simply ignores, and at line 12 we reach the `int main()` function. 
```c
int main(){
	helloWorld();
	printSizes();
	intDemo();
	arrayDemo();
	return 0;
}
```
Software is sequential, meaning the computer will execute one instruction at a time in a specific order, and it all starts with the first line of the `main()` function, which in this case is another function call but don't worry about that yet.  Every C program must have a `main` function.  `int` indicates that the function will return an integer which is accomplished with `return 0;`.  This integer is usually used to indicate the exit status of the program, `0` means success, anything else is regarded as an error (your embedded system probably won't care or even requrie `main()` to return an `int`).

The first line in `main()` is a function call to `helloWorld()` on lines 20 to 22.
```c
void helloWorld(){
	printf("Hello Wolrd!\n");
}
```
`void` indicates that the function returns nothing, that is gives no value back to the function that called it, it simply executes code.  In this case the code is a call to a function `printf()`.  `printf()` is not defined in any of the code written in this project so don't start looking.  Remember the library declaration on line 1 `#include <stdio.h>`?  This line imported a header (code that is basically pased to the top of the file) that defines the IO functions for the operating system, including `printf()` which writes to teh console.  Notice that because this function is a `void` there is no `return` statement.

### Data Types

One of the things I love about C is that everything is bits.  We choose to ready those bits as characters, decimal numbers, or hexadecimal, but at the end of the day C will allow you to do bitwise operations on `char`s, `int`s, and `long`s.  The main difference between these data types is their size in bytes (8 bits = 1 byte).  The function `printSizes()` displayes the number of bytes that make up each of these data types.  Unfortunately these sizes often varry between machines and processors so after you compile adn run the code you may see different numbers from what I got.

|Data Type|Size (bytes)|
|:-|:-|
|char|1|
|int|4|
|long|8|

