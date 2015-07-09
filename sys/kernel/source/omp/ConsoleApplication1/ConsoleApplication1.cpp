// ConsoleApplication1.cpp : 定义 DLL 应用程序的导出函数。
//

#include "stdafx.h"
#include "ConsoleApplication1.h"
#include "../omp/modulesSDK.h"

using namespace std;

CMDOMP_MODULES int filelist(const KERNEL_INFO info,vector<string> &poll, char *data)
{
	ifstream in;
	in.open(data);
	if (!in.is_open())
		return -2;
	if (info.debug_stat)
	while (!in.eof())
	{
		string temp;
		getline(in, temp);
		poll.push_back(temp);
		if (info.debug_stat)
			cout << "[MOD]Add:" << temp << endl;
	}
	in.close();
	return 0;
}

CMDOMP_MODULES string ModulesInfo(MODULES_INFO &ret)
{
	ret.BUILD_VER = 1;
	ret.RELEASE_VER = 0;
	return "FileSuppoert";
}

CMDOMP_MODULES string ErrorProcess(int n)
{
	switch (n)
	{
	case -2:
		return "File IO Except!" ;
		break;
	}
}