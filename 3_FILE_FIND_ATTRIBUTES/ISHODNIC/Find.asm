          .386
        .model flat,stdcall
  option   casemap:none
                        include C:\masm32\INCLUDE\WINDOWS.INC
                        include C:\masm32\INCLUDE\KERNEL32.INC 
                        include C:\masm32\INCLUDE\USER32.INC
                        include   C:\masm32\INCLUDE\SHELL32.INC                          
                        include C:\masm32\INCLUDE\ADVAPI32.INC 
                        include   C:\masm32\INCLUDE\GDI32.INC       
                        include    C:\masm32\INCLUDE\comdlg32.inc  
                                                         
                        include  my.inc
                        ;include  Attributes.asm 
                        
                        includelib C:\masm32\lib\masm32.lib     
                         includelib C:\MASM32\LIB\ole32.lib         
                         includelib C:\masm32\lib\comdlg32
                        includelib C:\masm32\lib\user32.lib
                        includelib  C:\masm32\lib\shell32.lib
                        includelib C:\masm32\lib\gdi32.lib
                        includelib C:\masm32\lib\kernel32.lib                
                        includelib C:\masm32\lib\user32.lib
                        includelib C:\masm32\lib\advapi32.lib     
                         
;########################################################### 
 
GET_ATTRIBUTESS_proc    PROTO       hWnd_  :DWORD ,     ptrName_:DWORD                                         
;###########################################################
MAIN_WINDOW_PROC     PROTO   :DWORD ,  :DWORD , :DWORD ,  :DWORD 
												
;##########################################################
public    HINST   
;###########################################################
;data--data--data--data--data--data--data--data--data--data--     PROC
;----------------------------------------------------------------------------------------------
.DATA
HINST               DWORD      NULL
HWND_WIN        DWORD     NULL   ;дескриптор
;-
String_CLASS                  DB    "MY_WINDOW",0  
String_CAPTION               DB  "FIND ATTRIBUTES",0
;-
String_FIND              DB   "FIND FILE",0
BUTTON_CLASS                DB  "BUTTON",0
EDIT_CLASS                       DB  "EDIT",0
LIST_CLASS                       DB  "LISTBOX",0

My_      PROGRAMM_CONST  <>
;-
Name_FILE              db  512 dup(0)
;-
FILE_Data_Struc              WIN32_FIND_DATA               <0>
H_FIND                            DWORD    Null
;-
MSG_WIN        MSG      <0>
;-
NULL_STRING               DB  0 , 0 , 0 , 0
;-
SHABLON   DB       "%d",0
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
	;---------------------------       
           invoke  CreateWindowEx  , null , addr String_CLASS , addr  String_CAPTION ,\
                		WS_OVERLAPPEDWINDOW ,  100  ,130  , 605   ,  300   ,  \
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
            invoke   LoadIcon  ,   HINST  ,    null  ;  load Icon                  
      Mov  _Struct_WNDCLASS.hIcon       ,      Eax
            invoke   LoadIcon  ,   HINST  ,   null	  ;  load Icon                      
      Mov  _Struct_WNDCLASS.hIconSm   ,      Eax
         ;-
            invoke   LoadCursor  ,  NULL  ,   IDC_ARROW
      Mov  _Struct_WNDCLASS.hCursor      ,   Eax
         ;-
             
               invoke   CreateSolidBrush  , 00FF0000h  ;  возвратит идентификатор  кисти
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
LOCAL    _readedBite:DWORD                                              
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
                              ;----   BUTTON  
         		  invoke  CreateWindowEx  , WS_EX_CLIENTEDGE , addr  BUTTON_CLASS, addr String_FIND,\
                			WS_CHILD + WS_VISIBLE + BS_DEFPUSHBUTTON,  200, 225, 200, 30,  \
                		hWnd_,   My_.CONTROL_BUTTON,  HINST ,  NULL                  		
                              ;----   CONROL_LIST                                                                                            		
         		  invoke  CreateWindowEx  , WS_EX_CLIENTEDGE, addr  LIST_CLASS , addr  NULL_STRING,\
                			WS_CHILD + WS_VISIBLE +  LBS_NOTIFY + WS_VSCROLL,  0, 10, 300, 200,\
                		hWnd_,  My_.CONTROL_LIST,  HINST ,  NULL 
                              ;----   CONTROL_ATTRIBUTES   	                  	  
         		  invoke  CreateWindowEx  ,   0 , addr EDIT_CLASS, addr  My_.TEXT_ATTRIBUTES,\
                			WS_CHILD + WS_VISIBLE +  ES_AUTOHSCROLL, 315, 10, 260, 20,\
                		hWnd_,  My_.CONTROL_ATTRIBUTES,  HINST ,  NULL 
                              ;----   CONTROL_TIME_CREATE                  	  
         		  invoke  CreateWindowEx  ,   0 , addr EDIT_CLASS, addr  My_.TEXT_TIME_CREATE ,\
                			WS_CHILD + WS_VISIBLE +  ES_AUTOHSCROLL, 315, 40, 260, 20,\
                		hWnd_,  My_.CONTROL_TIME_CREATE,  HINST,  NULL  
                              ;----   CONTROL_TIME_ACCESS                  	  
         		  invoke  CreateWindowEx  ,  0  , addr EDIT_CLASS , addr  My_.TEXT_TIME_ACCESS ,\
                			WS_CHILD + WS_VISIBLE +  ES_AUTOHSCROLL,  315, 70, 260, 20,\
                		hWnd_,  My_.CONTROL_TIME_ACCESS,  HINST,  NULL 
                              ;----   CONTROL_TIME_WRITE                  	  
         		  invoke  CreateWindowEx  ,  0  , addr EDIT_CLASS , addr  My_.TEXT_TIME_WRITE ,\
                			WS_CHILD + WS_VISIBLE +  ES_AUTOHSCROLL,  315, 100, 260, 20,\
                		hWnd_,  My_.CONTROL_TIME_WRITE,  HINST,  NULL 
   
                		
  
                		
                              ;----   CONTROL_NAME                 	  
         		  invoke  CreateWindowEx  , WS_EX_CLIENTEDGE , addr EDIT_CLASS , addr  My_.TEXT_NAME  ,\
                			WS_CHILD + WS_VISIBLE + ES_CENTER +  ES_AUTOHSCROLL, 310, 150, 270, 20,\
                		hWnd_,  My_.CONTROL_NAME,  HINST,  NULL        
     	  
              	 jmp    FINISH
WMCOMMAND:
                 mov  EAX  ,  wParam
                 AND   EAX  ,  0000FFFFh
                                   ;-
                .IF    EAX  ==   My_.CONTROL_BUTTON      ; FIND  FILE

                      ;-- считываем имя файла для поиска
                      invoke   SendDlgItemMessage,  hWnd_,   My_.CONTROL_NAME,  WM_GETTEXT,  256, addr Name_FILE
                      ;-- очищаем содержимое списка
                      invoke   SendDlgItemMessage,  hWnd_,   My_.CONTROL_LIST,  LB_RESETCONTENT,  null, null
                      
                            ;--- находим первый файл в текущей директории
                            invOKe    FindFirstFile ,   addr  Name_FILE ,  addr   FILE_Data_Struc
                            mov     H_FIND   ,   EAX                                                 ;-          
                             ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
                            .if      H_FIND   !=    NULL
                             @@:       
                                 ; добавить имя файла в список
                                 invoke   SendDlgItemMessage,  hWnd_,  My_.CONTROL_LIST,  LB_ADDSTRING,  
                                                                                                        null, addr  FILE_Data_Struc.cFileName
                                                                       	  
                                  ;-  поиск следующего файла
			    invOKe  FindNextFile,  H_FIND,   addr  FILE_Data_Struc
			    cmp  EAX  ,   NULL
			    JE        @F    ; закончить перебор    
			    jmp     @B	   ; продолжим перебор             
                              @@:
                                 ; закрыть дескриптор поиска                                                            
                                 invoke    FindClose   ,  H_FIND
                              .endif
                              ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;                               
                              
                .ELSEIF    EAX  ==   My_.CONTROL_LIST      ;  GET  ATTRIBUTES

                         mov  EAX  ,  wParam
                         SHR  EAX  ,  16      ;извлекаем подсообщение  от  элемента   списка
 
 
                                        cmp   EAX  ,     LBN_SELCHANGE   ; "выбрана другая строка"
                                      jne    FINISH 

                                        ;---  определяем индекc выделенной строки списка
                                        invoke  SendMessage  ,  lParam  ,  LB_GETCURSEL ,  null  ,   null
                                        ;---  определяем содержимое строки
                                        invoke  SendMessage  ,  lParam  , LB_GETTEXT  , EAX ,  addr  CONTENER

                               ;--- извлекаем атрибуты файла
                               INVOKE GET_ATTRIBUTESS_proc , hWnd_ ,  addr  CONTENER

                 .ENDIF     
                                           
                                   ;--
                     jmp   FINISH            
;-                	    
WMDESTROY:
;-                        
                             invoke    PostQuitMessage ,  False 
                             
                        jmp  FINISH

;- 
FINISH:
RET  16                      					  
MAIN_WINDOW_PROC     ENDP


;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
END  START

