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
MAIN_WINDOW_PROC     PROTO   :DWORD ,  :DWORD , :DWORD ,  :DWORD 
;###########################################################
;data--data--data--data--data--data--data--data--data--data--     PROC
;----------------------------------------------------------------------------------------------
.DATA
HINST        DWORD      NULL
HWND_WIN        DWORD     NULL
;-
String_CLASS              DB    "MY_WINDOW",0  
String_CAPTION             DB  "MY_CAPTION",0
;-
MSG_WIN        MSG      <0>

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
                invoke    CreateWindowEx   ,  Null  ,   addr    String_CLASS   ,  addr  String_CAPTION  , \
                		   WS_OVERLAPPEDWINDOW,\
                		    100 , 100 ,  500 ,  500  , \
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
;                                    GET   POINT  SCREEN                                                        
;---------------------------------------------------------------------------------------------------------- 
MY_REGISTER_CLASS  PROC   
local  _Struct_WNDCLASS : WNDCLASS  
;-
      Mov  _Struct_WNDCLASS.style               ,       NULL               ;  стиль  окна
            ;  Mov   Eax  ,  
      Mov  _Struct_WNDCLASS.lpfnWndProc       ,     MAIN_WINDOW_PROC   ; процедура окна
      Mov  _Struct_WNDCLASS.cbClsExtra     ,    null            ; дополнительная память для класса
      Mov  _Struct_WNDCLASS.cbWndExtra   ,   null            ; дополнительная память для  окна
              Mov   Eax  ,  HINST
      Mov  _Struct_WNDCLASS.hInstance     ,       Eax         ;  handle   приложения

      Mov  _Struct_WNDCLASS.lpszMenuName     ,    NULL   ;  идентификатор меню
      Mov  _Struct_WNDCLASS.lpszClassName   ,     offset  String_CLASS  ;   адрес строки класса
   ;-
            invoke   LoadIcon  ,   NULL  ,    IDI_ASTERISK	                 
      Mov  _Struct_WNDCLASS.hIcon       ,      Eax
         ;-
            invoke   LoadCursor  ,  NULL  ,   IDC_IBEAM
      Mov  _Struct_WNDCLASS.hCursor      ,   Eax
         ;-
         ;   invoke   CreateSolidBrush  ,  0000FFh                       ;  возвратит идентификатор  кисти
              invoke    GetStockObject    ,  LTGRAY_BRUSH	
      Mov  _Struct_WNDCLASS.hbrBackground     ,  Eax
;==============   
	      invoke  RegisterClassA        ,   addr     _Struct_WNDCLASS             
;==============  
ret  
MY_REGISTER_CLASS   ENDP
;---------------------------------------------------------------------------------------------------------------------------
;                                           WINDOW        PROCEDURE                                                              
;---------------------------------------------------------------------------------------------------------------------------
MAIN_WINDOW_PROC     PROC   USES  EBX   ESI  EDI  \
                      			      hWnd_  :DWORD , MESG :DWORD , wParam :DWORD ,  lParam:DWORD 
;-
                                                     
                                            CMP     MESG    ,     WM_DESTROY
                                      JE      WMDESTROY     
;----                                         
               invoke   DefWindowProc ,  hWnd_   ,   MESG  ,  wParam , lParam  
               jmp      FINISH
;----                                         
WMDESTROY:
              invoke    PostQuitMessage ,  False
 
;- 
FINISH:
RET  16                      					  
MAIN_WINDOW_PROC     ENDP
;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
END  START

