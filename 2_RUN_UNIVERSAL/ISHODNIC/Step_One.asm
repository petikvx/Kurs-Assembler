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
MODULE_TRANS_BITMAP_proc   PROTO   hWnd1:DWORD  ,   ptrTask_STRUCT: DWORD
MODULE_SCREEN_BITMAP_proc       PROTO   hWnd1:DWORD  ,   ptrTask_STRUCT: DWORD
;##########################################################


;###########################################################
public    HINST   
;###########################################################
;data--data--data--data--data--data--data--data--data--data--     PROC
;----------------------------------------------------------------------------------------------
.DATA
HINST        DWORD      NULL
HWND_WIN        DWORD     NULL   ;дескриптор
  
;-
String_CLASS              DB    "MY_WINDOW",0  
String_CAPTION             DB  "MY_CAPTION",0
BUTTON_CLASS         DB    "BUTTON",0
;-
MSG_WIN        MSG      <0>
;-
SHABLON            DB       "Width = %#08X ",0
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

 
	;---------------------------       
           invoke  CreateWindowEx  , NULL , addr String_CLASS , addr  String_CAPTION ,\
                		WS_OVERLAPPEDWINDOW	 ,  100  ,130  ,  500   ,  500   ,  \
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
             
               invoke   CreateSolidBrush  , 0000FFh  ;  возвратит идентификатор  кисти
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
local   _RoundRectRGN  , _RectRGN   , _ButtonRGN :DWORD          
local    _ButHWND :DWORD  
local   _Rect  :RECT 	  
local   _RectButton  :RECT 	      
local   _RectParent  :RECT    
local   _offset_left   :DWORD
local  _offset_top   :DWORD          	          	                    	                			      
;-
                                                                                                                                                                                                                                     
                                            CMP     MESG    ,    WM_CREATE
                                       JE      WMCREATE        
                                           CMP     MESG    ,    WM_COMMAND
                                       JE      WMCOMMAND                                        
                                                  
                                            CMP     MESG    ,     WM_DESTROY
                                      JE       WMDESTROY     
    	
;----                                         
DEF_:
               invoke   DefWindowProc ,  hWnd_   ,   MESG  ,  wParam , lParam  
                jmp    FINISH
;----                                       
WMCREATE:
                      ;-                                                        
           invoke  CreateWindowEx  , NULL ,   addr  BUTTON_CLASS , addr  BUTTON_CLASS ,\
                	                                  	WS_CHILD + WS_VISIBLE+ BS_DEFPUSHBUTTON		 ,  200  ,200  , 100  , 40   ,  \
                		                             hWnd_ ,  NULL  ,  HINST ,  NULL	
          mov   _ButHWND  , EAX
          
          ; определяем экранную координату  клиентской точки (0,0) родительского окна
           invoke SetRect  , addr  _Rect  , 0 , 0 ,  0 ,0          
           invoke  MapWindowPoints  ,   hWnd_  ,   NULL ,  addr  _Rect ,1
          ; определяем экранную координаты кнопки и родительского окна
         invoke  GetWindowRect,  _ButHWND  ,  addr  _RectButton    
         invoke  GetWindowRect,  hWnd_ ,  addr  _RectParent         
          ; переводим  экранную координаты кнопки и родительского окна        
          invoke  MapWindowPoints  ,  NULL,   hWnd_  , addr  _RectButton ,2         
          
          ; получаем разницу-смещение точки (0,0) для клиентской 
          ; и для общей части родительского окна
          mov  eax , _Rect.left          
          sub   eax , _RectParent.left
          mov _offset_left  ,  eax  ;смещение X координаты
          
          mov  eax , _Rect.top
          sub   eax , _RectParent.top
          mov _offset_top  ,  eax   ;смещение Y координаты     
           
          ; вносим изменения в структуру RECT по смещениям X  и  Y            
         invoke  OffsetRect ,  addr   _RectButton ,  _offset_left   ,    _offset_top     
              
          ; получаем  регион
              invoke    CreateRectRgn  ,    _RectButton.left , _RectButton.top , _RectButton.right   , _RectButton.bottom
           mov   _ButtonRGN  , EAX
           
         ;  invoke  OffsetRgn,  _ButtonRGN ,  _offset_left   ,    _offset_top     

                      invoke  CreateRectRgn    ,         50 ,   0 , 400 , 100   
                       mov   _RectRGN    ,   EAX          
                      invoke   CreateRoundRectRgn    ,  150  ,  150 ,  350 ,350  ,  12   , 12
                       mov  _RoundRectRGN   ,  EAX
             
        
                     invoke   CombineRgn   , _RoundRectRGN   , _RoundRectRGN  ,  _RectRGN  , RGN_OR
                      invoke  CreateRoundRectRgn  , 0 , 0 , 500 , 500 , 4 , 4
                                   
                       invoke   CombineRgn   , _RoundRectRGN   , _RoundRectRGN  ,  EAX , RGN_XOR     
                       invoke   CombineRgn  , _RoundRectRGN  , _RoundRectRGN , _ButtonRGN         , RGN_OR
                   invoke   SetWindowRgn   ,  hWnd_  , _RoundRectRGN  , TRUE
                    

                   		                             

    	 jmp    FINISH   
WMCOMMAND:
; int  3
                              invoke  GetDC  , hWnd_
                              mov  EDI  ,  EAX
                              invoke  CreateSolidBrush  , 00FF0000h
                              mov  ESI  , EAX
                                 invoke  CreateEllipticRgn  , 0 , 50 , 495, 450
                              invoke        FrameRgn    , EDI  , EAX , ESI ,    22 , 40               

                jmp   FINISH
    
WMDESTROY:
                        
              invoke    PostQuitMessage ,  False
 
;- 
FINISH:
RET  16                      					  
MAIN_WINDOW_PROC     ENDP
;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
END  START

