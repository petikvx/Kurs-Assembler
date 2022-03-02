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
MODULE_GET_ICON_proc     PROTO     hWnd1 :dword  ,  hWndFind :dword
MODULE_CLASS_proc     PROTO    hWnd1 :dword  ,  hWndFind :dword
;###########################################################
EXTERN    HINST:DWORD 

;###########################################################
;data--data--data--data--data--data--data--data--data--data--     PROC
;----------------------------------------------------------------------------------------------
.DATA
;-
LISTBOX_CLASS         DB    "LISTBOX",0
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
                	                                  	  100  ,100  , 300  , 200   ,  \
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
local _Point  :POINT
local  _hwnd :DWORD
;-
                     invoke   GetCursorPos  ,  addr  _Point
                     invoke   WindowFromPoint ,  _Point.x  , _Point.y                     
                      CMP   EAX  ,   NULL
                   JE    $_FINISH_    
                         MOV    _hwnd  ,  EAX      
                      invoke   IsWindow  ,  _hwnd    ; если  это дескриптор окна
                        CMP   EAX  ,   NULL
                   JE    $_FINISH_                                                           

                                              ; сброс  содержимого   лист-бокса      
             invoke    SendDlgItemMessage     ,  hWnd1  , 1 , LB_RESETCONTENT  , NULL , NULL 
; -----------  Get   Parent                                                                        
                 mov  EAX  , _hwnd
                ;---------------------------------------------------------------------------------------------  
      @@:            
                      mov  _hwnd , EAX                        
                    INVOKE  MODULE_CLASS_proc ,      hWnd1 , _hwnd ; заполним LISTBOX
                    ;---
                         
                       invoke     GetParent   ,   _hwnd 
                       cmp  eax  ,  null
                   jne   @B    
                   ;------------------------------------------------------  GET   ICON   
          INVOKE  MODULE_GET_ICON_proc     ,  hWnd1  ,  _hwnd    
                   ;------------------------------------------------------  
                                    
;-
$_FINISH_:
ret  16
MODULE_TIMER_proc     ENDP
;----------------------------------------------------------------------------------------------------------
;                                          GET   ICON                                                                      
;---------------------------------------------------------------------------------------------------------- 
MODULE_GET_ICON_proc     PROC     hWnd1 :dword  ,  hWndFind :dword
;-
              invoke   SendMessage  ,   hWndFind   ,   WM_GETICON , ICON_SMALL , 0
                cmp   EAX ,  null
             jne    @F
            ;-----------------------
              invoke   SendMessage  ,   hWndFind   ,   WM_GETICON ,   ICON_BIG  ,  0
               cmp   EAX  ,  null
             jne    @F
             ;-----------------------
              invoke    GetClassLong   ,    hWndFind   ,  GCL_HICONSM
              cmp   EAX  , null
           jne    @F
  
              invoke     GetClassLong    ,    hWndFind   ,   GCL_HICON
              cmp   EAX  , null
           jne    @F        
           JMP    $_FINISH_     
@@:

                invoke   SendMessage  ,   hWnd1  ,   WM_SETICON ,   ICON_BIG  ,   EAX              
;-
$_FINISH_:
RET   8             
MODULE_GET_ICON_proc      ENDP   
;----------------------------------------------------------------------------------------------------------
;                                          GET   FILE   NAME                                                            
;---------------------------------------------------------------------------------------------------------- 
MODULE_CLASS_proc     PROC    hWnd1 :dword  ,  hWndFind :dword
local  _NameFile[256]:BYTE
;-
       invoke   RtlZeroMemory  ,  addr  _NameFile  ,  256
       ;----
       invoke   GetClassName   ,  hWndFind  , addr  _NameFile , 255
       ;---------------------------------
  invoke   SendDlgItemMessage  ,  hWnd1 , 1 , LB_ADDSTRING , NULL  ,  addr  _NameFile 


;-
$_FINISH_:
RET  8
MODULE_CLASS_proc     ENDP     
END 









