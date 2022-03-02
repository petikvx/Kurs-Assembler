//   First.c                                                                     
#include <stdio.h>
#include <stdlib.h>
#include <conio.h>
#include <windows.h>
//------------------------VARIABLES------
int uR =0x0,  uG=0xF;
char Sys_Color[]="COLOR %X%X\n";
char String[40];
//*********************************************
//=                        function  MAIN                                  
//*********************************************
int main()
{      
	while ( uR <= 0xF )
	{      
	     sprintf(String , Sys_Color , uR , uG);
	      printf(String);
		 //----------
	                   system(String);
		 //----------
		 uR++;
		 uG--;
            Sleep(500);
	}      
	    getch();
  return 0;
}      
//                  END                                                         


