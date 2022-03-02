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
MODULE_SET_BK_proc         PROTO     hWnd1   :DWORD   ,  nID:DWORD ,   refCOLOR2:DWORD

;###########################################################
EXTERN    HINST:DWORD 

;###########################################################
;data--data--data--data--data--data--data--data--data--data--     PROC
;----------------------------------------------------------------------------------------------
.DATA
BUTTON_CLASS        DB    "BUTTON",0
String_NULL            DB    0 , 0 , 0 , 0
Name_CHECK          DB   "Check_BRUSH",0
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
                		WS_CHILD + WS_VISIBLE +BS_ICON   ,   0 , 0 , 150 ,150 , \
                		hWnd1  ,  1  ,  HINST ,  NULL
 	        ;            		
;-2
             	  invoke    CreateWindowEx   ,  WS_EX_CLIENTEDGE  ,    addr  BUTTON_CLASS   , \
             	 				                                                addr    String_NULL   , \
                		WS_CHILD + WS_VISIBLE +BS_BITMAP  ,   320 , 300 , 170 ,170 , \
                		hWnd1  ,  2  ,  HINST ,  NULL
 	        ;            		 	        
;-3   +++++++++++++++++++   CHECK  BOX   +++++++++++++++++++++++++++
		 invoke    CreateWindowEx   ,  WS_EX_CLIENTEDGE  ,    addr  BUTTON_CLASS   , \
             	 				                                                addr    Name_CHECK  , \
                		WS_CHILD + WS_VISIBLE +BS_AUTOCHECKBOX	  ,   320 , 0 , 170 ,20 , \
                		hWnd1  ,  3  ,  HINST ,  NULL
 	        ;            		 	         	        
                    mov  _hWnd   ,  EAX
                          
                              
                     ;---------   LOAD 
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++  
                      
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
MODULE_SET_BK_proc         PROC        hWnd1   :DWORD   ,  nID:DWORD ,   refCOLOR2:DWORD
;-
              ;----------------------------------------------
              invoke   SendDlgItemMessage  ,  hWnd1  ,  3  ,  BM_GETCHECK  ,  NULL  ,  NULL 
              ;----------------------------------------------
              ;----------------------------------------------
             .IF    EAX  !=   BST_CHECKED	
                        invoke  CreateSolidBrush  ,   refCOLOR2
                            ;-  SET  BRUSH 
                                   invoke  SetClassLong   ,     hWnd1  ,  GCL_HBRBACKGROUND ,  EAX
                                   invoke  DeleteObject  , EAX
                             ;-  REPAINT     
                                          invoke  InvalidateRect   ,  hWnd1 , NULL  ,  TRUE
                                           invoke  UpdateWindow  ,  hWnd1     
             .ELSE
                      .if     nID  ==  1  ; -   -     -     -    -     -    -    -   -    -
                                  invoke       LoadImageA  ,   NULL   ,  addr BITMAP_STR ,   IMAGE_BITMAP ,\
                                                                                   170 ,  170  ,  LR_LOADFROMFILE	
                                                     test   EAX  , EAX
                                                JZ   $_FINISH_                                                                                      
                                  invoke   CreatePatternBrush    ,   EAX 
                            ;-  SET  BRUSH 
                                   invoke  SetClassLong   ,     hWnd1  ,  GCL_HBRBACKGROUND ,  EAX
                                   invoke  DeleteObject  , EAX
                             ;-  REPAINT     
                                          invoke  InvalidateRect   ,  hWnd1 , NULL  ,  TRUE
                                           invoke  UpdateWindow  ,  hWnd1                                         
                       .elseif  nID  ==  2 ; -   -     -     -    -     -    -    -   -    -
                           
                                  invoke       LoadImageA  ,   NULL   ,  addr BITMAP_STR ,   IMAGE_BITMAP ,\
                                                                                   500 ,  500  ,  LR_LOADFROMFILE	
                                                     test   EAX  , EAX
                                                JZ   $_FINISH_                                
                                  invoke   CreatePatternBrush    ,   EAX 
                            ;-  SET  BRUSH 
                                   invoke  SetClassLong   ,     hWnd1  ,  GCL_HBRBACKGROUND ,  EAX
                                   invoke  DeleteObject  , EAX
                             ;-  REPAINT     
                                          invoke  InvalidateRect   ,  hWnd1 , NULL  ,  TRUE
                                           invoke  UpdateWindow  ,  hWnd1                                
                       .endif        ; -   -     -     -    -     -    -    -   -    -
             .ENDIF    
$_FINISH_:                     
;-
RET  12
MODULE_SET_BK_proc         ENDP


;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++
END 


 








