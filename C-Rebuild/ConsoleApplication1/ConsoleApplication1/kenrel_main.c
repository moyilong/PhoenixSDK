
#include "stdafx.h"

#include "kernel_info.h"
#include "common.h"




void setting_kernel_info()
{
	VERSION.name=GetPrivateProfileString("kernel_info","name","unknow","kernel_info.ini");
	VERSION.build=GetPrivateProfileString("kernel_info","build","unknow","kernel_info.ini");
	VERSION.version="Pre_Alpha";
	if (GetPrivateProfileInt("kernel_info","debug_stat",1,"kernel_info.ini")==1)
		VERSION.debug=true;
	else
		VERSION.debug=false;
	VERSION.vname=GetPrivateProfileString("kernel_info","vname","unknow","kernel_info.ini");
}




void kernel_init(string *mode)
{
	VERSION.debug=DEFAULT_DEBUG_INFO;
	debug_info("Reading File for Kernelhead");
	setting_kenrel_info();
	for (int i=0;i<36;i++)
	{
		if (mode=="debug")
			VERSION.debug=true;
	}
	

	

}