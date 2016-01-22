#include <stdio.h>
#include "demo.h"

void intDemo(){
	unsigned int intData = 0xDFEC1234;
	
	char str[8*sizeof(intData)+1];

	printf("\nRepresentations of an \'int\':\n");
	printf("Decimal:  \t%i\n", intData);
	printf("Unsigned: \t%u\n", intData);
	printf("Octal:  \t%o\n", intData);
	printf("Hex:    \t%X\n", intData);
	printf("Binary: \t%s\n", intToBin(intData, str, sizeof str));
}

char* intToBin(int num, char* str, int len){
	char* strS = str;
	int place = 0x01;
	int i;
	*(str+len-1) = '\0';
	for(i = len-2; i >= 0; i--){
		if(num & place)
			*(str+i) ='1';
		else
			*(str+i) = '0';
		place = place << 1;
	}
	return strS;
}
