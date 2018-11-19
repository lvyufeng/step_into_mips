#include <stdio.h>
#include <stdlib.h>

#define SIZE 10
FILE files[SIZE] = {0};
/*

FILE* fopen(char* str){
	FILE* file = &dummy;
	while(file->next != NULL){
		file = file->next;
	}
	file->next = malloc(sizeof(*file));
	file->next->str = str;
	file->next->pos = 0;
	file->next->next = NULL;
	return file->next;
}
*/
FILE* fopen(char* str){
	int i;
	for(i=0;i<SIZE;i++){
		if(files[i].str == NULL){
			break;
		}
	}
	files[i].str = str;
	files[i].pos = 0;
	return &files[i];
}

size_t fread(void* ptr, size_t size, size_t nmemb, FILE* stream){
	char* out = (char*)ptr;
	char* str = stream->str;
	size_t total = strlen(str);
	if(stream->pos == total){
		return 0;
	}
	size_t c = 0;
	for(c=0;c<size*nmemb; ){
		out[c++] = str[stream->pos++];
		if(stream->pos == total){
			break;
		}
	}
	return c;
}

/*
void fclose(FILE* stream){
	FILE* file = &dummy;
	while(file->next != stream){
		file = file->next;
	}
	FILE* tmp = file->next;
	file->next = tmp->next;
	free(tmp);
}
*/

void fclose(FILE* stream){
	int i;
	for(i=0;i<SIZE;i++){
		if(&files[i] == stream){
			break;
		}
	}
	stream->str = NULL;
	stream->pos = 0;
}

char *fgets(char *s, int size, FILE *stream){
	char* str = stream->str;
	size_t total = strlen(str);
	size_t c = 0;
	char* r = NULL;
	while(stream->pos != total){
		if(str[stream->pos] == '\n'){
			s[c++] = str[stream->pos++];
			break;
		}else{
			s[c++] = str[stream->pos++];
		}
	}
	return r;
}

int getc(FILE* stream){
	char* str = stream->str;
	size_t total = strlen(str);
	if(stream->pos == total){
		return EOF;
	}else{
		return (unsigned char)str[stream->pos++];
	}
	
}
