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
 MODULE_CREATE_CHILD_proc       PROTO     hWnd1 :DWORD  
 MODULE_SEND_MESSAGE_proc    PROTO     hWnd1:DWORD 

;###########################################################
EXTERN    HINST:DWORD 
;###########################################################
;data--data--data--data--data--data--data--data--data--data--     PROC
;----------------------------------------------------------------------------------------------
.DATA
LIST_CLASS        DB    "LISTBOX",0
String_NULL            DB    0 , 0 , 0 , 0
;-
STRING_1           DB    "STRING_one",0
STRING_2           DB    "STRING_two",0
STRING_3           DB    "STRING_three",0
STRING_4           DB    "STRING_four",0

;##############################################################
;code--code--code--code--code--code--code--code--code--code-- PROC
;--------------------------------------------------------------------------------------------------
.CODE  
START:  
;---------------------------------------------------------------------------------------------------------------
;                                       CREATE        CHILD                                                               
;---------------------------------------------------------------------------------------------------------------
MODULE_CREATE_CHILD_proc                 PROC     hWnd1 :DWORD 
local  _hWndGroup :DWORD
;-1
             	  invoke    CreateWindowEx   ,   WS_EX_CLIENTEDGE ,    addr    LIST_CLASS     , \
             	 				                                                addr    String_NULL    , \
                		WS_CHILD + WS_VISIBLE+  LBS_NOTIFY	  ,\
                		   20 , 50 , 150 ,100 , \
                		hWnd1  ,  1  ,  HINST ,  NULL
 	        ;            		
;-2
             	  invoke    CreateWindowEx   ,   WS_EX_CLIENTEDGE ,    addr    LIST_CLASS     , \
             	 				                                                addr    String_NULL    , \
                		WS_CHILD + WS_VISIBLE  +  LBS_SORT + LBS_NOTIFY + WS_BORDER    , \
                		   190 , 50 , 150 ,100 , \
                		hWnd1  , 2  ,  HINST ,  NULL
 	        ;            		
 	           	         	         	         	        
	       INVOKE MODULE_SEND_MESSAGE_proc  ,  hWnd1    ; вызов   еще  одной функции    
;-
RET  4
MODULE_CREATE_CHILD_proc                 ENDP
;-------------------------------------------------------------------------------------------------------------------------------
;                                          SEND    MESSAGE   to   EDIT                                                                  
;-------------------------------------------------------------------------------------------------------------------------------
MODULE_SEND_MESSAGE_proc           PROC     hWnd1 :DWORD 
;-

        
          invoke  SendDlgItemMessage   ,  hWnd1   ,   1  ,  LB_ADDSTRING   ,   null  , addr   STRING_1 
          invoke  SendDlgItemMessage   ,  hWnd1   ,   1  ,  LB_ADDSTRING   ,   null  , addr   STRING_2 
          ;-
          invoke  SendDlgItemMessage   ,  hWnd1   ,   2  ,  LB_ADDSTRING   ,   null  , addr   STRING_3 
          invoke  SendDlgItemMessage   ,  hWnd1   ,   2  ,  LB_ADDSTRING   ,   null  , addr   STRING_4                     
           
   
;-
RET  4
MODULE_SEND_MESSAGE_proc           ENDP


;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++
END 









