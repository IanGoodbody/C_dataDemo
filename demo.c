# include <stdio.h>
# include "demo.h"


/* main()
 * 
 * The main function is where the program starts executing.  As with (almost)
 * any programming language, things will execute sequentially, one line or 
 * instruction at a time.  The C compiler will look for the "main()" function
 * to tell it where to start executing.
 */
int main(){
	helloWorld();
	printSizes();
	intDemo();
	arrayDemo();
	return 0;
}

void helloWorld(){
	printf("Hello Wolrd!\n");
}

void printSizes(){
	printf("A \'char\' is %i bytes.\n", (int) sizeof(char));
	printf("An \'int\' is %i bytes.\n", (int) sizeof(int));
	printf("A \'short\' is %i bytes.\n", (int) sizeof(short));
	printf("A \'long\' is %i bytes.\n", (int) sizeof(long));
	printf("A \'float\' is %i bytes.\n", (int) sizeof(float));
	printf("A \'double\' is %i bytes.\n", (int) sizeof(double));
}
