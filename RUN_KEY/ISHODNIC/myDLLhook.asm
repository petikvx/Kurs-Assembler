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
                  
WM_USER_1   equ   WM_USER + 1  					       
;##################################################################
;data--data--data--data--data--data--data--data--data--data--data--data--data--data-- proc
;-------------------------------------------------------------------------------------------------------------------------
_EDATA SEGMENT DWORD PUBLIC USE32 'IDATA'
;---
         HINST_DLL                           DD          0

;---
_EDATA  ENDS
;===================================================================
_DATA SEGMENT DWORD PUBLIC USE32'DATA'         ;  GLOBAL  DATA
;---
        HWND_Look                        DD       NULL                 ; ours WINDOW  
        HHOOK_Key                    DWORD    NULL            ;  HOOK  KEY
        
;---
_DATA  ENDS 
.CODE
;###################################################################
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
;                                                  HOOK- FILTR of  KEY                                                                    
;--------------------------------------------------------------------------------------------------------------------------
DLL_Key_HOOK_proc                PROC       nCode:DWORD , wParam:DWORD , lParam:DWORD	
local    result:DWORD	
local    uScanCode:DWORD;// scan code
local    KeyState[512]:BYTE	;// address of key-state array
local    Char:DWORD	;// buffer for translated key  
;-
        invoke   CallNextHookEx  ,  HHOOK_Key , nCode , wParam , lParam  
        mov   result  ,  EAX           
      ;- - - - - - - - - - - - - - - - -- - - 
       .IF nCode == HC_ACTION 
                                
                      mov   ebx ,   lParam                     
                     TEST   ebx ,   80000000h   ; проверка отжатия клавиши  в 31 бите.
                  JZ $_FINISH_
                
                     SHR   EBX  ,   16
                     AND   EBX  ,   000000FFh 
                     MOV   uScanCode ,  EBX     ;  извлечен третий бит - это скан-код клавиши.
                    
                     invoke  GetKeyboardState  ,   addr  KeyState
                                                                                           
                     invoke  ToAscii,  wParam,\                    
                                                           uScanCode,\
                                                           addr   KeyState,\
                                                           addr  Char,\    ;  получить символьный код (в буфер)
                                                           null

                     invoke   PostMessage  ,  HWND_Look  ,    WM_NULL ,\   
                                                                                       Char , lParam  ; передача клиенту
       .ENDIF
;-     
$_FINISH_:
mov  EAX  ,  result
RET   12
DLL_Key_HOOK_proc                  ENDP
;--------------------------------------------------------------------------------------------------------------------------
;                                                    SET  HOOK  KEY                                                            
;--------------------------------------------------------------------------------------------------------------------------
DLL_SET_HOOK_proc                PROC   export          hWnd1:DWORD  	
;-
   
        mMOV   HWND_Look   ,  hWnd1
        ;-        
        invoke   SetWindowsHookEx  ,   WH_KEYBOARD ,  addr  DLL_Key_HOOK_proc ,\
 					     HINST_DLL   ,   NULL
          Mov  HHOOK_Key  ,   Eax
;-
RET  4
DLL_SET_HOOK_proc               ENDP
;--------------------------------------------------------------------------------------------------------------------------
;                                                    UNSET    HOOK   KEY                                                         
;--------------------------------------------------------------------------------------------------------------------------
DLL_UNSET_HOOK_proc                PROC   export           				
;-
   
 	invoke    UnhookWindowsHookEx  ,   HHOOK_Key
                 		     
;-
RET  
DLL_UNSET_HOOK_proc               ENDP
;--------------------------------------------------------------------------------------------------------------------------
;###################################################################
END DLLENTRY@12

