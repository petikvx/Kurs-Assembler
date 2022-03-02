//   05_RTL.c                                                                     
#include <windows.h>
#include <stdio.h>
#include <stdlib.h>
#include <conio.h>
//-----------------------PROTO-----------
int message_Func( int  ,  char* );
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
        
return    message_Func( counter , Str_Number) ;
}      
//******************************************************
//=                           function  message_my                                   
//******************************************************
int message_Func(int cnt , char * myStr_ )
{      
 char _numStr[256]; 
           itoa( cnt , _numStr , 16);   
            
     MessageBox (0 , _numStr ,  myStr_  ,  MB_SYSTEMMODAL);
        return 0;
}      
//                  END                                                          
