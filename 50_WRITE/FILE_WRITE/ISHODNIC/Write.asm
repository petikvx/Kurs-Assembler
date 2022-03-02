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
HWND_WIN        DWORD     NULL   ;����������
;-
String_CLASS                  DB    "MY_WINDOW",0  
String_CAPTION               DB  "WRITE FILE",0
;-
String_READ              DB   "READ_FILE",0
String_WRITE             DB   "WRITE_FILE",0
String_SIZE                 DB   "SIZE FILE",0

BUTTON_CLASS                DB  "BUTTON",0
EDIT_CLASS                       DB  "EDIT",0
;-
H_FILE                              DWORD    Null
Ptr_MEMORY               DWORD    Null
Size_FILE                         DWORD    Null
Size_DATA                         DWORD    Null

OFN_STRUCT      OPENFILENAME      <0>
FILTR_FILE       DB          "TEXT",0,"*.txt",0,"*.HTML",0,"*.html",0,0,0
Name_FILE       DB    256  dup(0)

MSG_WIN        MSG      <0>
;-
NULL_STRING               DB  0 , 0 , 0 , 0
;-
FORMAT   DB       "%d",0
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
           invoke  CreateWindowEx  , 0 , addr String_CLASS , addr  String_CAPTION ,\
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
      Mov  _Struct_WNDCLASS.style          ,       CS_DBLCLKS              ;  �����  ����
            ;    ,  
      Mov  _Struct_WNDCLASS.lpfnWndProc  ,     MAIN_WINDOW_PROC   ; ��������� ����
      Mov  _Struct_WNDCLASS.cbClsExtra    ,    null            ; �������������� ������ ��� ������
      Mov  _Struct_WNDCLASS.cbWndExtra   ,   null            ; �������������� ������ ���  ����
              Mov   Eax  ,  HINST
      Mov  _Struct_WNDCLASS.hInstance     ,    Eax         ;  handle   ����������

      Mov  _Struct_WNDCLASS.lpszMenuName    ,    NULL ;  ������������� ����
      Mov  _Struct_WNDCLASS.lpszClassName  ,  offset  String_CLASS  ;   ����� ������ ������
   ;-
            invoke   LoadIcon  ,   HINST  ,    null  ;  load Icon                  
      Mov  _Struct_WNDCLASS.hIcon       ,      Eax
            invoke   LoadIcon  ,   HINST  ,   null	  ;  load Icon                      
      Mov  _Struct_WNDCLASS.hIconSm   ,      Eax
         ;-
            invoke   LoadCursor  ,  NULL  ,   IDC_ARROW
      Mov  _Struct_WNDCLASS.hCursor      ,   Eax
         ;-
             
               invoke   CreateSolidBrush  , 000000FFh  ;  ��������� �������������  �����
       
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
LOCAL     startText ,  endText :DWORD                                      
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
                              ;----      BUTTON   READ  FILE
         		  invoke  CreateWindowEx  , WS_EX_CLIENTEDGE , addr  BUTTON_CLASS , addr String_READ ,\
                		WS_CHILD + WS_VISIBLE + BS_DEFPUSHBUTTON ,  350  ,225  ,200  ,  30  ,  \
                		hWnd_   ,   1    ,  HINST ,  NULL
                 		;----     EDIT    READ                		             		
         		  invoke  CreateWindowEx  , WS_EX_CLIENTEDGE , addr EDIT_CLASS , addr  NULL_STRING ,\
                		WS_CHILD + WS_VISIBLE + ES_NOHIDESEL + WS_VSCROLL + ES_MULTILINE , 0 ,10 , 600 , 200,  \
                		hWnd_   ,   2    ,  HINST ,  NULL         
                              ;----      BUTTON   WRITE  FILE
         		  invoke  CreateWindowEx  , WS_EX_CLIENTEDGE , addr BUTTON_CLASS , addr  String_WRITE ,\
                			WS_CHILD + WS_VISIBLE +   BS_DEFPUSHBUTTON  ,  50  ,220  ,150  ,  40 ,\
                		hWnd_   ,  3   ,  HINST ,  NULL                          		               		       			 

              	 jmp    FINISH
WMCOMMAND:
                   mov  EAX  ,  wParam
                   AND   EAX  ,  0000FFFFh
                   ;-
                   .IF    EAX  ==   1      ;  ������� � ������ ����

                         invoke   RtlZeroMemory          ,addr OFN_STRUCT    ,    size    OPENFILENAME
         
                         MOV       OFN_STRUCT .lStructSize       ,       size  OPENFILENAME
                               mov      EAX  ,    hWnd_
                         MOV       OFN_STRUCT .hwndOwner     ,   EAX
                                         mov      EAX   ,    HINST 
                         MOV       OFN_STRUCT .hInstance     ,   EAX
                         MOV       OFN_STRUCT .lpstrTitle  ,  offset  String_CAPTION   ; ��������� �������
                         MOV       OFN_STRUCT .lpstrFilter         ,        offset    FILTR_FILE   ;  ���  ������ �������
                         ;-
                         MOV  OFN_STRUCT.lpstrFile         ,      offset   Name_FILE   ;  ���  ����� �����      
                         MOV  OFN_STRUCT .nMaxFile       ,       256
                         ;-
                         MOV  OFN_STRUCT .Flags  ,  OFN_FILEMUSTEXIST   or  OFN_HIDEREADONLY   or \
                                  		                OFN_PATHMUSTEXIST  or  OFN_EXPLORER 
                                  						     
                   invoke           GetOpenFileName  ,    addr     OFN_STRUCT ;  ������ ������ �����
                   TEST   EAX   ,   EAX
                   JZ    FINISH    
                                                          
                            
                   ;-    ���� � ��������� ���� 
                   invoke   SetWindowText   ,    hWnd_   ,  addr   Name_FILE 
                   ;-   ������� ����
                   invoke   CreateFile,     addr   Name_FILE  ,   GENERIC_READ	,  FILE_SHARE_READ ,\
                                  		  null,    OPEN_EXISTING,   FILE_ATTRIBUTE_NORMAL,  null
                       mov   H_FILE   ,   EAX
                   ;-
                   .if    EAX   !=  INVALID_HANDLE_VALUE   ;  FFFFFFFFh
                                  
                          ;-  ���������� ������ ����� 
                          invoke  GetFileSize    ,     H_FILE   ,     NULL  
                          mov    Size_FILE   ,    EAX
                          ;-  ��������  ������ �����    
                          invoke     wsprintf,  addr  CONTENER,     addr FORMAT ,     Size_FILE
                          invoke     MessageBox, 0 , addr Name_FILE ,   addr  CONTENER,   MB_SYSTEMMODAL 
                	      ;-   ��������  ������
                          invoke  VirtualAlloc   ,    Null  , Size_FILE  ,   
                                                             MEM_COMMIT +  MEM_RESERVE  ,  PAGE_READWRITE
                          cmp   EAX  ,  NULL    
                          je    WMDESTROY           
                          ;===
                          MOV      Ptr_MEMORY   ,   EAX    ;  ����� ������
                                          	                                            	        
                          ;--  �������� ������ 
                          invoke   RtlZeroMemory   ,  Ptr_MEMORY  ,  Size_FILE                            	      
                          ;-  ��������� ���������� ����� � �����
                          invoke   ReadFile,  H_FILE,  Ptr_MEMORY,   Size_FILE, addr  _readedBite,  null
                          ;-  �������  ����                  
                          invoke  CloseHandle,   H_FILE  
                          ;-  ������� ���������� � ��������� ���� 
                          invoke  SendDlgItemMessage,  hWnd_,  2,  WM_SETTEXT  ,  FALSE,  Ptr_MEMORY
                                          	       												  
                          ;-  ����������  ������
                          invoke   VirtualFree,  Ptr_MEMORY,  MEM_DECOMMIT + MEM_RELEASE ,  Size_FILE  
                                .endif                                     
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;                  
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                   .ELSEIF    EAX  ==   3      ;  ����� � ����� ����
                        
                          invoke   RtlZeroMemory, addr OFN_STRUCT,  size  OPENFILENAME
         
                          MOV       OFN_STRUCT .lStructSize       ,       size  OPENFILENAME
                                mov      EAX  ,    hWnd_
                          MOV       OFN_STRUCT .hwndOwner     ,   EAX
                                mov      EAX   ,    HINST 
                          MOV       OFN_STRUCT .hInstance     ,   EAX
                          MOV       OFN_STRUCT .lpstrTitle  ,  offset  String_CAPTION   ; ��������� �������
                          MOV       OFN_STRUCT .lpstrFilter         ,        offset    FILTR_FILE   ;  ���  ������ �������
                          ;-
                          MOV  OFN_STRUCT.lpstrFile         ,      offset   Name_FILE   ;  ���  ����� �����      
                          MOV  OFN_STRUCT .nMaxFile       ,       256
                          ;-
                          MOV  OFN_STRUCT .Flags  ,  OFN_HIDEREADONLY   or \
                                  			       OFN_PATHMUSTEXIST  or  OFN_EXPLORER 
                                  						     
                          invoke           GetSaveFileName  ,    addr     OFN_STRUCT ;  ������ ���������� �����
                          TEST   EAX   ,   EAX
                          JZ    FINISH    
                                                          
                          ;--  ���������� ������� ����������� ������                              
                          invoke   SendDlgItemMessage   ,  hWnd_ , 2 ,  EM_GETSEL ,  addr startText , addr  endText
                          ;--  ��������� ������ ����������� ������  � �������� ��������� �������
                          mov  eax ,  endText
                          sub   eax ,  startText
                          mov  Size_DATA ,  eax  ; ������ ������ ��� ������
                                
                          ; ��������  ������  ������   ��� ������
                          invoke     wsprintf,  addr  CONTENER,     addr FORMAT ,     Size_DATA
                          invoke     MessageBox, 0 ,addr  Name_FILE , addr  CONTENER,    MB_SYSTEMMODAL       
                                              
                          ;-   ��������  ������
                          invoke  VirtualAlloc   ,    Null  , Size_DATA  ,   
                                                                                    MEM_COMMIT +  MEM_RESERVE  ,  PAGE_READWRITE
                          cmp   EAX  ,  NULL    
                          je    WMDESTROY  ; ���� ������, �� ���������� ���������          
                          ;===
                          MOV      Ptr_MEMORY   ,   EAX    ;  ����� ������
                                 
                          ;--  �������� ������   
                          invoke   RtlZeroMemory,  Ptr_MEMORY ,  Size_DATA
                          ;--  ���������  ����������  ���������� ����
                          invoke   SendDlgItemMessage,  hWnd_ , 2 ,  WM_GETTEXTLENGTH ,  0 ,    0  ; ������ ����� ������
                          invoke   SendDlgItemMessage,  hWnd_ , 2 ,  WM_GETTEXT ,  EAX ,  Ptr_MEMORY  ; ����� � �����
                                       
                           mADD   Ptr_MEMORY ,  startText  ; �������� ��������� ������� ������
                                
      
                          ;-- ��������� ���� �� ������  
                          invoke   CreateFile ,     addr   Name_FILE  ,   GENERIC_WRITE  ,\
                                   			 FILE_SHARE_WRITE +  FILE_SHARE_READ  ,\
                                  			 null  ,    OPEN_ALWAYS  ,   FILE_ATTRIBUTE_NORMAL,   null
                          mov   H_FILE   ,   EAX                                                                             
                          ;///////////////////////////
                          .if     H_FILE   !=  INVALID_HANDLE_VALUE   ;  FFFFFFFFh  
                                         
                                ;--   ������������� �������� ��������� � ����� ����� 
                                invoke  SetFilePointer  ,  H_FILE  ,    NULL  ,  NULL  ,  FILE_END      
                                ;--    ����� ������  � ����   
                                invoke  WriteFile  ,   H_FILE  ,  Ptr_MEMORY  , Size_DATA  ,  addr  _readedBite  ,  Null
                                ;--    �������  �����  
                                invoke   CloseHandle  ,  H_FILE
                                ;--    ������������� ������� - "������� ����"
                                invoke  SetFileAttributes,   addr   Name_FILE ,  FILE_ATTRIBUTE_HIDDEN	 
                                                                                                                                                               
                          .endif    
                          ;/////////////////////////// 
                          ;---  ����������  ������
                          invoke   VirtualFree,  Ptr_MEMORY,  MEM_DECOMMIT + MEM_RELEASE ,  Size_DATA  
                   .ENDIF     
                                   ;--
            jmp   FINISH            
             	    
WMDESTROY:
;-                        
                             invoke    PostQuitMessage ,  False 
                             
                        jmp  FINISH

;- 
FINISH:
RET  16                      					  
MAIN_WINDOW_PROC     ENDP




;########################################################################
END  START

