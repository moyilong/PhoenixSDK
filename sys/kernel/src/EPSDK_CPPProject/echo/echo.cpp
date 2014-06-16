// echo.cpp : 定义控制台应用程序的入口点。
//

#include "stdafx.h"
#include "string"
#include "iostream"
#include "windows.h"
using namespace std;
int i = 0;
int main(int argc, char *argv[])
{
	string *arg = new string[i+6];
	memset(arg, '\0', sizeof(arg));

	for (i = 1; i < argc; i++)
	{
		arg[i - 1] = argv[i];
		cout << "Arg:" <<i<<" "<< arg[i] << endl;
	}
	int n = arg[i].size();
	cout << "Get " << arg[i] << " Size Is:" << arg[i].size();
	bool enter = false;
	cout << arg[i - 1].substr(n - 3, n);
	cout << "Start STRCMP" << endl;
	if (strcmp(arg[i].substr(n - 3, n).data(), "---"))
	{
		enter = true;
		cout << "Enable ENDL" << endl;
	}
	for (int v = 0; v <= i - 1; v++)
	{
		if (enter || v == i - 1)
		{
			cout << arg[v].substr(0, arg[v].size() - 3)<<endl;
		}
		else
			cout << arg[v];
	}
		
		
}