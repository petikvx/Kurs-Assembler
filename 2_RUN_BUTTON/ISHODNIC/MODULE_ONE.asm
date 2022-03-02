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
MODULE_SUB_BUTTON_proc   PROTO   hWnd1:DWORD  ,   uMsg: DWORD  ,\  
						wParam:DWORD , lParam:DWORD
MODULE_CREATE_BUTTON   PROTO   ParentHWND:DWORD
MODULE_REGISTER_CLASS  PROTO
;###########################################################
EXTERN    HINST:DWORD 

;###########################################################
;data--data--data--data--data--data--data--data--data--data--     PROC
;----------------------------------------------------------------------------------------------
.DATA
;-
MY_BUTTON_CLASS         DB    "MY_BUTTON_CLASS",0
NULL_STRING               DB  0 , 0 , 0 , 0
;---
UP_BRUSH                   DD   NULL
DOWN_BRUSH              DD   NULL
MAIN_BRUSH                DD      NULL 
;-

;##############################################################
;code--code--code--code--code--code--code--code--code--code-- PROC
;--------------------------------------------------------------------------------------------------
.CODE 
START: 
;----------------------------------------------------------------------------------------------------------
;                                      CREATE   ELEMENT                                                               
;---------------------------------------------------------------------------------------------------------- 
MODULE_CREATE_BUTTON   PROC   ParentHWND:DWORD
local    _ButtonHWND   :DWORD  
;-    регистрация нового класса
      CALL  MODULE_REGISTER_CLASS 
      ;----  создание окна
     invoke  CreateWindowEx  , 0 , \
                                                   addr  MY_BUTTON_CLASS , addr  NULL_STRING ,\
                	                                	WS_CHILD + WS_VISIBLE   ,\
                	                                  	  100  ,150  , 120  , 40   ,  \
                		                             ParentHWND  ,  1  ,  HINST ,  NULL	
                       		                             
          mov   _ButtonHWND  , EAX
          
          ;------------- SET   NEW  PROC
          invoke  CreateRoundRectRgn  ,    0 ,  0 ,  120 , 40   ,   12 , 12
          invoke  SetWindowRgn    ,   _ButtonHWND  ,    EAX      , TRUE  
 
;-
RET  4 
MODULE_CREATE_BUTTON   ENDP
;----------------------------------------------------------------------------------------------------------
;                                      SUB    PROC                                                                         
;---------------------------------------------------------------------------------------------------------- 
MODULE_SUB_BUTTON_proc       PROC    USES  EBX   ESI  EDI  \
			   hWnd1:DWORD  ,   uMsg: DWORD  , wParam:DWORD , lParam:DWORD	
local  _PaintStruct :PAINTSTRUCT	
local  _Point  :POINT	   
;-
                           CMP      uMsg  ,  WM_PAINT
                      JE     WMPAINT  
                           CMP      uMsg  ,  WM_LBUTTONDOWN
                      JE     WMLBUTTONDOWN   
                           CMP      uMsg  ,  WM_LBUTTONUP
                      JE     WMLBUTTONUP                                                 
;----                                         
DEF_:
             invoke   DefWindowProc ,   hWnd1  ,   uMsg  ,  wParam , lParam  
                jmp    $_FINISH_
;----                                           
 WMLBUTTONDOWN:
                invoke     SetCapture  , hWnd1 
                        mov  EAX  ,   DOWN_BRUSH
                MOV     MAIN_BRUSH  , EAX                
                invoke    InvalidateRect  , hWnd1 ,  NULL  , TRUE
             jmp   $_FINISH_ 
             
 WMLBUTTONUP:  
                invoke    ReleaseCapture
                        mov  EAX  ,   UP_BRUSH                         
                MOV     MAIN_BRUSH  , EAX
                invoke    InvalidateRect  , hWnd1 ,  NULL  , TRUE   
 

             jmp   $_FINISH_       
 WMPAINT:
                invoke    BeginPaint  ,  hWnd1  , addr  _PaintStruct
                ;-
           invoke    FillRect  ,  _PaintStruct.hdc , addr  _PaintStruct.rcPaint , MAIN_BRUSH
                ;-
                invoke    EndPaint    ,  hWnd1  , addr  _PaintStruct
             jmp  $_FINISH_
;-
$_FINISH_:						
RET   16						
MODULE_SUB_BUTTON_proc       ENDP						 
;----------------------------------------------------------------------------------------------------------
;                                   REGISTER    CLASS                                                                 
;---------------------------------------------------------------------------------------------------------- 
MODULE_REGISTER_CLASS  PROC   
local  _Struct_WNDCLASS : WNDCLASS  
;-     
      Mov  _Struct_WNDCLASS.style          ,       NULL              ;  стиль  окна
            ;    ,  
      Mov  _Struct_WNDCLASS.lpfnWndProc  ,  MODULE_SUB_BUTTON_proc ; процедура окна
      Mov  _Struct_WNDCLASS.cbClsExtra    ,    null        ; дополнительная память для класса
      Mov  _Struct_WNDCLASS.cbWndExtra   ,   null        ; дополнительная память для  окна
              Mov   Eax  ,  HINST
      Mov  _Struct_WNDCLASS.hInstance     ,    Eax         ;  handle   приложения

      Mov  _Struct_WNDCLASS.lpszMenuName    ,    NULL ;  идентификатор меню
      Mov  _Struct_WNDCLASS.lpszClassName, offset  MY_BUTTON_CLASS;адрес строки класса
   ;-
            invoke   LoadIcon  ,   HINST  ,    NULL	  ;  load Icon                  
      Mov  _Struct_WNDCLASS.hIcon       ,      Eax

         ;-
            invoke   LoadCursor  ,  NULL  ,   IDC_ARROW
      Mov  _Struct_WNDCLASS.hCursor      ,   Eax
         ;-
               invoke   CreateSolidBrush  , 0000FFh
                 mov  DOWN_BRUSH  ,  Eax
               invoke   CreateSolidBrush  , 00FF00h  ;  возвратит идентификатор  кисти
                 mov  UP_BRUSH   ,  Eax       
                 mov  MAIN_BRUSH  , EAX 
      Mov  _Struct_WNDCLASS.hbrBackground     ,  Eax
;==============   

	      invoke  RegisterClass       ,   addr     _Struct_WNDCLASS             
;==============  
ret  
MODULE_REGISTER_CLASS    ENDP
END 









