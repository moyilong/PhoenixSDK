// msleep.cpp : 定义控制台应用程序的入口点。
//

#include "stdafx.h"
#include "windows.h"

int main(int argc, char* argv[])
{
	//int int_tmp = (int)(argv[0] - '0');
	Sleep(atoi(argv[1]));
}

