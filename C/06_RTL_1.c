//   06_RTL.c                                                                     
#include <stdio.h>
#include <stdlib.h>
#include <string.h> 
#include <conio.h>
//------------------------VARIABLES------
char Str_Number[]="0123456789";

//*********************************************
//=                        function  MAIN                                  
//*********************************************
int main()
{      
    unsigned long counter=strlen(Str_Number);    
       
            printf( Str_Number );    printf("\n");
      printf( "length var = %u" , sizeof(unsigned long)  ) ;       
           //'-----------
           do { 
                  counter--;
                  printf ("\n%c" , Str_Number[counter]) ;
           
           } while ( counter>0 ) ;           
	 //'-------------	
	getch();
	    
  return 0;
}      
//                  END                                                         
