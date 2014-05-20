#include "windows.h"
#include "convert.h"


LPCWSTR	char_to_lpcw(char *szStr)
{
WCHAR wszClassName[256];  
memset(wszClassName,0,sizeof(wszClassName));  
MultiByteToWideChar(CP_ACP,0,szStr,strlen(szStr)+1,wszClassName,  
    sizeof(wszClassName)/sizeof(wszClassName[0]));  


}