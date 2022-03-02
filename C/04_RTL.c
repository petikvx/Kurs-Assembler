//   First.c                                                                     
#include <stdio.h>
#include <conio.h>
#include <windows.h>
//------------------------VARIABLES------
int uR ,  uG;
char KOT[]="ETO KOT";
//*********************************************
//=                        function  MAIN                                  
//*********************************************
int main()
{      
__GO__:
 //-------------
    scanf("%d%d" ,  &uR , &uG);   // INPUT   uK  and uD
     printf ( "\n%d and %d\n" ,uR , uG);
 //-------------
	if (uR==3){
	        printf("  uR==3  ------\n");  goto __GO__;
	}
	else if ( uG<uR ){
	        Beep(2000 , 100);   			 
	        printf("  uG<uR   ------\n");  goto __GO__;
	}
	else if ( uG>uR){
	        MessageBox(0 , KOT , KOT , 0 );	
	        printf("  uG>uR   ------\n");  goto __GO__;
	}
	else{ // if UG==UR
	        printf ("\n VIHOD ------\n");  getch(); 	              
	}						
  return 0;
}      
//                  END                                                         


