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
;-                                               left     top    ritht    bottom
SizeRECT_WIN               RECT <0       ,    0    ,    500    ,    500 >
 Task_STRUCT      PROGRAM_STRUCT   <0>        ; наша  рабочая структура
;-
VAR_BOOL                DD      FALSE
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
 invoke   AdjustWindowRectEx  , addr     SizeRECT_WIN     ,    WS_OVERLAPPEDWINDOW   ,  True , NULL
 mov    EBX  ,   SizeRECT_WIN.right 
     SUB       EBX  ,   SizeRECT_WIN.left
;   EBX   ;  длинна  окна
     ;--------
 mov  ECX  ,   SizeRECT_WIN.bottom    
     SUB      ECX  ,   SizeRECT_WIN.top
    ; ECX     высота окна
 
	;---------------------------       
           invoke  CreateWindowEx  , NULL , addr String_CLASS , addr  String_CAPTION ,\
                		WS_OVERLAPPEDWINDOW	 ,  100  ,100  ,  EBX  , ECX   ,  \
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
 	                                  CMP     MESG    , WM_TIMER
 	                              JE    WMTIMER   
 	                                  CMP     MESG    , WM_PAINT
 	                              JE    WMPAINT  	                                                                                                                                                                                                                                     
                                            CMP     MESG    ,    WM_CREATE
                                       JE      WMCREATE                 
                                            CMP     MESG    ,     WM_DESTROY
                                      JE       WMDESTROY     
    	
;----                                         
DEF_:
               invoke   DefWindowProc ,  hWnd_   ,   MESG  ,  wParam , lParam  
                jmp    FINISH
;----                                       
WMCREATE:
                      ;-                                                        
                                           invoke  GetSystemMetrics  ,    SM_CXSCREEN  
                                              mov   Task_STRUCT.uLEN  , EAX
                                          invoke  GetSystemMetrics  ,    SM_CYSCREEN   
                                              mov   Task_STRUCT.uHIG     ,  EAX      
                                    ;-------------------------    
                                        invoke   GetDC  ,  NULL
                                           mov   Task_STRUCT.uDESK_HDC    ,   EAX             ;  Desktop   HDC
                                        invoke   GetDC  , hWnd_ 
                                          mov    Task_STRUCT.uWIN_HDC  ,  EAX
                                        invoke   CreateCompatibleDC  ,      Task_STRUCT.uWIN_HDC
                                          mov    Task_STRUCT.uCOMP_HDC   ,  EAX
                                        invoke   CreateCompatibleBitmap  ,      Task_STRUCT.uWIN_HDC  ,\
                                        						                 Task_STRUCT.uLEN ,   Task_STRUCT.uHIG
                                          mov    Task_STRUCT.uComp_BITMAP   ,  EAX                                           
                                     ;--------------------------                                         
                             invoke   SelectObject    , Task_STRUCT.uCOMP_HDC  ,  Task_STRUCT.uComp_BITMAP                                   
                                                                                                                                                                        
                      ;-  = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - =
                              invoke   SetTimer   ,  hWnd_   ,  1  ,  100  ,  NULL
                      ;-  = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - =                      

                            INVOKE MODULE_SCREEN_BITMAP_proc         ,  hWnd_   ,  addr   Task_STRUCT

    	 jmp    FINISH   
WMTIMER:
                              
        .IF    VAR_BOOL  ==   FALSE
                                        invoke  GetKeyState  ,   53h  ;   "S"
                                 
                                            TEST     EAX  , 00000100h
                                        JZ  FINISH                  

                                       invoke  GetKeyState  ,  VK_CONTROL
                                 
                                            TEST     EAX  , 00000100h
                                        JZ  FINISH    
                                          invoke  GetKeyState  ,  VK_MENU 
                                          
                                            TEST     EAX  ,  00000100h
                                        JZ  FINISH                                            
                                              invoke Beep  , 3000 , 200
                                       ;-------------------------------
                                     MOV   VAR_BOOL   ,   TRUE
                                       ;-------------------------------
                                    
                               ;  делаем окно невидимым  но  сохраняем его   Z  order
                              invoke     SetWindowPos   ,  hWnd_  , HWND_NOTOPMOST ,  NULL , NULL , NULL , NULL , \
                                                                              SWP_NOMOVE + SWP_NOSIZE  +  SWP_NOZORDER+SWP_HIDEWINDOW
                                                                     ;----------------------------------------------------------
                                                      invoke     SendMessage  ,  HWND_BROADCAST  ,  WM_PAINT , 0 , 0 
                                                                                                          ;----------------------------------------------------------                     
                       INVOKE MODULE_TRANS_BITMAP_proc   ,   hWnd_  , addr   Task_STRUCT
                      ;---------- востанавливаем видимость окна 
                     invoke     SetWindowPos   ,  hWnd_  ,  HWND_NOTOPMOST ,  NULL , NULL , NULL , NULL , \
                                                                                                          SWP_NOMOVE + SWP_NOSIZE  +  SWP_NOZORDER+\
                                                                                                          SWP_SHOWWINDOW + SWP_FRAMECHANGED          	 
         .ELSEIF    VAR_BOOL  ==   TRUE
                                        invoke  GetKeyState  ,   53h                             ;   "S"
                                 
                                            TEST     EAX  , 00000100h
                                        JNZ  FINISH                  

                                        invoke  GetKeyState  ,  VK_CONTROL            ;ctrl
                                 
                                            TEST     EAX  , 00000100h
                                        JNZ  FINISH    
                                           invoke  GetKeyState  ,  VK_MENU               ; alt
                                          
                                            TEST     EAX  ,  00000100h
                                        JNZ  FINISH                                            
                                                                                        invoke Beep  , 2000 , 200
                                       ;-------------------------------
                                     MOV   VAR_BOOL   ,   FALSE
                                       ;-------------------------------
                                                   
                               ;  делаем окно невидимым  но  сохраняем его   Z  order
                              invoke     SetWindowPos   ,  hWnd_  ,   HWND_NOTOPMOST    ,  NULL , NULL , NULL , NULL , \
                                                                                  SWP_NOMOVE + SWP_NOSIZE  +  SWP_NOZORDER+SWP_HIDEWINDOW
                                                                      ;----------------------------------------------------------
                                                      invoke      SendMessage  ,  HWND_BROADCAST ,  WM_PAINT , 0 , 0 
                                                                                                          ;---------------------------------------------------------- 
                          INVOKE MODULE_SCREEN_BITMAP_proc         ,  hWnd_   ,  addr   Task_STRUCT
                          ;---------- востанавливаем видимость окна                                      
                            invoke     SetWindowPos   ,  hWnd_  ,  HWND_NOTOPMOST ,  NULL , NULL , NULL , NULL , \
                                                                                                          SWP_NOMOVE + SWP_NOSIZE  +  SWP_NOZORDER+\
                                                                                                          SWP_SHOWWINDOW + SWP_FRAMECHANGED                                         

                   .ENDIF  
    	 jmp    FINISH 
WMPAINT:
          invOKe    BitBlt   ,   Task_STRUCT.uWIN_HDC , 0, 0 ,  Task_STRUCT.uLEN  ,   Task_STRUCT.uHIG  , \
          									      Task_STRUCT.uCOMP_HDC	, 0 , 0 , SRCCOPY  
                                     invoke  ValidateRect  , hWnd_ ,  NULL
          jmp    FINISH 	                               
WMDESTROY:
                        
              invoke    PostQuitMessage ,  False
 
;- 
FINISH:
RET  16                      					  
MAIN_WINDOW_PROC     ENDP
;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
END  START

