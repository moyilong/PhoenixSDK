// get_version.cpp : 定义控制台应用程序的入口点。
//

#include "stdafx.h"
#include "stdlib.h"
#include "stdio.h"

#include "iostream"

#include "windows.h"

using namespace std;

void main()
{
	bool debug_info=false;
	
	if (getenv("debug_info")=="true")
		debug_info=true;

	cout<<"关于"<<getenv("name")<<endl;

	if (getenv("skip_kernelcheck")=="false")
		cout<<"生成时间:"<<getenv("b_time")<<endl<<"内核生成时间:"<<getenv("k_time")<<endl;

	cout<<"开发编号:"<<getenv("build_id")<<endl;
	cout<<"版本号:"<<getenv("version")<<endl;
	cout<<"内核版本:"<<getenv("k_version")<<endl;
	cout<<"程序包调度:"<<getenv("pkg_version")<<endl;
	system("call %kernel%\line.bat");
	if (debug_info)
	{
		cout<<"当前调用核心数:"<<getenv("cores")<<endl;
		cout<<"当前系统架构:"<<getenv("HOST_ARCH")<<endl;
		cout<<"Bootloader:"<<getenv("bios_loader")<<"  "<<getenv("bios_version")<<endl;
		cout<<"指令集:"<<getenv("command")<<endl;
		cout<<"内核参数"<<getenv("cmdline")<<endl;
		cout<<"临时文件目录:"<<getenv("temp")<<endl;
		
	}

	system("for %%f in (%feature%) do if exist %appdir%\%%f\data\ver_display.bat call %appdir%\%%f\data\ver_display.bat");




}