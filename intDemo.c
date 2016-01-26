#include <stdio.h>
#include "demo.h"

void intDemo(){
	unsigned int intData = 0xDFEC1234;
	
	char str[8*sizeof(intData)+1];

	printf("\nRepresentations of an \'int\':\n");
	printf("Hex:    \t%X\n", intData);
	printf("Decimal:  \t%i\n", intData);
	printf("Unsigned: \t%u\n", intData);
	printf("Octal:  \t%o\n", intData);
	printf("Binary: \t%s\n", intToBin(intData, str, sizeof str));

	int midMask, headMask, tailMask, headSet, headClear, headTog;
	midMask = intData & 0x000FF000;
	headMask = intData & 0x0000FFFF;
	tailMask = intData & 0xFFFF0000;
	
	headSet = intData | ~0xFFFF;
	headClear = intData & 0xFFFF;
	headTog = intData ^ ~0xFFFF;

	printf("\nMasked Outputs:\n");
	printf("Original:\t%.8X\n", intData);

	printf("\nMasking:\n");
	printf("Center:\t\t%.8X\n", midMask);
	printf("Head:\t\t%.8X\n", headMask);
	printf("Tail:\t\t%.8X\n", tailMask);

	printf("\nChanging Bits\n");
	printf("Set bits:\t%.8X\n", headSet);
	printf("Clear bits:\t%.8X\n", headClear);
	printf("Toggle bits:\t%.8X\n", headTog);
}

char* intToBin(int num, char* str, int len){
	char* strS = str;
	int place = 0x01;
	int i;
	for(i = len-2; i >= 0; i--){
		if(num & place)
			*str++ ='1';
		else
			*str++ = '0';
		place = place << 1;
	}
	*str = '\0';
	return strS;
}
