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
;############################################################################
;data--data--data--data--data--data--data--data--data--data--data--data--data--data-- proc
;-------------------------------------------------------------------------------------------------------------------------
.DATA
HINST_DLL                           DD          0
;---
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
 	      je    FINISH
 	      ;---
		CMP    EAX   ,  DLL_THREAD_DETACH       ;   equ 3      выгрузка  из  потока
 	       je    FINISH
 	       ;---
		CMP    EAX  ,  DLL_PROCESS_DETACH    ;   equ 0      выгрузка  из процесса
  	       je   $_DETTACH_
  	       ;---
  	       ;===========================================
$_ATTACH_:
                       mMOV   HINST_DLL    ,   hinstDLL
             jmp   FINISH
;-             
$_DETTACH_:
                       invoke  Beep  ,  3000 ,  100  
             jmp   FINISH	       
;-
FINISH:  
      mov           EAX   ,  TRUE
RET 12
MAIN_DLL_FUNC     ENDP
;###################################################################
END DLLENTRY@12

