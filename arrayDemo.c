#include <stdio.h>
#include "demo.h"

void arrayDemo(){
	char arrayData[DATA_BYTES] = {
		0x01, 0x02, 0x33, 0xDF, 0xEC};
	char str[8*DATA_BYTES+1];
	
	printf("\nRepresentations of the Array:\n");
	printf("Hex:\t");
	printArray(arrayData, DATA_BYTES);	
	printf("Binary:\t%s\n", arrayToBin(arrayData, DATA_BYTES, str));

	printf("\nAccessing Elements of the Array\n");
	char item4 = arrayData[3];
	printf("Fourth element, index 3:\t0x%.2X\n", item4 & 0XFF);
	char bitTest1 = arrayData[3] & (BIT7|BIT5|BIT1|BIT0);
	char bitTest2 = arrayData[3] & (BIT5);
	printf("Testing bits 7, 5, 1, or 0:\t0x%.2X\n", bitTest1 & 0xFF);
	printf("Testing bit 5:\t\t\t0x%.2X\n", bitTest2 & 0xFF);
}

void printArray(char* array, int len){
	int i;
	for(i = 0; i < len; i++)
		printf("0x%.2X ", array[i] & 0xFF); //Mask adjusts for the typecast
	printf("\n");
}

char* arrayToBin(char* array, int len, char* str){
	int i, j;
	for(i =0; i < len; i++){
		int place = 0x01;
		for(j = 0; j < 8; j++){
			if(*(array+i) & place)
				str[i*8+j] = '1';
			else
				str[i*8+j] = '0';
			place = place << 1;
		}
	}
	str[len*8] = '\0';
	return str;
}
