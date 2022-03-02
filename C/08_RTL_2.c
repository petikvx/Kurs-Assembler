//   05_RTL.c                                                                     
#include <windows.h>
#include <stdio.h>
#include <stdlib.h>
#include <conio.h>
//-----------------------PROTO-----------
void message_Func(void);
//------------------------VARIABLES------
char Str_Number[15];
//******************************************************
//=                              function  MAIN                                            
//******************************************************
int main () 
{      
char c;
int counter=0;
                c = getchar();               // new char
 	          while (c != '\n')
 		{        
 		     Str_Number[counter] = c;
 		        counter++;  //inc
 		     if (  counter == sizeof(Str_Number)    )  
 		     { 
 		          Str_Number[counter-1]='\0';    
 		          break;
 		     }
 		     c=getchar();        // new char
 		}           
   __exit__:       
                     message_Func() ;                      
return 0;
}      
//******************************************************
//=                           function  message_my                                   
//******************************************************
void message_Func(void)
{      
    MessageBox (0 , Str_Number  , Str_Number ,  MB_SYSTEMMODAL);
        return;
}      
//                  END                                                         
