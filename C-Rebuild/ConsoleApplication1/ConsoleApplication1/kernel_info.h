#include "string.h"

#define DEFAULT_DEBUG_INFO	true;

struct kernel_info_ver {
 	string name;
	string version;
	string vname;
	int v_1;
	int v_2;
	bool debug;
	int build;
};


void setting_kernel_info();