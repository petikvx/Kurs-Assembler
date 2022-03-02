.386P
.model flat, stdcall
  option   casemap:none
                        include C:\masm32\INCLUDE\WINDOWS.INC
                        include C:\masm32\INCLUDE\KERNEL32.INC 
                        include C:\masm32\INCLUDE\USER32.INC
                        include   C:\masm32\INCLUDE\SHELL32.INC                          
                        include C:\masm32\INCLUDE\ADVAPI32.INC 
                        include   C:\masm32\INCLUDE\GDI32.INC       
                        include    C:\masm32\INCLUDE\comdlg32.inc                                  
                        include  my.inc
                        
                        includelib C:\masm32\lib\masm32.lib                                                                                                  
                         includelib C:\masm32\lib\comdlg32
                        includelib C:\masm32\lib\user32.lib
                        includelib  C:\masm32\lib\shell32.lib
                        includelib C:\masm32\lib\gdi32.lib
                        includelib C:\masm32\lib\kernel32.lib                
                        includelib C:\masm32\lib\user32.lib
                        includelib C:\masm32\lib\advapi32.lib     
;-PROTO--PROTO--PROTO--PROTO--PROTO--PROTO--PROTO--PROTO-                        

DLL_GLOB_TIME_proc           PROTO         hWnd1:DWORD								       
;############################################################################
;data--data--data--data--data--data--data--data--data--data--data--data--data--data-- proc
;-------------------------------------------------------------------------------------------------------------------------
_EDATA SEGMENT DWORD PUBLIC USE32'IDATA'
;---
         HINST_DLL                           DD          0
         OWN_COUNT                        DD       Null
;---
_EDATA  ENDS
;===================================================================
_DATA SEGMENT DWORD PUBLIC USE32'DATA' 
;---
     COUNT_DLL                           DD             NULL
     ID_Process                                 DD      NULL
;---
_DATA  ENDS 


.CODE
;#############################################################################
;code--code--code--code--code--code--code--code--code--code--code--code--code- proc 
;--------------------------------------------------------------------------------------------------------------------------
DLLENTRY@12:

MAIN_DLL_FUNC        PROC         hinstDLL :DWORD  ,  hReason:DWORD ,  ReservedParam:DWORD
;   
            		   mov   EAX  ,   hReason
		CMP    EAX    ,  DLL_PROCESS_ATTACH  ;   equ 1        загрузка DLL в процесс
	       je    $_ATTACH_
	       ;---
		CMP    EAX    ,  DLL_THREAD_ATTACH      ;   equ 2       загрузка  DLL в поток
 	      je     FINISH
 	      ;---
		CMP    EAX   ,  DLL_THREAD_DETACH       ;   equ 3      выгрузка  из  потока
 	       je    FINISH
 	       ;---
		CMP    EAX   ,  DLL_PROCESS_DETACH    ;   equ 0      выгрузка  из процесса
  	       je   FINISH
  	       ;---
  	       ;===========================================
$_ATTACH_:
                       mMOV   HINST_DLL    ,   hinstDLL
             jmp   FINISH
             
;-
FINISH:  
      mov           EAX   ,  TRUE
RET 12
MAIN_DLL_FUNC     ENDP

;--------------------------------------------------------------------------------------------------------------------------
;                                                    GLOBAL   COUNT                                                             
;--------------------------------------------------------------------------------------------------------------------------
DLL_SHARE_COUNT_proc                PROC              hWnd1:DWORD  
;-
              .IF   ID_Process == NULL
                                     invoke  GetCurrentProcessId  
                                     mov   ID_Process  ,  EAX  ; идентификатор самого первого процесса 
              .ELSE
                                     invoke  GetCurrentProcessId  

                                    .if     OWN_COUNT >=  5  &&  ID_Process != EAX ; это не первый процесс
                                    
                                              invoke   OpenProcess  ,    PROCESS_TERMINATE ,  NULL , EAX   
                                              invoke     ExitProcess   ,  EAX ; само-завершение процесса.
                                            jmp   $_FINISH_   
                                    .else
                                    
                                             INC  COUNT_DLL   ; общий  счетчик
                                             INC  OWN_COUNT ; приватный счетчик
                                                                                                                                   
                                    .endif                                                                                               
              .ENDIF                
     ;выводим значения каунтеров в текстовые поля
     invoke  SetDlgItemInt   ,   hWnd1  ,  2  ,   COUNT_DLL  ,  FALSE
     invoke  SetDlgItemInt   ,   hWnd1  ,  3  ,    OWN_COUNT  ,  FALSE       
;-
$_FINISH_:
RET  4
DLL_SHARE_COUNT_proc                ENDP
;--------------------------------------------------------------------------------------------------------------------------
;###################################################################
END DLLENTRY@12

