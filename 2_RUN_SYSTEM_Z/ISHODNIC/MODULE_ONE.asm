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
 MODULE_CREATE_CHILD  PROTO   ParentHWND:DWORD
MODULE_TIMER_proc     PROTO      hWnd1 :dword , uMsg:dword , uID:dword , uTime:dword 
MODULE_GET_TEXT_proc     PROTO     hWnd1 :dword  ,  uParams :dword
;###########################################################
EXTERN    HINST:DWORD 

;###########################################################
;data--data--data--data--data--data--data--data--data--data--     PROC
;----------------------------------------------------------------------------------------------
.DATA
;-
LISTBOX_CLASS         DB    "LISTBOX",0
String_DIV            DB   "    ==>>    ",0
NULL_STRING               DB  0 , 0 , 0 , 0
;---
;##############################################################
;code--code--code--code--code--code--code--code--code--code-- PROC
;--------------------------------------------------------------------------------------------------
.CODE 
START: 
;----------------------------------------------------------------------------------------------------------
;                                      CREATE   ELEMENT                                                               
;---------------------------------------------------------------------------------------------------------- 
MODULE_CREATE_CHILD  PROC   ParentHWND:DWORD
;-    LIST
     invoke   CreateWindowEx  , WS_EX_CLIENTEDGE  , \
                                                   addr  LISTBOX_CLASS , addr  NULL_STRING ,\
                	                                	WS_CHILD + WS_VISIBLE   ,\
                	                                  	  20  ,20  , 750  , 450   ,  \
                		                             ParentHWND  ,  1   ,  HINST ,  NULL	
                       		                             
;-   TIMER 
       invoke   SetTimer  ,  ParentHWND  ,  1  ,  1000 ,  MODULE_TIMER_proc    
;-
RET  4 
MODULE_CREATE_CHILD   ENDP
;----------------------------------------------------------------------------------------------------------
;                                        TIMER  PROC                                                                    
;---------------------------------------------------------------------------------------------------------- 
MODULE_TIMER_proc     PROC       hWnd1 :dword , uMsg:dword , uID:dword , uTime:dword
;-

 invoke   SendDlgItemMessage  ,  hWnd1 , 1 , LB_RESETCONTENT , NULL  ,  NULL
                   ;------------------------------------------------------  
          INVOKE    EnumWindows  ,  MODULE_GET_TEXT_proc   ,  hWnd1  
                   ;------------------------------------------------------  
                                    
;-
$_FINISH_:
ret  16
MODULE_TIMER_proc     ENDP
;----------------------------------------------------------------------------------------------------------
;                                          GET   FILE   NAME                                                            
;---------------------------------------------------------------------------------------------------------- 
MODULE_GET_TEXT_proc     PROC    hWnd1 :dword  ,  uParams :dword
local  _Rect  :RECT
local  _TextWindow[256]:BYTE
local  _TextClass[256]: Byte
;-       
      invoke   IsIconic   ,  hWnd1                         ; проверка на свернутость
       cmp   EAX  ,  NULL
  jne  $_FINISH_             
      invoke   IsWindowVisible  , hWnd1               ; проверка на видимость 
       cmp   EAX  ,  NULL
  JE    $_FINISH_   
                                                       
   invoke      GetWindowRect    , hWnd1  , addr  _Rect  ; проверка на нулевой размеры
       mov          EAX      ,     _Rect.left
     CMP           EAX      ,      _Rect.right
 JE   $_FINISH_
       mov           EAX      ,     _Rect.top
     CMP            EAX       ,      _Rect.bottom
 JE    $_FINISH_                 
       ;----------------------------------
       invoke   RtlZeroMemory  ,  addr  _TextWindow  ,  256
       invoke   RtlZeroMemory  ,  addr  _TextClass  ,  256       
       ;----
       invoke   GetClassName ,  hWnd1  , addr  _TextClass , 255
       invoke   GetWindowText  , hWnd1 , addr  _TextWindow , 255
       ;-
           invoke     lstrcat   ,  addr  _TextClass  ,   addr  String_DIV
           invoke     lstrcat    , addr  _TextClass  ,   addr  _TextWindow
       ;---------------------------------
  invoke   SendDlgItemMessage  ,  uParams , 1 , LB_ADDSTRING , NULL  ,  addr  _TextClass
;-
$_FINISH_:
MOV  EAX  ,  TRUE
RET  8
MODULE_GET_TEXT_proc     ENDP     
END 









