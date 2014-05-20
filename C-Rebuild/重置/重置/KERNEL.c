#include "stdafx.h"
#include "KERNEL.h"
#include "windows.h"
#include "convert.h"





void set_default_kernel_stat()
{
	kernel_info.debug=true;
	kernel_info.debug_info =true;
	kernel_info.name=unknow;
	kernel_info.version=unknow;
	kernel_info.kernel = KERNEL_NAME;
}


void error_code(int lv, int code)
{
	switch (code){
	case 0x0000000f:
		{
			cout<<"无法打开"<<KERNEL_HEAD<<endl;
			break;
		}
	case 0x0000001f:
		{
			cout<<"内核信息表读取错误 :(";
			break;
		}
	default:
		{
			cout<<"无法识别的错误:"<<code<<endl;
			break;
		}


	}

	if (lv>5 || kernel_info.debug)
		exit(code);
}

void read_kernel_head()
{
	LPWSTR buff[current_buff_size];
	head.open(KERNEL_HEAD,std::ios::in);
	if (head==NULL)
		error_code(7,0x000000f);
	head.getline(buff,current_buff_size);
	if (buff==NULL)
		error_code(7,0x000001f);
	GetPrivateProfileString(char_to_lpcw(kernel_head_label),char_to_lpcw("debug"),char_to_lpcw("true"),buff,current_buff_size,char_to_lpcw(KERNEL_HEAD));

}