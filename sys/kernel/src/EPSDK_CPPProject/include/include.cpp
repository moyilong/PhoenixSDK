// include.cpp : 定义控制台应用程序的入口点。
//

#include "stdafx.h"
#include "stdlib.h"
#include "string"
#include "windows.h"
#include "iostream"
#include "fstream"
using namespace std;



int main(int argc, char *argv[])
{
	string *arg = new string[argc + 4];
	memset(arg, '\0', sizeof(arg));
	for (int i = 1; i < argc; i++)
	{
		arg[i-1] = argv[i];
		cout << "Arg:" << argv[i] << endl;
	}
	if (argc < 2)
	{
		cout << "Arg Error :(" << endl;
		exit(-1);
	}
	ifstream file;
	file.open(arg[0], ios::_Nocreate);
	if (!file)
	{
		cout << "File Not Find" << endl;
		exit(-2);
	}
	//cout << "Read " << arg[0] << " Index:" << arg[1] << endl;
	char buff[4096];
	string sbuff;
	string get = argv[1];
	int i;
	int n=0;
	while (!file.eof())
	{
		memset(buff, '\0', sizeof(buff));
		memset(&sbuff, '\0', sizeof(sbuff));
		file.getline(buff, 4096);
		sbuff = buff;
		//cout << "Get Data:" << sbuff << " Size is :" << sbuff.size() << endl;
		for (i = 0; sbuff[i] != '='; i++);
		i++;
		if (strcmp(sbuff.substr(0, i - 1).data(),get.data()))
		{
			string out=sbuff.substr(i + 1, sbuff.size());
			cout << sbuff.substr(i + 1, sbuff.size());
			return -1;
		}
		else{
			//cout << "GetIndex:" << sbuff.substr(0, i - 1)<<" i="<<i<<endl;
		}
		n++;
	}
}