//   07_RTL_1.c                                                                     
#include <windows.h>
#include <stdio.h>
#include <stdlib.h>
#include <conio.h>
#include <string.h>
//------------------------VARIABLES------
char Str_Massive[40];

//*********************************************
//=                        function  MAIN                                  
//*********************************************
int main () 
{      
        printf("Input String ->");
        scanf("%S" , &Str_Massive);
        __asm
        {      
                int 3
        }      
    MessageBox(0  , Str_Massive , "сообщение" , 
                                               MB_SYSTEMMODAL);
 
__exit__:          	   
return 0;
}      
//                  END                                                         
