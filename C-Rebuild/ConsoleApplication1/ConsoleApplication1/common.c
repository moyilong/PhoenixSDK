#include "stdafx.h"
#include "string.h"

int r_size=0;




void cls()
{
	if (!VERSION.debug)
		system("cls");
	else
		cout<<"=======================CLS===============";
}

void debug_info(char *info)
{
	if (VERSION.debug)
		cout<<info;
}

int get_filedata(string filename,string label)
{
	ifstream file;
	file.open("filename");
	char temp[1000];
	while (1)
	{

	}
}