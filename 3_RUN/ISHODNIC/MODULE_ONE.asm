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
MODULE_TRANS_BITMAP_proc   PROTO   hWnd1:DWORD  ,   ptrTask_STRUCT: DWORD
MODULE_SCREEN_BITMAP_proc        PROTO   hWnd1:DWORD  ,   ptrTask_STRUCT: DWORD 

;###########################################################
EXTERN    HINST:DWORD 

;###########################################################
;data--data--data--data--data--data--data--data--data--data--     PROC
;----------------------------------------------------------------------------------------------
.DATA

;-

;##############################################################
;code--code--code--code--code--code--code--code--code--code-- PROC
;--------------------------------------------------------------------------------------------------
.CODE  
START:  
;-------------------------------------------------------------------------------------------------------------------------------
;                                          TRANS    BITMAP                                                                             
;-------------------------------------------------------------------------------------------------------------------------------
MODULE_TRANS_BITMAP_proc          PROC     hWnd1:DWORD  ,   ptrTask_STRUCT: DWORD 
local    _Rect          :RECT
local    _RectClient  :RECT

;-   
                              ASSUME   ESI  :  PTR PROGRAM_STRUCT  
                              MOV   ESI  ,  ptrTask_STRUCT
               ;---
               invoke    GetClientRect  ,  hWnd1  , addr  _Rect 
               invoke    GetClientRect  ,  hWnd1  , addr  _RectClient
               invoke    MapWindowPoints  ,  hWnd1  ,  NULL   ,   addr  _Rect ,  2 
               ;--- 
          invOKe    BitBlt   ,  [ESI].uCOMP_HDC  , 0, 0 ,\
                                                          _RectClient.right  ,  _RectClient.bottom  , \
                                      [ESI].uDESK_HDC	,\
          			                    _Rect.left , _Rect.top ,    SRCCOPY
;-
$_FINISH_:    
                                  
                            ASSUME   ESI:NOTHING
;-
RET   8
MODULE_TRANS_BITMAP_proc       ENDP
;-------------------------------------------------------------------------------------------------------------------------------
;                                        STRETCH      BITMAP                                                                       
;-------------------------------------------------------------------------------------------------------------------------------
MODULE_SCREEN_BITMAP_proc         PROC     hWnd1:DWORD  ,   ptrTask_STRUCT: DWORD 
local    _Rect:RECT
;-   
                              ASSUME   ESI  :  PTR PROGRAM_STRUCT  
                              MOV   ESI  ,  ptrTask_STRUCT
               ;---
           invoke    GetClientRect  ,  hWnd1  , addr  _Rect
               ;------
          invOKe    StretchBlt   ,  [ESI].uCOMP_HDC , 0, 0 ,   _Rect.right ,  _Rect.bottom  , \
          			[ESI].uDESK_HDC	, 0 , 0 , [ESI].uLEN  ,  [ESI].uHIG , SRCCOPY
;-
$_FINISH_:    
                            ASSUME   ESI:NOTHING
;-
RET   8
MODULE_SCREEN_BITMAP_proc        ENDP

END 









