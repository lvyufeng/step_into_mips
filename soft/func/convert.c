#include <stdio.h>
#include <stdlib.h>
void binary_out(FILE* out,unsigned char* mem)
{
    char tmp;
    unsigned char num[8];
    num[0] = 1;
    num[1] = 2;
    num[2] = 4;
    num[3] = 8;
    num[4] = 16;
    num[5] = 32;
    num[6] = 64;
    num[7] = 128;
    for(int i=3;i>=0;i--)
    {
        for(int j=7;j>=0;j--)
        {
            if( (mem[i] & num[j] ) != 0)
                tmp = '1';
            else
                tmp = '0';
            fprintf(out,"%c",tmp);
        }
    }
    fprintf(out,"\n");
    return;
}

int main(void)
{
	FILE *in;
	FILE *out;

	int i,j,k;
	unsigned char mem[32];

    in = fopen("main.bin", "rb");
    out = fopen("inst_ram.coe","w");

	fprintf(out, "memory_initialization_radix = 16;\n");
	fprintf(out, "memory_initialization_vector =\n");
	while(!feof(in)) {
	    if(fread(mem,1,4,in)!=4) {
	        fprintf(out, "%02x%02x%02x%02x\n", mem[3], mem[2],	mem[1], mem[0]);
		break;
	     }
	    fprintf(out, "%02x%02x%02x%02x\n", mem[3], mem[2], mem[1],mem[0]);
        }
	fclose(in);
	fclose(out);

    in = fopen("main.data", "rb");
    out = fopen("data_ram.coe","w");

	fprintf(out, "memory_initialization_radix = 16;\n");
	fprintf(out, "memory_initialization_vector =\n");
	while(!feof(in)) {
	    if(fread(mem,1,4,in)!=4) {
	        fprintf(out, "%02x%02x%02x%02x\n", mem[3], mem[2],	mem[1], mem[0]);
		break;
	     }
	    fprintf(out, "%02x%02x%02x%02x\n", mem[3], mem[2], mem[1],mem[0]);
        }
	fclose(in);
	fclose(out);

    in = fopen("main.data", "rb");
    out = fopen("data_ram.mif","w");

	while(!feof(in)) {
	    if(fread(mem,1,4,in)!=4) {
            binary_out(out,mem);
		break;
	     }
            binary_out(out,mem);
        }
	fclose(in);
	fclose(out);

    in = fopen("main.bin", "rb");
    out = fopen("inst_ram.mif","w");

	while(!feof(in)) {
	    if(fread(mem,1,4,in)!=4) {
            binary_out(out,mem);
		break;
	     }
            binary_out(out,mem);
        }
	fclose(in);
	fclose(out);

    return 0;
}
