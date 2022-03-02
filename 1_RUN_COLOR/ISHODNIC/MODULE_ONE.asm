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
MODULE_SET_BK_proc      PROTO         hWnd1   :DWORD   ,   refCOLOR2:DWORD

;###########################################################
EXTERN    HINST:DWORD 

;###########################################################
;data--data--data--data--data--data--data--data--data--data--     PROC
;----------------------------------------------------------------------------------------------
.DATA
BUTTON_CLASS        DB    "BUTTON",0
String_NULL            DB    0 , 0 , 0 , 0
BITMAP_STR            DB  ".\RESOURCE\MASKA.bmp",0
;-

;##############################################################
;code--code--code--code--code--code--code--code--code--code-- PROC
;--------------------------------------------------------------------------------------------------
.CODE  
START:  
;---------------------------------------------------------------------------------------------------------------
;                                       CREATE        CHILD                                                               
;---------------------------------------------------------------------------------------------------------------
MODULE_CREATE_CHILD_proc                 PROC     hWnd1 :DWORD 
local  _hWnd :DWORD
;-1
             	  invoke    CreateWindowEx   ,  WS_EX_CLIENTEDGE  ,    addr  BUTTON_CLASS   , \
             	 				                                                addr    String_NULL   , \
                		WS_CHILD + WS_VISIBLE +BS_ICON   ,   50 , 70 , 150 ,150 , \
                		hWnd1  ,  1  ,  HINST ,  NULL
 	        ;            		
;-2
             	  invoke    CreateWindowEx   ,  WS_EX_CLIENTEDGE  ,    addr  BUTTON_CLASS   , \
             	 				                                                addr    String_NULL   , \
                		WS_CHILD + WS_VISIBLE +BS_BITMAP  ,   250 , 70 , 170 ,170 , \
                		hWnd1  ,  2  ,  HINST ,  NULL
 	        ;            		 	        
                    mov  _hWnd   ,  EAX
                     ;---------   LOAD 
                     
                      
 ;--------------     SET  ICON
          ;  invoke  LoadIcon    ,    HINST  ,    102
           invoke       LoadImageA  ,   HINST   ,  102 ,   IMAGE_ICON ,\
           								 150 ,  150  ,   NULL
           invoke   SendDlgItemMessage  ,  hWnd1 , 1  ,  BM_SETIMAGE   ,   IMAGE_ICON , EAX
 ;---------------    SET  BITMAP
            ; invoke  LoadBitmap  , HINST  ,   103
           invoke       LoadImageA  ,   NULL   ,  addr BITMAP_STR ,   IMAGE_BITMAP ,\
                                                                                   170 ,  170  ,  LR_LOADFROMFILE	
          
           invoke   SendDlgItemMessage  ,  hWnd1 , 2  ,  BM_SETIMAGE   ,   IMAGE_BITMAP , EAX	           

;-
RET  4
MODULE_CREATE_CHILD_proc                 ENDP
;-------------------------------------------------------------------------------------------------------------------------------
;                                          SEND    MESSAGE  BACKGROUND                                                                 
;-------------------------------------------------------------------------------------------------------------------------------
MODULE_SET_BK_proc         PROC        hWnd1   :DWORD   ,   refCOLOR2:DWORD
;-
                        invoke  CreateSolidBrush  ,   refCOLOR2
                        ;-  SET  BRUSH 
                        invoke  SetClassLong   ,     hWnd1  ,  GCL_HBRBACKGROUND ,  EAX
                            invoke  DeleteObject  , EAX
                        ;-  REPAINT     
                        invoke  InvalidateRect   ,  hWnd1 , NULL  ,  TRUE
                        invoke  UpdateWindow  ,  hWnd1
;-
RET  8
MODULE_SET_BK_proc         ENDP


;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++
END 


 








