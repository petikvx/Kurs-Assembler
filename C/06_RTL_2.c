//   06_RTL.c                                                                     
#include <stdio.h>
#include <stdlib.h>
#include <string.h> 
#include <conio.h>
//------------------------VARIABLES------
char Str_Number[]="0123456789";
char STRING[2];
//*********************************************
//=                        function  MAIN                                  
//*********************************************
int main()
{      
    long counter=strlen(Str_Number);   
    int   Sum=0;                        
         //'-----------
        do { 
                  counter--;
                  printf ("\n%c" , Str_Number[counter]) ;
                  
            STRING[0]=Str_Number[counter]; STRING[1]='\0';
            
                 Sum=Sum + atoi(STRING) ;   
                          
         } while ( counter>0 ) ;           
         //'-------------	
	        printf ( "\n SUM==%d" ,  Sum );
         //'-------------
	getch();		    
  return 0;
}      
//                  END                                                         
