        .386
        .model flat,stdcall
  option   casemap:none
                        include C:\masm32\INCLUDE\WINDOWS.INC
                        include C:\masm32\INCLUDE\KERNEL32.INC 
                        include C:\masm32\INCLUDE\USER32.INC
                        include   C:\masm32\INCLUDE\SHELL32.INC      ;shell32 
                        include C:\masm32\INCLUDE\ADVAPI32.INC 
                        include   C:\masm32\INCLUDE\GDI32.INC                                                
                        include  my.inc
                                                                     
                        includelib C:\masm32\lib\comctl32.lib
                        includelib C:\masm32\lib\user32.lib
                        includelib C:\masm32\lib\gdi32.lib
                        includelib  C:\masm32\lib\shell32.lib                ;shell32
                        includelib C:\masm32\lib\kernel32.lib                
                        includelib C:\masm32\lib\user32.lib
                        includelib C:\masm32\lib\advapi32.lib    
;###########################################################
MODULE_ADD_proc            PROTO   hWnd1:DWORD   ,  hIcon:DWORD
MODULE_MODIFY_proc     PROTO   hWnd1:DWORD    ,  hIcon:DWORD
MODULE_DELETE_proc     PROTO   hWnd1:DWORD   

;###########################################################
EXTERN    HINST:DWORD 
EXTERN    WM_PRIVATE_MESSAGE  :DWORD
;###########################################################
;data--data--data--data--data--data--data--data--data--data--     PROC
;----------------------------------------------------------------------------------------------
.DATA
;-
String_ICON              DB  "TRAY Icon",0
NULL_STRING               DB  0 , 0 , 0 , 0
;---
;##############################################################
;code--code--code--code--code--code--code--code--code--code-- PROC
;----------------------------------------------------------------------------------------------------------------
.CODE 
START: 
;----------------------------------------------------------------------------------------------------------
;                                                   ADD                                                                       
;----------------------------------------------------------------------------------------------------------
MODULE_ADD_proc  PROC   hWnd1:DWORD   ,  hIcon:DWORD
local  _icon_Notify   :NOTIFYICONDATA 
;-   
                   mov   _icon_Notify.cbSize   ,  size  NOTIFYICONDATA
                mMOV   _icon_Notify.hwnd   ,    hWnd1
                   mov    _icon_Notify.uFlags  ,  NIF_ICON  + NIF_MESSAGE + NIF_TIP
                   MOV    _icon_Notify.uID   ,    10
                   ;-----  делаем подсказку
                   invoke   RtlZeroMemory  ,  addr    _icon_Notify.szTip    ,    64 
                             invoke  lstrlen  ,  addr  String_ICON
                   invoke   RtlMoveMemory , addr    _icon_Notify.szTip   ,  addr  String_ICON , EAX
                   ;-----------------------------
                 mMOV   _icon_Notify.uCallbackMessage  ,  WM_PRIVATE_MESSAGE                                   
                  ;-----
                        invoke  LoadIcon ,  HINST  , 102
                   mov   _icon_Notify.hIcon    ,  eax
                   ;----
                
                    invoke   Shell_NotifyIconA   ,   NIM_ADD  ,   addr   _icon_Notify 
;-
RET   8
MODULE_ADD_proc  ENDP
;----------------------------------------------------------------------------------------------------------
;                                                   MODIFY                                                                  
;----------------------------------------------------------------------------------------------------------
MODULE_MODIFY_proc  PROC   hWnd1:DWORD   ,  hIcon:DWORD
local  _icon_Notify   :NOTIFYICONDATA 
;-
                   mov   _icon_Notify.cbSize   ,  size  NOTIFYICONDATA
                mMOV   _icon_Notify.hwnd   ,    hWnd1
                   mov    _icon_Notify.uFlags  ,  NIF_ICON  + NIF_MESSAGE + NIF_TIP
                   MOV    _icon_Notify.uID   ,    10
                   ;-----  делаем подсказку
                   invoke   RtlZeroMemory  ,  addr    _icon_Notify.szTip    ,    64 
                             invoke  lstrlen  ,  addr  String_ICON
                   invoke   RtlMoveMemory , addr    _icon_Notify.szTip   ,  addr  String_ICON , EAX
                   ;-----------------------------
                 mMOV   _icon_Notify.uCallbackMessage  ,  WM_PRIVATE_MESSAGE                                   
                  ;-----
                       
                 mMOV   _icon_Notify.hIcon    ,  hIcon
                   ;----
                
                    invoke   Shell_NotifyIconA   ,   NIM_MODIFY	  ,   addr   _icon_Notify    
;-
RET   8
MODULE_MODIFY_proc  ENDP
;----------------------------------------------------------------------------------------------------------
;                                              DELETE                                                                       
;----------------------------------------------------------------------------------------------------------
MODULE_DELETE_proc   PROC   hWnd1:DWORD  
local  _icon_Notify   :NOTIFYICONDATA 
;-   
                     mov   _icon_Notify.cbSize   ,  size  NOTIFYICONDATA
                mMOV   _icon_Notify.hwnd   ,    hWnd1
                   mov    _icon_Notify.uFlags  ,  NIF_ICON   
                   mov   _icon_Notify.uID   ,    10
                                   
                    invoke   Shell_NotifyIconA   ,   NIM_DELETE  ,   addr   _icon_Notify   
;-
RET   4
MODULE_DELETE_proc  ENDP
END 









