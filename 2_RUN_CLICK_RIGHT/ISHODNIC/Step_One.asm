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
  WS_EX_LAYERED     EQU    0080000h
  LWA_ALPHA               EQU      00000002h                              
;###########################################################
MAIN_WINDOW_PROC     PROTO   :DWORD ,  :DWORD , :DWORD ,  :DWORD 
MODULE_LAYER_proc         PROTO       hWnd1:DWORD 
;##########################################################
LAYERED_WINDOW    typedef   PROTO    :DWORD ,  :DWORD , :DWORD ,  :DWORD 
PTR_LAYERED_WINDOW    typedef     PTR   LAYERED_WINDOW 

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
;-
USER_32_STR          DB  "USER32.dll",0
USER_32                     DWORD     NULL
SetLayeredWindowAttributes_STR    DB   "SetLayeredWindowAttributes",0
SetLayeredWindowAttributes      PTR_LAYERED_WINDOW      0   
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
           invoke  CreateWindowEx  , NULL   , addr String_CLASS , addr  String_CAPTION ,\
                		WS_OVERLAPPEDWINDOW      ,   300   , 300 , 500  ,  500  ,  \
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
      Mov  _Struct_WNDCLASS.cbClsExtra    ,    null            ; дополнительна€ пам€ть дл€ класса
      Mov  _Struct_WNDCLASS.cbWndExtra   ,   null            ; дополнительна€ пам€ть дл€  окна
              Mov   Eax  ,  HINST
      Mov  _Struct_WNDCLASS.hInstance     ,    Eax         ;  handle   приложени€

      Mov  _Struct_WNDCLASS.lpszMenuName    ,    null ;  идентификатор меню
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
             
               invoke   CreateSolidBrush  , 00F228B7h  ;  возвратит идентификатор  кисти
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
LOCAL   _Blend:DWORD                  	                	                    	                			      
;-
 	                                  CMP     MESG    ,   WM_RBUTTONDOWN
 	                              JE    WMRBUTTONDOWN	                                                                                                                                                                                                                                           
                                            CMP     MESG    ,    WM_CREATE
                                       JE      WMCREATE                 
                                            CMP     MESG    ,     WM_DESTROY
                                      JE       WMDESTROY     
    	
;----                                         
DEF_:
               invoke   DefWindowProc ,  hWnd_   ,   MESG  ,  wParam , lParam  
                jmp    FINISH
;----                             
WMRBUTTONDOWN:
                             invoke   GetWindowLong   ,  hWnd_ ,  GWL_EXSTYLE
                             OR   EAX  ,   WS_EX_LAYERED
                             invoke   SetWindowLong  ,  hWnd_  ,  GWL_EXSTYLE  ,  EAX
                             ;-------------------------------------
                             mov   _Blend  ,  NULL
            $_CIKL_:      
                             invoke   SetLayeredWindowAttributes   ,  hWnd_  ,  null ,  _Blend   ,  LWA_ALPHA
                             ADD   _Blend  ,  5
                             invoke  UpdateWindow ,  hWnd_
                             invoke   Sleep  ,  20
                             cmp   _Blend   ,  255
                        JB      $_CIKL_     
                            ;---------------------------------------delete  style
                             invoke   GetWindowLong   ,  hWnd_ ,  GWL_EXSTYLE
                             XOR     EAX  ,   WS_EX_LAYERED
                             invoke   SetWindowLong  ,  hWnd_  ,  GWL_EXSTYLE  ,  EAX
                            
                                                                                     
                 jmp  FINISH
WMCREATE:
                      ;-
                        
                                invoke  LoadLibrary  ,  addr  USER_32_STR      
                                   mov  USER_32  ,   EAX     
                                invoke  GetProcAddress  ,  USER_32  ,  addr   SetLayeredWindowAttributes_STR  
                                
                                mov  SetLayeredWindowAttributes  ,  EAX     
                                                                                                                                       
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

