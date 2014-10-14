// FileFileter.cpp : �������̨Ӧ�ó������ڵ㡣
//

#include "stdafx.h"
#include "iostream"
#include "fstream"
#include "string"
using namespace std;

void main(int argc, char* argv[])
{
	if (argc < 2)
	{
		cout << argv[0] << "   filename    linkid" << endl;
		exit(-1);
	}

	unsigned int id = atoi(argv[2]);
	ifstream in;
	in.open(argv[1], ios::_Nocreate);
	if (!in.is_open())
	{
		cout << "File IO Except!" << endl;
		exit(-1);
	}
	unsigned int did = 0;
	string temp;
	while (did+1 != id)
	{
		if (in.eof())
		{
			cout << "�����ļ�����!" << endl;
			exit(-1);
		}
		did++;
		in >> temp;
	}
	string out;
	in >> out;
	cout << out;
	exit(-1);
}

