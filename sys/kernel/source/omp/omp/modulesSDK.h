#pragma once
#define CMDOMP_MODULES extern "C" __declspec(dllexport) 
#define SDK_VERSION	1.0

#include <iostream>
#include <fstream>
#include <string>
#include <vector>

//typedef bool(*my_mod)(vector<string>*, char *);

#define MAX_BUFF_SIZE	4096

struct KERNEL_INFO{
	char API = SDK_VERSION;
	bool debug_stat = false;

};

struct MODULES_INFO{
	char API = SDK_VERSION;
	char BUILD_VER = 1;
	char RELEASE_VER = 1;
	char name[MAX_BUFF_SIZE];
};

