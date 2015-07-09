// omp.cpp : 定义控制台应用程序的入口点。
//

#include "stdafx.h"
#include <iostream>
#include <string>
#include <omp.h>
using namespace std;

#define VER	"0.1"
#define NAME	"CMD-OMP"
const char  list[] = { ' ', ',', ';' };

#include <vector>
#include <Windows.h>
vector<string> poll;

#include "modulesSDK.h"

KERNEL_INFO kernel;

enum WORKMODE{
	STRING_LIST,
	INT_ADD,
	FILE_READ,
	MOD_LOAD,
};
string mod;
WORKMODE wmode=STRING_LIST;
int int_start;
int int_stop;
int int_step;
bool info_get = false;
bool multi_line = false;

typedef int(*my_mod)(const KERNEL_INFO,vector<string>&, char *);
typedef string(*mod_info)(MODULES_INFO &);
typedef string(*err_process)(int);

inline string replace(const char *data, const char *replcae, const char *tar_re)
{
	//cout << "Replace " << data << " in " << replcae << " to " << tar_re << endl;
	string ret;
	for (int n = 0; n < strlen(data); n++)
	{
		bool stat = false;
		if (data[n] == replcae[0])
		{
			stat = true;
			for (int x = 0; x < strlen(replcae); x++)
				if (data[n + x] != replcae[x])
					stat = false;

		}
		if (stat)
		{
			//cout << "Replace at" << n << endl;
			string cpy = tar_re;
			ret += cpy;
			n += strlen(replcae);
		}
		else
			ret += data[n];
	}
	return ret;
}



void main(int argc, char* argv[])
{
	kernel.debug_stat = true;
	int start = 0;
	for (int n = 0; n < argc; n++)
	{
		if (!strcmp(argv[n], "-tn"))
		{
			cout << "MaxThread:" << omp_get_max_threads() << endl;
			return;
		}
		if (!strcmp(argv[n], "-l"))
		{
			n++;
			wmode = INT_ADD;
			int_start = atoi(argv[n]);
			n++;
			int_step = atoi(argv[n]);
			n++;
			int_stop = atoi(argv[n]);
			continue;
		}
		if (!strcmp(argv[n], "-v"))
		{
			cout << "Windows Command Line OpenMP Simple Support!" << endl << "Version:" << VER << endl << "MOD API:" << SDK_VERSION << endl;
			exit(-1);
		}
		if (!strcmp(argv[n], "-m"))
		{
			n++;
			wmode = MOD_LOAD;
			mod = argv[n];
			continue;
		}
		if (!strcmp(argv[n], "-mi"))
		{
			n++;
			wmode = MOD_LOAD;
			mod = argv[n];
			info_get = true;
			continue;
		}
		if (!strcmp(argv[n], "-n"))
		{
			n++;
			omp_set_num_threads(atoi(argv[n]));
			continue;
		}
	}
	if (argc < 3)
	{
		cout << "HELP::" << endl << argv[0] << "[option] [parallel list] [command]" << endl << "使用##OMP来带来被替换的内容" << endl;
		return;
	}
	string mod_file;
	string mod_link;
	HINSTANCE load;
	my_mod link;
	mod_info info;
	MODULES_INFO modx;
	string name;
	switch (wmode)
	{
	case INT_ADD:
		for (int n = int_start; n < int_stop; n += int_step)
		{
			char buff[4096] = { 0 };
			_itoa(n, buff, 10);
			poll.push_back(buff);
		}
		break;
	case MOD_LOAD:
	
		for (int n = 0; n < mod.size(); n++)
		{
			if (mod[n] == ',')
			{
				mod_file = mod.substr(0, n);
				mod_link = mod.substr(n + 1);
			}
		}
		if (info_get)
			mod_file = mod;
		load = LoadLibraryA(mod_file.data());

		
		if (load == NULL)
		{
			cout << "Load Modules:" << mod_file << " faild!" << endl;
			return;
		}
		info = (mod_info)GetProcAddress(load, "ModulesInfo");
		if (info == NULL)
		{
			cout << "Read Modules Faild! or API mismatch!" << endl;
			return;
		}
		
		name=info(modx);

		if (modx.API > SDK_VERSION)
		{
			cout << "API MisMatch!" << endl;
			return;
		}
		if (info_get)
		{
			cout << "Command Link simple OpenMP Modules Utils" << endl;
			cout << "Name:" << name << endl;
			cout << "Version:" << (int)modx.BUILD_VER << "." << (int)modx.RELEASE_VER << endl;
			cout << "FILE:" << mod_file << endl;
			return;
		}
		link = (my_mod)GetProcAddress(load, mod_link.data());
		if (link == NULL)
		{
			cout << "Get Mod Link Faild! \"" << mod_link << "\"" << endl;
			return;
		}
		int err;
		err = -99;
		err=link(kernel,poll, argv[argc - 2]);
		if (err!=0)
		{
			cout << "SUBMOD REPORT  A ERROR!" << endl;
			err_process err_link = (err_process)GetProcAddress(load,"ErrorProcess");
			if (err_link != NULL)
			{
				cout << "Report Notice:" << err_link(err) << endl;
			}
			cout << "Return Error:" << err << endl;
			exit(-1);
		}
		break;
	case STRING_LIST:
	default:
		int last=0;
		for (int n = 0; n < strlen(argv[argc - 2]); n++)
		{
			bool stat = false;
			for (int x = 0; x < sizeof(list); x++)
				if (list[x] ==argv[argc-2][n])
					stat = true;
			if (stat)
			{
				if (last == n - 1)
				{
					string temp = argv[argc - 2];
					poll.push_back(temp.substr(start, n - start));
					start = n + 1;
					last = n;
				}
				else
				{
					last = n;
				}
			}
		}
		string temp = argv[argc - 2];
		poll.push_back(temp.substr(start));
		break;
	}
#pragma omp parallel for
	for (int n = 0; n < poll.size(); n++)
	{
		string exec = "cmd.exe /C \"";
		exec = exec + replace(argv[argc - 1], "##OMP", poll.at(n).data());
		exec += "\"";
		//cout << "exec:" << exec << endl;
		system(exec.data());
	}
}