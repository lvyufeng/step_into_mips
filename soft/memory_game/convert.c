#include <stdio.h>
#include <stdlib.h>
#include <string.h>

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

int main(int argc, char** argv)
{
	FILE *in;
	FILE *out;

	if(argc < 3){
		fprintf(stderr, "Usage: convert main.bin main.data directory\n");
		return 1;
	}

	char str_bin[256];
	char str_coe[256], str_mif[256];
	strncpy(str_bin, argv[2], 256);
	strncpy(str_coe, argv[2], 256);
	strncpy(str_mif, argv[2], 256);
	strncat(str_bin, argv[1], 256);
	strncat(str_coe, "axi_ram.coe", 256);
	strncat(str_mif, "axi_ram.mif", 256);
	//printf("%s\n%s\n%s\n%s\n%s\n%s\n", str_bin, str_data, str_inst_coe, str_inst_mif, str_data_coe, str_data_mif);

	int i,j,k;
	unsigned char mem[32];

    in = fopen(str_bin, "rb");
    out = fopen(str_coe,"w");

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

    in = fopen(str_bin, "rb");
    out = fopen(str_mif,"w");

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
