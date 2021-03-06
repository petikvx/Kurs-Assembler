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
MAIN_WINDOW_PROC     PROTO   :DWORD ,  :DWORD , :DWORD ,  :DWORD 
MODULE_TIMER_proc    PROTO   hWnd1:DWORD ,uMsg:DWORD ,idEvent:DWORD , dwTime:DWORD 														
;##########################################################
public    HINST   

;###########################################################
;data--data--data--data--data--data--data--data--data--data--     PROC
;----------------------------------------------------------------------------------------------
.DATA
HINST               DWORD      NULL
HWND_WIN        DWORD     NULL   ;??????????
;-
String_CLASS              DB    "MY_WINDOW",0  
String_CAPTION             DB  "MY_CAPTION",0
String_BUTTON              DB   "LOAD_DLL",0
BUTTON_CLASS                DB  "BUTTON",0
;-
MSG_WIN        MSG      <0>
;-
Name_DLL           DB   "myDLL.dll",0
H_DLL      DD     NULL                      
;-
NULL_STRING               DB  0 , 0 , 0 , 0
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
           invoke  CreateWindowEx  , NULL , addr String_CLASS , addr  String_CAPTION ,\
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
      Mov  _Struct_WNDCLASS.style          ,       CS_DBLCLKS              ;  ?????  ????
            ;    ,  
      Mov  _Struct_WNDCLASS.lpfnWndProc  ,     MAIN_WINDOW_PROC   ; ????????? ????
      Mov  _Struct_WNDCLASS.cbClsExtra    ,    null            ; ?????????????? ?????? ??? ??????
      Mov  _Struct_WNDCLASS.cbWndExtra   ,   null            ; ?????????????? ?????? ???  ????
              Mov   Eax  ,  HINST
      Mov  _Struct_WNDCLASS.hInstance     ,    Eax         ;  handle   ??????????

      Mov  _Struct_WNDCLASS.lpszMenuName    ,    NULL ;  ????????????? ????
      Mov  _Struct_WNDCLASS.lpszClassName  ,  offset  String_CLASS  ;   ????? ?????? ??????
   ;-
            invoke   LoadIcon  ,   HINST  ,    101	  ;  load Icon                  
      Mov  _Struct_WNDCLASS.hIcon       ,      Eax
            invoke   LoadIcon  ,   HINST  ,    102	  ;  load Icon                      
      Mov  _Struct_WNDCLASS.hIconSm   ,      Eax
         ;-
            invoke   LoadCursor  ,  NULL  ,   IDC_ARROW
      Mov  _Struct_WNDCLASS.hCursor      ,   Eax
         ;-
             
               invoke   CreateSolidBrush  , 00FF0000h  ;  ????????? ?????????????  ?????
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
local  _Loc_Time:SYSTEMTIME      
local  _MY_DATE[8]:DWORD      	                      	          	                    	                			      
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
         		  invoke  CreateWindowEx  , WS_EX_CLIENTEDGE , addr  BUTTON_CLASS , addr String_BUTTON  ,\
                			WS_CHILD + WS_VISIBLE + BS_DEFPUSHBUTTON ,  230  ,200  ,150  ,  25  ,  \
                		hWnd_   ,   1    ,  HINST ,  NULL	 
  	                                          
                      ;-                                                         
              	 jmp    FINISH
WMCOMMAND:
                                   mov  EAX  ,  wParam
                                   AND   EAX  ,  0000FFFFh
                                   ;--
                            .IF    EAX  ==   1    &&   H_DLL==NULL
                            
                                      invoke   LoadLibrary  ,  addr Name_DLL  
                                      mov   H_DLL   ,    EAX
                                      
                            .ELSEIF    EAX  ==   1    &&   H_DLL !=NULL   
                                                               
                                      invoke  FreeLibrary  ,  H_DLL
                                      MOV   H_DLL  ,   NULL
                                      
                            .ENDIF     
                                   ;--
                     jmp   FINISH              	    
WMDESTROY:
                                             
              invoke    PostQuitMessage ,  False
 
;- 
FINISH:
RET  16                      					  
MAIN_WINDOW_PROC     ENDP
;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
END  START

