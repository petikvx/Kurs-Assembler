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

					       
;##############################################################
;data--data--data--data--data--data--data--data--data--data--data--data--data--data-- proc
;------------------------------------------------------------------------------------------------------------------
_EDATA SEGMENT DWORD PUBLIC USE32 'IDATA'
;---
         HINST_DLL                           DD          0
         
        String_WH_GETMESSAGE        DB    "WH_GETMESSAGE ",0
        count                                    DD    NULL         
;---
_EDATA  ENDS
;===================================================================
_DATA SEGMENT DWORD PUBLIC USE32'DATA'         ;  GLOBAL  DATA
;---
        HWND_Look                        DD       NULL           ;  WINDOW  
        HHOOK_Mes                   DWORD    NULL            ;  HOOK  KEY
;---
_DATA  ENDS 
.CODE
;#############################################################
;code--code--code--code--code--code--code--code--code--code--code--code--code- proc 
;----------------------------------------------------------------------------------------------------------------
DLLENTRY@12:

MAIN_DLL_FUNC        PROC         hinstDLL :DWORD  ,  hReason:DWORD ,  ReservedParam:DWORD
;   
            		   mov   EAX  ,   hReason
		CMP    EAX    ,  DLL_PROCESS_ATTACH  ;   equ 1        загрузка DLL в процесс
	       je    $_ATTACH_
	       ;---
		CMP    EAX    ,  DLL_THREAD_ATTACH      ;   equ 2       загрузка  DLL в поток
 	      je     $_ATTACH_
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
;                                             FILTR-PROC  GETMESSAGE  HOOK                                                 
;--------------------------------------------------------------------------------------------------------------------------
DLL_Mes_HOOK_proc                PROC       nCode:DWORD , wParam:DWORD , lParam:DWORD	
local  result:DWORD								 
;-
        invoke   CallNextHookEx  ,  HHOOK_Mes , nCode , wParam , lParam  
        MOV   result , EAX           
        ;-          	 
        .IF nCode  ==   HC_ACTION 
       
                mov  EBX ,   lParam    ;  addr   MSG
                   ;--------------
                   .if   [ EBX + MSG.message ]  ==  WM_CHAR
               
                         LEA   ECX  ,   offset  String_WH_GETMESSAGE   ; "WH_GETMESSAGE "
                         add  ECX  ,    count
                    
                         mov    AL   ,   byte ptr [ ECX ]
                         MOV   byte ptr [ EBX +  MSG.wParam ]   ,  AL  ;--  копирую символ в wParam
                                    
                                  inc  count                   
                                 .if  count >   14   ; длина строки "WH_GETMESSAGE " в байтах
                         		   Mov  count  ,  NULL
                                 .endif 
                    	       					  	
                   .endif 
                   ;--------------
        .ENDIF                        		      
;-     
mov  EAX  , result
RET   12
DLL_Mes_HOOK_proc                  ENDP
;--------------------------------------------------------------------------------------------------------------------------
;                                                    SET  HOOK  GETMESSAGE                                                            
;--------------------------------------------------------------------------------------------------------------------------
DLL_SET_HOOK_proc                PROC   export          hWnd1:DWORD  	 
;-
   
        mMOV   HWND_Look   ,  hWnd1
        ;-
        
        invoke   SetWindowsHookEx  ,  WH_GETMESSAGE  ,   DLL_Mes_HOOK_proc ,\
 						  HINST_DLL   ,   NULL
          Mov  HHOOK_Mes  ,   Eax
;-
RET  4
DLL_SET_HOOK_proc               ENDP
;--------------------------------------------------------------------------------------------------------------------------
;                                                    UNSET    HOOK       MES                                                         
;--------------------------------------------------------------------------------------------------------------------------
DLL_UNSET_HOOK_proc                PROC   export      
;-
   
 	invoke    UnhookWindowsHookEx  ,   HHOOK_Mes
                 		     
;-
RET  
DLL_UNSET_HOOK_proc               ENDP
;--------------------------------------------------------------------------------------------------------------------------
;###################################################################
END DLLENTRY@12

