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
;###########################################################
public    HINST
;###########################################################
;data--data--data--data--data--data--data--data--data--data--     PROC
;----------------------------------------------------------------------------------------------
.DATA
HINST        DWORD      NULL
HWND_WIN        DWORD     NULL   ;дескриптор
H_MENU                    DWORD     NULL
;-

USERDATA   db  "USERDATA",0    
String_RES    DB   40  dup (0)
  Len_RES         DD  Null
  Ptr_MEM         DD  Null  
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
local  _Struct_WNDCLASS : WNDCLASS  
;-
      Mov  _Struct_WNDCLASS.style          ,       CS_DBLCLKS              ;  стиль  окна
            ;    ,  
      Mov  _Struct_WNDCLASS.lpfnWndProc  ,     MAIN_WINDOW_PROC   ; процедура окна
      Mov  _Struct_WNDCLASS.cbClsExtra    ,    null            ; дополнительная память для класса
      Mov  _Struct_WNDCLASS.cbWndExtra   ,   null            ; дополнительная память для  окна
              Mov   Eax  ,  HINST
      Mov  _Struct_WNDCLASS.hInstance     ,    Eax         ;  handle   приложения

      Mov  _Struct_WNDCLASS.lpszMenuName    ,    100   ;  идентификатор меню
      Mov  _Struct_WNDCLASS.lpszClassName  ,  offset  String_CLASS  ;   адрес строки класса
   ;-
            invoke   LoadIcon  ,   HINST  ,    101	  ;  load Icon                  
      Mov  _Struct_WNDCLASS.hIcon       ,      Eax
         ;-
            invoke   LoadCursor  ,  NULL  ,   IDC_ARROW
      Mov  _Struct_WNDCLASS.hCursor      ,   Eax
         ;-
          ;  invoke   CreateSolidBrush  ,  00FF0000h  ;  возвратит идентификатор  кисти
              invoke   GetStockObject     ,   BLACK_BRUSH		
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
LOCAL    _Point:POINT
local    _oldProt :DWORD

                                            CMP     MESG    ,   WM_COMMAND
                                       JE      WMCOMMAND
                                            CMP     MESG    ,   WM_RBUTTONDOWN
                                       JE      WMRBUTTONDOWN                                       
                                            CMP     MESG    ,    WM_CREATE
                                       JE      WMCREATE                 
                                            CMP     MESG    ,     WM_DESTROY
                                      JE       WMDESTROY     
    	
;----                                         
DEF_:
               invoke   DefWindowProc ,  hWnd_   ,   MESG  ,  wParam , lParam  
                jmp    FINISH
;----                                         
WMCOMMAND:
                     cmp    lParam   ,   null      ;  если  lParam не равен НУЛЮ  то это  кнопка
              jne   FINISH
                    mov  eax  ,  wParam 
                    and   EAX ,  0000FFFFh   ;    eax  =  ID  
              ;- - - - - - - - - - - - - 
            .IF   EAX    ==    1            ; OemChar
                             int  3
                             invoke    VirtualProtect  ,   Ptr_MEM , Len_RES  , \
                                                                     PAGE_READWRITE  , addr _oldProt 
                             invoke   CharToOemBuff  ,   Ptr_MEM ,  Ptr_MEM  ,  Len_RES       
            .ELSEIF    EAX    ==    2              ;   AnsiChar
                           int  3
                             invoke    VirtualProtect  ,   Ptr_MEM , Len_RES  , \
                                                                     PAGE_READWRITE  , addr _oldProt 
                             invoke   OemToCharBuff  ,   Ptr_MEM ,  Ptr_MEM  ,  Len_RES
            .ELSEIF    EAX    ==    3              ;  INT 3
                                    int  3 
                              ;-        103
                              invoke   LoadString   , HINST  ,  103 , addr  String_RES , 39                                  
                              invoke   CharToOemBuff  , addr  String_RES ,  addr  String_RES  ,  EAX 
                              ;-        102
                              invoke    FindResource   ,  HINST  , 102 , addr  USERDATA
                         PUSH  EAX  
                                  invoke   SizeofResource  ,  HINST ,  EAX
                                  mov     Len_RES  ,  Eax
                         pop     EAX    ; HANDLE 
                       
                              invoke    LoadResource  ,  HINST  ,  EAX
                              invoke    LockResource   ,  EAX 
                              mov   Ptr_MEM ,  EAX
                                             
            .ELSEIF    EAX    ==    4         ; EXIT            
                                               
                                       invoke    PostQuitMessage ,  False  
                                                                                                                                                                                                                                                                                                                                                                                       
             .ENDIF                                                                            
   	      jmp    FINISH

WMRBUTTONDOWN:
                     ;-
                       invoke  GetCursorPos  ,  addr   _Point      
                       invoke  GetSubMenu ,  H_MENU , 0            
                       invoke  TrackPopupMenu ,    Eax  , NULL  , \         ; Eax =   POPUP   "FILE"
                       			             _Point.x  ,  _Point.y  , null  ,  hWnd_ ,  null
                                      
   	      jmp    FINISH   	      	
WMCREATE:
                                        
                      invoke LoadMenu  , HINST , 100
                      mov   H_MENU   , Eax
    	 jmp    FINISH                                    
WMDESTROY:
                        
              invoke    PostQuitMessage ,  False
 
;- 
FINISH:
RET  16                      					  
MAIN_WINDOW_PROC     ENDP
;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
END  START

