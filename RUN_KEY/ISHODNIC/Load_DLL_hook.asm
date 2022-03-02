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
;##########################################################
public    HINST   

;###########################################################
;data--data--data--data--data--data--data--data--data--data--     PROC
;----------------------------------------------------------------------------------------------
.DATA
HINST               DWORD      NULL
HWND_WIN        DWORD     NULL   ;дескриптор
;-
String_CLASS              DB    "MY_WINDOW",0  
String_CAPTION             DB  "WH_KEYBOARD",0
String_BUTTON              DB   "SET HOOK",0
BUTTON_CLASS                DB  "BUTTON",0
EDIT_CLASS                       DB  "EDIT",0
;-
MSG_WIN        MSG      <0>
;-
Name_DLL           DB   "hookKEY.dll",0
H_DLL      DD     NULL   
;-
Name_SetHookFUNC         DB  "_DLL_SET_HOOK_proc@4",0 
Name_UnSetHookFUNC         DB  "_DLL_UNSET_HOOK_proc@0",0 
DLL_SET_HOOK_Func      DWORD    NULL      
DLL_UNSET_HOOK_Func      DWORD    NULL                 
;-
NULL_STRING               DB  0 , 0 , 0 , 0

SHABLON   DB       "year=%d, month=%d , dayOfWeek=%d, day=%d , hour=%d , min=%d , sec=%d , mils=%d",0
CONTENER         DB    256   dup (0)

WM_NULL_1     DD   0
;##############################################################
;code--code--code--code--code--code--code--code--code--code-- PROC
;--------------------------------------------------------------------------------------------------
.CODE  
START:
invoke RegisterWindowMessage, addr  Name_UnSetHookFUNC
MOV  WM_NULL_1 ,  EAX

                invoke  GetModuleHandle  ,  Null 
                 mov    HINST   ,  EAX   
                    ;-                                                 
                      CALL   MY_REGISTER_CLASS 
	                  cmp   EAX  ,  null
	              je   EXIT
	;---------------------------       
           invoke  CreateWindowEx  , WS_EX_TOPMOST , addr String_CLASS , addr  String_CAPTION ,\
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
            invoke   LoadIcon  ,   HINST  ,    101	  ;  load Icon                  
      Mov  _Struct_WNDCLASS.hIcon       ,      Eax
            invoke   LoadIcon  ,   HINST  ,    102	  ;  load Icon                      
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
                                            CMP     MESG    ,    WM_CREATE
                                       JE      WMCREATE      
                                            CMP     MESG    ,    WM_COMMAND
                                       JE      WMCOMMAND                                                                                                
                                            CMP     MESG    ,     WM_DESTROY
                                      JE       WMDESTROY         
                                            CMP     MESG    ,     WM_NULL
                                      JE       WMNULL                                                                                                                                                   	
;----                                         
DEF_:
               invoke   DefWindowProc ,  hWnd_   ,   MESG  ,  wParam , lParam  
                jmp    FINISH
;----                                       
WMNULL:
                   invoke  SendDlgItemMessage , hWnd_ ,  3  ,  WM_CHAR  ,  wParam  , lParam         
          
                    and   wParam, 000000FFh      
                    invoke  SetDlgItemInt , hWnd_ ,  2  ,   wParam  , NULL                  
                                                              
           jmp  FINISH
WMCREATE:
                              ;----   CREATE  BUTTON
         		  invoke  CreateWindowEx  , WS_EX_CLIENTEDGE , addr  BUTTON_CLASS , addr String_BUTTON  ,\
                			WS_CHILD + WS_VISIBLE + BS_DEFPUSHBUTTON ,  230  ,200  ,150  ,  25  ,  \
                		hWnd_   ,   1    ,  HINST ,  NULL  
                		;----   CREATE    EDIT
         		  invoke  CreateWindowEx  , WS_EX_CLIENTEDGE , addr EDIT_CLASS , addr  NULL_STRING ,\
                			WS_CHILD + WS_VISIBLE +  ES_AUTOHSCROLL ,  0  ,60  ,600   ,  25  ,  \
                		hWnd_   ,  2    ,  HINST ,  NULL                       		
         		  invoke  CreateWindowEx  , WS_EX_CLIENTEDGE , addr EDIT_CLASS , addr  NULL_STRING ,\
                			WS_CHILD + WS_VISIBLE +  ES_AUTOHSCROLL ,  0  ,100  ,600   ,  25  ,  \
                		hWnd_   ,   3    ,  HINST ,  NULL                           		  		       
                		      		       			                        		      		       			 
                	  ;-	                                                                    	
  	             invoke   LoadLibrary  ,  addr Name_DLL  
                                      mov   H_DLL   ,    EAX    
                               invoke   GetProcAddress   ,     H_DLL    ,        addr    Name_SetHookFUNC        
                                      MOV   DLL_SET_HOOK_Func   ,  EAX   
                              invoke   GetProcAddress   ,     H_DLL    ,        addr    Name_UnSetHookFUNC        
                                      MOV   DLL_UNSET_HOOK_Func   ,  EAX                                                                                     
                      ;-                                                         
              	 jmp    FINISH
WMCOMMAND:
                                   mov  EAX  ,  wParam
                                   AND   EAX  ,  0000FFFFh
                                   ;--
                              
                            .IF    EAX  ==   1    &&  DLL_SET_HOOK_Func != NULL
                                                                      
                                           PUSH    hWnd_ 
                                                 mov  EAX  ,   DLL_SET_HOOK_Func 		     ;  Ставим  HOOK
                                          CALL    EAX          ; to DLL
                                          
                                                                                
                              
                            
                            .ELSEIF    EAX  ==   10    
                            
                               invoke  Beep, 2000, 100
                                          
                                                                                
                            .ENDIF                                 
                                   ;--
                     jmp   FINISH              	    
WMDESTROY:
                            .IF    EAX  ==   1    &&  DLL_UNSET_HOOK_Func != NULL      
                                   
                                            
                                                mov  EAX  ,   DLL_UNSET_HOOK_Func               ;  Снимаем HOOK
                                        CALL    EAX          ; to DLL
                                          
                                                                                
                            .ENDIF 
                                                                             
                     invoke    PostQuitMessage ,  False 
                        jmp  FINISH

;- 
FINISH:
RET  16                      					  
MAIN_WINDOW_PROC     ENDP
;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
END  START

