          .386
        .model flat,stdcall
  option   casemap:none
                        include C:\masm32\INCLUDE\WINDOWS.INC
                        include C:\masm32\INCLUDE\KERNEL32.INC 
                        include C:\masm32\INCLUDE\USER32.INC
                        include C:\masm32\INCLUDE\ADVAPI32.INC 
                        include   C:\masm32\INCLUDE\GDI32.INC       
                        include    C:\masm32\INCLUDE\comdlg32.inc   
                        include   C:\masm32\INCLUDE\winmm.inc                                       
                        include  my.inc
                        
                        includelib  C:\masm32\lib\winmm.lib                                             
                        includelib C:\masm32\lib\comctl32.lib
                         includelib C:\masm32\lib\comdlg32
                        includelib C:\masm32\lib\user32.lib
                        includelib C:\masm32\lib\gdi32.lib
                        includelib C:\masm32\lib\kernel32.lib                
                        includelib C:\masm32\lib\user32.lib
                        includelib C:\masm32\lib\advapi32.lib      
;###########################################################
MAIN_WINDOW_PROC     PROTO   :DWORD ,  :DWORD , :DWORD ,  :DWORD 
 MODULE_CREATE_CHILD_proc       PROTO     hWnd1 :DWORD  

;###########################################################
public    HINST   
;###########################################################
;data--data--data--data--data--data--data--data--data--data--     PROC
;----------------------------------------------------------------------------------------------
.DATA
HINST        DWORD      NULL
HWND_WIN        DWORD     NULL   ;дескриптор
WIN_HDC          DWORD     NULL   ; контекст
;-
String_CLASS              DB    "MY_WINDOW",0  
String_CAPTION             DB  "MY_CAPTION",0
;-
MSG_WIN        MSG      <0>
;-
SHABLON            DB       "Width = %d   ,   Height  = %d",0
CONTENER         DB    256   dup (0)
;##############################################################
;code--code--code--code--code--code--code--code--code--code-- PROC
;--------------------------------------------------------------------------------------------------
.CODE  
START:
                invoke  GetModuleHandle  ,  Null 
                 mov    HINST   ,  EAX   
                    ;-        
                      CALL   MY_REGISTER_CLASS 
	                  cmp   EAX  ,  null
	              je   EXIT
	          ;-       
           invoke  CreateWindowEx  , NULL , addr String_CLASS , addr  String_CAPTION ,\
                		WS_OVERLAPPEDWINDOW ,   100 , 100 ,  500 ,  500  , \
                		NULL ,  NULL  ,  HINST ,  NULL	
                  ;-       
                  MOV   HWND_WIN  , EAX		
                  ;-	
                invoke  ShowWindow   ,  HWND_WIN   , TRUE  
                invoke  UpdateWindow ,  HWND_WIN      
                        								          
          ;====================
MSG_LOOP:
			   invoke   GetMessage  ,    addr  MSG_WIN  , null , null , null
			   CMP   Eax  ,  FALSE
		        JE    EXIT	   
		        
			   invoke   TranslateMessage  ,   addr   MSG_WIN 
			   invoke   DispatchMessage       , addr  MSG_WIN
	               JMP   MSG_LOOP
          ;====================	
EXIT:     
             invoke               ExitProcess        ,       Null
;----------------------------------------------------------------------------------------------------------
;                                   REGISTER    CLASS                                                                 
;---------------------------------------------------------------------------------------------------------- 
MY_REGISTER_CLASS  PROC   
local  _Struct_WNDCLASS : WNDCLASSEX  
;-    
      Mov  _Struct_WNDCLASS.cbSize        ,   size    WNDCLASSEX      
      Mov  _Struct_WNDCLASS.style          ,       CS_DBLCLKS              ;  стиль  окна
            ;    ,  
      Mov  _Struct_WNDCLASS.lpfnWndProc  ,     MAIN_WINDOW_PROC   ; процедура окна
      Mov  _Struct_WNDCLASS.cbClsExtra    ,    null            ; дополнительная память для класса
      Mov  _Struct_WNDCLASS.cbWndExtra   ,   null            ; дополнительная память для  окна
              Mov   Eax  ,  HINST
      Mov  _Struct_WNDCLASS.hInstance     ,    Eax         ;  handle   приложения

      Mov  _Struct_WNDCLASS.lpszMenuName    ,    NULL ;  идентификатор меню
      Mov  _Struct_WNDCLASS.lpszClassName  ,  offset  String_CLASS  ;   адрес строки класса
   ;-
            invoke   LoadIcon  ,   HINST  ,    101	  ;  load Icon                  
      Mov  _Struct_WNDCLASS.hIcon       ,      Eax
            invoke   LoadIcon  ,   HINST  ,    102	  ;  load Icon                      
      Mov  _Struct_WNDCLASS.hIconSm   ,      Eax
         ;-
            invoke   LoadCursor  ,  NULL  ,   IDC_ARROW
      Mov  _Struct_WNDCLASS.hCursor      ,   Eax
         ;-
             
               invoke   CreateSolidBrush  , 000000h  ;  возвратит идентификатор  кисти
          ;    invoke   GetStockObject     ,   BLACK_BRUSH
        
      Mov  _Struct_WNDCLASS.hbrBackground     ,  Eax
;==============   
	      invoke  RegisterClassExA        ,   addr     _Struct_WNDCLASS             
;==============  
ret  
MY_REGISTER_CLASS   ENDP
;---------------------------------------------------------------------------------------------------------------------------
;                                           WINDOW        PROCEDURE                                                              
;---------------------------------------------------------------------------------------------------------------------------
MAIN_WINDOW_PROC     PROC   USES  EBX   ESI  EDI  \
                  	 hWnd_  :DWORD , MESG :DWORD , wParam :DWORD ,  lParam:DWORD                       			      
;-
LOCAL    _Paint_Struc: PAINTSTRUCT
local      _Rect   :RECT
local      _Brush  :DWORD 
 	    
                                            CMP     MESG    ,   WM_PAINT
                                       JE      WMPAINT 
                                            CMP     MESG    ,   WM_NCPAINT
                                       JE      WMNCPAINT                                                                                                                                                                                            
                                            CMP     MESG    ,    WM_CREATE
                                       JE      WMCREATE                 
                                            CMP     MESG    ,     WM_DESTROY
                                      JE       WMDESTROY     
    	
;----                                         
DEF_:
               invoke   DefWindowProc ,  hWnd_   ,   MESG  ,  wParam , lParam  
                jmp    FINISH
;----                             
WMNCPAINT:
                  invoke   PostMessage  ,  hWnd_   ,  WM_PAINT   ,   NULL  ,  1111h
                  invoke   DefWindowProc ,  hWnd_   ,   MESG  ,  wParam , lParam  

            
                 jmp   FINISH                                       
 WMPAINT:
          .IF     lParam  == 1111h  ;    послано  из WM_NCPAINT
                          ;-  РИСУЕТ РАМКУ  ЭЛЕМЕНТА УПРАВЛЕНИЯ РАЗНОГО ТИПА.
                                invoke  SetRect  ,  addr  _Rect  ,  200  ,  5  , 220 , 25   
                         invoke    DrawFrameControl  ,   WIN_HDC  , addr  _Rect , \
                                                          DFC_BUTTON  ,   DFCS_BUTTONCHECK  + DFCS_CHECKED 

                         ; ++++++++++++++++++++++++ 
           .ELSE
                         ;-FOCUS RECT
                invoke   BeginPaint  ,   hWnd_   , addr    _Paint_Struc
                ;=============================
                                 invoke  SetRect  , addr  _Rect  ,  30 , 30 , 150 , 80
                         invoke    DrawFocusRect  ,   _Paint_Struc.hdc  , addr  _Rect
                         ;-  CAPTION
                                 invoke  SetRect  , addr  _Rect  ,  10 , 130 ,400 , 160   
                         invoke    DrawCaption  ,  hWnd_  ,   _Paint_Struc.hdc  , addr  _Rect , \
                                                           DC_ACTIVE  + DC_ICON  + DC_TEXT + DC_GRADIENT
                         ;-   РИСУЕТ ПРЯМОУГОЛЬНИК
                                 invoke  SetRect  ,  addr  _Rect  ,  10  ,  180 , 70 , 210
                          invoke    DrawEdge  ,   _Paint_Struc.hdc   , addr   _Rect , \               ;1
                                                    EDGE_SUNKEN  ,   BF_RECT      
                                         ;-           
                                 invoke  SetRect  ,  addr  _Rect  ,  80  ,  180 , 150 , 210            ;2
                          invoke    DrawEdge  ,   _Paint_Struc.hdc   , addr   _Rect , \
                                                    EDGE_SUNKEN ,   BF_RECT     + BF_MIDDLE  
                                         ;-            
                                 invoke  SetRect  ,  addr  _Rect  ,  160  ,  180 , 230 , 210                                                         
                         invoke    DrawEdge  ,   _Paint_Struc.hdc   , addr   _Rect , \	       ;3
                                                    EDGE_RAISED  ,   BF_RECT            
                                         ;-               
                                 invoke  SetRect  ,  addr  _Rect  ,  240  ,  180 , 310 , 210                                                         
                         invoke    DrawEdge  ,   _Paint_Struc.hdc   , addr   _Rect , \	       ;4
                                                    EDGE_RAISED  ,   BF_RECT     + BF_MIDDLE   
                  ;------------   РИСУЕМ  ИКОНКУ
                                invoke   GetClassLong  ,   hWnd_  ,  GCL_HBRBACKGROUND  
                                mov    _Brush  ,  Eax
                                
                                invoke   GetClassLong  , hWnd_  , GCL_HICONSM	  
                         invoke    DrawIconEx  ,   WIN_HDC ,  250  ,  15 ,  EAX  , 30  ,  30 ,\
                                                                            null ,  _Brush  , null                                                          
                ;===============================      
                invoke   EndPaint    ,  hWnd_   ,  addr    _Paint_Struc
	.ENDIF			          
   	      jmp    FINISH   	      	
WMCREATE:
                      ;-
                                     invoke     GetWindowDC  ,   hWnd_   ;  ReleaseDC  
                                     mov   WIN_HDC  ,  Eax
                      ;-
                  
    	 jmp    FINISH                                    
WMDESTROY:
                        
              invoke    PostQuitMessage ,  False
 
;- 
FINISH:
RET  16                      					  
MAIN_WINDOW_PROC     ENDP
;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
END  START

