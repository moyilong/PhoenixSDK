#include "fstream"
#include "windows.h"



struct kinfo  {
	char *name;
	char *version;
	bool debug;
	bool debug_info;
	char *kernel;
	
} kernel_info;
std::ifstream head;

#define unknow		"UNKNOW :("
#define KERNEL_NAME	"OpeteronC-CT966A"
#define KERNEL_HEAD "kernel\kernel_head.ini"	//INI File Format
#define current_buff_size	512
const char* kernel_head_lebel  =  "kernel_head";

void set_default_kernel_stat();
void error_code(int lv,int code)
