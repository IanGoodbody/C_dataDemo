# C_dataDemo
#### A quick primer on manipulating integer data C

So I came to the pedigogical realization that giving you a book on C for UNIX and letting you wander into the frightening land that is C programming for embedded systems without telling you how they were different was a bit irresponsible.  Hopefully this C demo, complete with example code that you should be able to run on your machine, will give you a bit of a jump start with what is going on.

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
