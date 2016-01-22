#define BIT0 0x01
#define BIT1 0x02
#define BIT2 0x04
#define BIT3 0x08
#define BIT4 0x10
#define BIT5 0x20
#define BIT6 0x40
#define BIT7 0x80

#define DATA_BYTES 5

void helloWorld();
void printSizes();
void intDemo();
char* intToBin(int num, char* str, int len);
void arrayDemo();
char* arrayToBin(char* array, int len, char* str);
void printArray(char* array, int len);
