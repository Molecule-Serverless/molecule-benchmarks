#include <stdio.h>
#include <sys/time.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(){
	struct timeval restored_time;
	unsigned long restored_ms;

	gettimeofday(&restored_time, NULL);
	restored_ms = restored_time.tv_sec * 1000 + restored_time.tv_usec /1000;

	printf("begin at %lu ms\n",restored_ms);
	return 0;
}
