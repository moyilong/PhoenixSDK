// get_version.cpp : �������̨Ӧ�ó������ڵ㡣
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

	cout<<"����"<<getenv("name")<<endl;

	if (getenv("skip_kernelcheck")=="false")
		cout<<"����ʱ��:"<<getenv("b_time")<<endl<<"�ں�����ʱ��:"<<getenv("k_time")<<endl;

	cout<<"�������:"<<getenv("build_id")<<endl;
	cout<<"�汾��:"<<getenv("version")<<endl;
	cout<<"�ں˰汾:"<<getenv("k_version")<<endl;
	cout<<"���������:"<<getenv("pkg_version")<<endl;
	system("call %kernel%\line.bat");
	if (debug_info)
	{
		cout<<"��ǰ���ú�����:"<<getenv("cores")<<endl;
		cout<<"��ǰϵͳ�ܹ�:"<<getenv("HOST_ARCH")<<endl;
		cout<<"Bootloader:"<<getenv("bios_loader")<<"  "<<getenv("bios_version")<<endl;
		cout<<"ָ�:"<<getenv("command")<<endl;
		cout<<"�ں˲���"<<getenv("cmdline")<<endl;
		cout<<"��ʱ�ļ�Ŀ¼:"<<getenv("temp")<<endl;
		
	}

	system("for %%f in (%feature%) do if exist %appdir%\%%f\data\ver_display.bat call %appdir%\%%f\data\ver_display.bat");




}