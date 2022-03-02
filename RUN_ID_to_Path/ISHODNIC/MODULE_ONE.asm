        .386
        .model flat,stdcall
  option   casemap:none
                        include C:\masm32\INCLUDE\WINDOWS.INC
                        include C:\masm32\INCLUDE\KERNEL32.INC 
                        include C:\masm32\INCLUDE\USER32.INC
                        include C:\masm32\INCLUDE\ADVAPI32.INC 
                        include   C:\masm32\INCLUDE\GDI32.INC                                                
                        include  my.inc
                                                                     
                        includelib C:\masm32\lib\comctl32.lib
                        includelib C:\masm32\lib\user32.lib
                        includelib C:\masm32\lib\gdi32.lib
                        includelib C:\masm32\lib\kernel32.lib                
                        includelib C:\masm32\lib\user32.lib
                        includelib C:\masm32\lib\advapi32.lib    
;###########################################################
MODULE_TIMER_proc    PROTO    hWnd1:DWORD,uMsg:DWORD,idEvent:DWORD , dwTime:DWORD 
MODULE_FIND_PROCESS      PROTO   hWnd1:DWORD , PID:DWORD 
;###########################################################
EXTERN    HINST:DWORD 

;###########################################################
;data--data--data--data--data--data--data--data--data--data--     PROC
;----------------------------------------------------------------------------------------------
.DATA
;-
NULL_STRING               DB  0 , 0 , 0 , 0
;##############################################################
;code--code--code--code--code--code--code--code--code--code-- PROC
;--------------------------------------------------------------------------------------------------
.CODE 
START: 
;---------------------------------------------------------------------------------------------------------------------------------
;                                                       TIMER                                                                              
;---------------------------------------------------------------------------------------------------------------------------------
MODULE_TIMER_proc    PROC    hWnd1:DWORD,uMsg:DWORD,idEvent:DWORD , dwTime:DWORD 
local   _Bool :DWORD
;-
               ; считывает  ID процесса
            invoke   GetDlgItemInt ,  hWnd1 , 1 ,  addr  _Bool  ,  FALSE
           .IF    _Bool  !=  NULL
	     ;================
	       INVOKE  MODULE_FIND_PROCESS  , hWnd1  ,   EAX
	     ;================
	 .ENDIF
;-
ret  16
MODULE_TIMER_proc    ENDP
;---------------------------------------------------------------------------------------------------------------------------------
;                         FIND PATH   PROCESS   BY   ID                                                                
;--------------------------------------------------------------------------------------------------------------------------------
MODULE_FIND_PROCESS      PROC   hWnd1:DWORD ,  PID_:DWORD 
LOCAL   _SNAP:DWORD
LOCAL   _module_STRUCT   :MODULEENTRY32
;------------------------ делать снимок               
       invoke   CreateToolhelp32Snapshot   ,    TH32CS_SNAPMODULE  ,   PID_
        mov   _SNAP  ,  EAX
        Mov   _module_STRUCT.dwSize    ,   size     MODULEENTRY32
        ;-----------------  идем  по  списку      начинаем  с первого элемента      
     invoke     Module32First   ,     _SNAP  ,  addr  _module_STRUCT
     invoke   GetLastError
     .IF   EAX ==  ERROR_NO_MORE_FILES  
              jmp   $_FINISH_
     .ENDIF
                  	  ;========================сравнить   ID
                   	    mov  eax  ,  PID_
                    	                    
              	  .if    EAX  ==  _module_STRUCT.th32ProcessID
			 invoke    SetDlgItemText  , hWnd1 , 2 ,  addr _module_STRUCT.szExePath
                 	       jmp  $_FINISH_
               	 .endif                

         ;-----------------  идем  по  списку     дальше    в   цикл                  
$_LOOP_:	
  	              
                          Mov    _module_STRUCT.dwSize    ,   size     MODULEENTRY32
                           invoke    Module32Next   ,  _SNAP  ,  addr   _module_STRUCT
                           invoke   GetLastError         
                     .IF   EAX ==  ERROR_NO_MORE_FILES  ||    EAX != NULL
                                  invoke  Beep  ,  3000 , 45
          		     jmp   $_FINISH_
     		.ENDIF
                   		  ;========================сравнить   ID
                    	    mov  eax  ,  PID_
                    	                    
              		  .if    EAX  ==  _module_STRUCT.th32ProcessID
                 		           invoke    SetDlgItemText  , hWnd1 , 2 ,  addr  _module_STRUCT.szExePath
                 		       jmp  $_FINISH_
               		 .endif                	
     		        jmp   $_LOOP_
                                                           

;-
$_FINISH_:

ret   8
MODULE_FIND_PROCESS    ENDP  
;------------------------------------------------------------------------------------------------------------------------------------------------------------------
;                                                                                                                                                                                
;------------------------------------------------------------------------------------------------------------------------------------------------------------------

END 









