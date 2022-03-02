//   05_RTL.c                                                                     
#include <windows.h>
#include <stdio.h>
#include <stdlib.h>
#include <conio.h>
#include<string.h>
//------------------------VARIABLES------
char Str_Massive[40];
char * ptrChar;
//***************************************************
//=                        function  MAIN                                            
//***************************************************
int main () 
{      
   int counter=0 , iterator=0;
   //--------------------------INPUT
        printf("Input String ->");
        scanf("%S" , &Str_Massive);
   //-------------------------MEMORY
         ptrChar=malloc( sizeof(Str_Massive)+1 );                              
    if (ptrChar != NULL)    //successfull memory
    {       
          memset( ptrChar , '\0' , sizeof(Str_Massive)+1 ); 
          //-----CYCLE
           while ( counter < sizeof(Str_Massive)+1  )
           {             
                     if (Str_Massive[counter] == '\0') 
                     {      //''''''
                          counter++;
                          continue;  // goto new cycle
                     }      //'''''' 
              ptrChar[iterator]=Str_Massive[counter];//copy byte   
                counter++;     iterator++;
            }      
          //-----    
     MessageBox(0  , ptrChar ,  "сообщение" , MB_SYSTEMMODAL);
    }      
__exit__:          	   
return 0;
}      
//                  END                                                                   
