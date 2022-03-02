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
DLL_Shell_HOOK_proc     PROTO        nCode:DWORD , wParam:DWORD , lParam:DWORD
DLL_SET_HOOK_proc         PROTO         hWnd1:DWORD								       
;###################################################################
;data--data--data--data--data--data--data--data--data--data--data--data--data--data-- proc
;-------------------------------------------------------------------------------------------------------------------------
_EDATA SEGMENT DWORD PUBLIC USE32 'IDATA'
;---
         HINST_DLL                           DD          0
         SHABLON                            db  "%d",0
         CONTENER                          db  256 dup (0)
;---
_EDATA  ENDS
;===================================================================
_DATA SEGMENT DWORD PUBLIC USE32'DATA'         ;  GLOBAL  DATA
;---
        HWND_Look                        DD       NULL                 ; ours WINDOW  
        HHOOK_Shell                  DWORD    NULL            ;  HOOK  Shell
        
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
;                                                    SET   SHELL   HOOK                                                                 
;--------------------------------------------------------------------------------------------------------------------------
DLL_Shell_HOOK_proc                PROC       nCode:DWORD , wParam:DWORD , lParam:DWORD	
local  result:DWORD								 
;-
        invoke   CallNextHookEx  ,  HHOOK_Shell , nCode , wParam , lParam  
      MOV   result  , EAX           
      ;-          	  
       .IF nCode ==   HSHELL_WINDOWCREATED   ; событие создания окна       
                              ;;; wParam - хэндл активного окна;   lParam  =  TRUE/FALSE  ;  
                               
                ; файловый путь модуля
                invoke  GetWindowModuleFileName  ,  wParam , addr CONTENER , 255 
                
                       invoke   SendDlgItemMessage,  HWND_Look , 2 ,    WM_SETTEXT , 
                                                                                                           null ,  addr  CONTENER 
                ; идентификaтор процесса  
                invoke  GetCurrentProcessId  
                             
                       invoke wsprintf  ,  addr  CONTENER  ,  addr  SHABLON  ,  EAX
                       invoke   SendDlgItemMessage,  HWND_Look  , 3 ,   WM_SETTEXT ,\
                   				  	                                                null   ,   addr  CONTENER         
                   				  	                                                
         .ELSEIF  nCode ==  HSHELL_LANGUAGE    ; событие переключения языка клавиатуры
                                                                      ; lParam  =  хэндл раскладки клавиатуры 
                          	  invoke Beep ,  2000 , 100	        
                                                                                                                                     	  
                       invoke wsprintf  ,  addr  CONTENER  ,  addr  SHABLON  ,  lParam 
                       invoke   SendDlgItemMessage,  HWND_Look  , 3 ,   WM_SETTEXT ,\
                   				  	                                                null   ,   addr  CONTENER
       .ENDIF                        		     
;-     
mov  EAX  , result
RET   12
DLL_Shell_HOOK_proc                  ENDP
;--------------------------------------------------------------------------------------------------------------------------
;                                                    GLOBAL  HOOK    SHELL                                                            
;--------------------------------------------------------------------------------------------------------------------------
DLL_SET_HOOK_proc                PROC   export          hWnd1:DWORD  					
;-
   
        mMOV   HWND_Look   ,  hWnd1
        ;-
        
        invoke   SetWindowsHookEx  ,  WH_SHELL  ,   DLL_Shell_HOOK_proc ,\
 						  HINST_DLL   ,   NULL
          Mov  HHOOK_Shell ,   Eax
;-
RET  4
DLL_SET_HOOK_proc               ENDP
;--------------------------------------------------------------------------------------------------------------------------
;                                                    UNSET    HOOK       SHELL                                                        
;--------------------------------------------------------------------------------------------------------------------------
DLL_UNSET_HOOK_proc                PROC   export           							
;-
   
 	invoke    UnhookWindowsHookEx  ,   HHOOK_Shell
                 		     
;-
RET  
DLL_UNSET_HOOK_proc               ENDP
;--------------------------------------------------------------------------------------------------------------------------
;###################################################################
END DLLENTRY@12

