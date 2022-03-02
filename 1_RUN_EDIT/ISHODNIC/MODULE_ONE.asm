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
MODULE_SUB_EDIT_proc   PROTO   hWnd1:DWORD  ,   uMsg: DWORD  ,\  
						wParam:DWORD , lParam:DWORD


;###########################################################
EXTERN    HINST:DWORD 
PUBLIC    OLD_Proc_addr

;###########################################################
;data--data--data--data--data--data--data--data--data--data--     PROC
;----------------------------------------------------------------------------------------------
.DATA
;-
OLD_Proc_addr  DD   NULL
;-

;##############################################################
;code--code--code--code--code--code--code--code--code--code-- PROC
;--------------------------------------------------------------------------------------------------
.CODE 
START:  
;-------------------------------------------------------------------------------------------------------------------------------
;                                          PROC   EDIT                                                                                
;-------------------------------------------------------------------------------------------------------------------------------
MODULE_SUB_EDIT_proc       PROC    USES  EBX   ESI  EDI  \
			   hWnd1:DWORD  ,   uMsg: DWORD  , wParam:DWORD , lParam:DWORD
;-
                           CMP      uMsg  ,  WM_CHAR
                      JE     WMCHAR       
;----                                         
DEF_:
               invoke   CallWindowProc , OLD_Proc_addr  ,  hWnd1  ,   uMsg  ,  wParam , lParam  
                jmp    $_FINISH_
;----                                           
WMCHAR:
                  CMP  byte  ptr  wParam   ,  '5'
               je    WMDESTROY
                  CMP   byte ptr  wParam  ,   'T'
               je   $_CHAR_   
                  CMP   byte ptr  wParam  ,   't'     
               je   $_CHAR_
               ;-                 
               jmp   DEF_
      ;-----------         
     $_CHAR_:
      ;-----------         
                     mov   byte ptr      wParam  ,    '5'
     
               jmp   DEF_   
WMDESTROY:
                        invoke  GetParent  ,  hWnd1 
                        invoke  SendMessage  ,     EAX  ,  WM_DESTROY ,  NULL  , NULL        
;-
$_FINISH_:						
RET   16						
MODULE_SUB_EDIT_proc       ENDP						

END 









