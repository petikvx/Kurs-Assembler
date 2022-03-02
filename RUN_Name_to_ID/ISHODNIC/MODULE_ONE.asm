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
MODULE_FIND_PROCESS      PROTO   hWnd1:DWORD , ptrNAME:DWORD 
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
local   _Name[256]:BYTE
;-
              ; считывает   имя процесса
            invoke   GetDlgItemText ,  hWnd1 , 1 ,  addr  _Name  , 255
           .IF    EAX  !=  NULL
	     ;================
	       INVOKE  MODULE_FIND_PROCESS  , hWnd1  ,  addr  _Name
	     ;================
	 .ENDIF
;-
ret  16
MODULE_TIMER_proc    ENDP
;---------------------------------------------------------------------------------------------------------------------------------
;                                 FIND  ID  PROCESS  BY  NAME                                                               
;--------------------------------------------------------------------------------------------------------------------------------
MODULE_FIND_PROCESS      PROC   hWnd1:DWORD ,  ptrNAME:DWORD 
LOCAL   _SNAP:DWORD
LOCAL   _PROCESS_STRUCT   :PROCESSENTRY32
;------------------------ делать снимок               
       invoke   CreateToolhelp32Snapshot   ,    TH32CS_SNAPPROCESS  ,  NULL       
        mov   _SNAP  ,  EAX
        Mov   _PROCESS_STRUCT.dwSize    ,   size      PROCESSENTRY32
        ;-----------------  идем  по  списку      начинаем  с первого элемента      
     invoke     Process32First   ,     _SNAP  ,  addr  _PROCESS_STRUCT
     invoke   GetLastError
     .IF   EAX ==  ERROR_NO_MORE_FILES  
              jmp   $_FINISH_
     .ENDIF
                     ;========================сравнить   имена
                     invoke   lstrcmp ,  ptrNAME  ,  addr   _PROCESS_STRUCT.szExeFile                     
                .if    EAX  ==  NULL  
                            invoke    SetDlgItemInt  , hWnd1 , 2 ,  _PROCESS_STRUCT.th32ProcessID , FALSE  
                         jmp  $_FINISH_
                .endif

         ;-----------------  идем  по  списку     дальше    в   цикл                  
$_LOOP_:	
  	              
                          Mov    _PROCESS_STRUCT.dwSize    ,   size      PROCESSENTRY32
                           invoke    Process32Next   ,  _SNAP  ,  addr   _PROCESS_STRUCT	
                           invoke   GetLastError         
                     .IF   EAX ==  ERROR_NO_MORE_FILES
          		     jmp   $_FINISH_
     		.ENDIF
                   		  ;========================сравнить   имена
                    	   invoke   lstrcmpi ,  ptrNAME  ,  addr   _PROCESS_STRUCT.szExeFile                     
              		  .if    EAX  ==  NULL  
                 		           invoke    SetDlgItemInt  , hWnd1 , 2 ,  _PROCESS_STRUCT.th32ProcessID , FALSE  
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









