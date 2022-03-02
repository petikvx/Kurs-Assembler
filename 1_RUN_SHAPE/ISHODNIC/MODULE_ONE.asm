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
MODULE_PAINT_MESSAGE_proc     PROTO   HDC_:DWORD ,  NUM_:DWORD
MODULE_SHAPE_proc             PROTO   HDC_:DWORD


;###########################################################
EXTERN    HINST:DWORD 
;###########################################################
;data--data--data--data--data--data--data--data--data--data--     PROC
;----------------------------------------------------------------------------------------------
.DATA
BUTTON_CLASS      DB    "BUTTON",0
;-
name_PUSTO       Db     "PUSTO",0
name_PIXEL      Db    "paint" ,0Dh,"PIXEL",0
name_LINE      Db    "paint" ,0Dh,"LINE",0
  
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
;-1                                                                  
            invoke    CreateWindowEx   ,   Null ,   addr   BUTTON_CLASS   , \
             	 	                               addr    name_PUSTO    , \
                		   WS_CHILD + WS_VISIBLE    ,\
                		        10  ,   20   ,  160   , 30  , \
                		        hWnd1  ,  1  ,  HINST ,  NULL
;-2     PIXEL                                          		
            invoke    CreateWindowEx   ,   Null ,   addr   BUTTON_CLASS   , \
             	 	                               addr    name_PIXEL    , \
                		   WS_CHILD + WS_VISIBLE + BS_MULTILINE   ,\
                		        10  ,   70   ,  160   , 50  , \
                		        hWnd1  ,  2  ,  HINST ,  NULL       		        

RET  4
MODULE_CREATE_CHILD_proc                 ENDP
;-------------------------------------------------------------------------------------------------------------------------------
;                                           MESSAGE  PAINT                                                                  
;-------------------------------------------------------------------------------------------------------------------------------
MODULE_PAINT_MESSAGE_proc  PROC     HDC_:DWORD ,  NUM_:DWORD
local  _hWnd   :DWORD 
;-

    			    CMP    NUM_   ,   1
   			 je     $_PUSTO_    
  			      CMP    NUM_  ,   2
   			 je     $_SHAPE_ 			   
    
                     jmp   $_FINISH_
;==============    
$_PUSTO_:
               invoke   WindowFromDC  ,  HDC_
               mov  _hWnd  ,  EAX
               invoke   InvalidateRect  ,  _hWnd , null   , true
               invoke   UpdateWindow  ,  _hWnd

         	    jmp   $_FINISH_
$_SHAPE_:
              INVOKE MODULE_SHAPE_proc    ,   HDC_
;-
$_FINISH_:
RET  8
MODULE_PAINT_MESSAGE_proc            ENDP
;------------------------------------------------------------------------------------------------
;				SHAPE          SHAPE                                                        
;------------------------------------------------------------------------------------------------
MODULE_SHAPE_proc       PROC         HDC_ :DWORD
;-
local   _pen_RED  , _pen_GREEN , _pen_BLUE        :DWORD
local   _brush_RED  , _brush_BLUE , _brush_NULL   :DWORD
local   _OLD_BRUSH  ,  _OLD_PEN    :DWORD
;- INIT  PEN                               
          invoke   CreatePen  , PS_SOLID  , 5  ,    0000FFh    ; red
            mov  _pen_RED   , EAX 
          invoke   CreatePen  , PS_SOLID  , 15  ,    00FF00h    ; green
            mov  _pen_GREEN   , EAX 
          invoke   CreatePen  , PS_SOLID  , 2  ,  00FF0000h    ; blue
            mov  _pen_BLUE   , EAX 
;- INIT  BRUSH                               
	invoke   CreateSolidBrush  ,    0000FFh             ; red 
	     mov   _brush_RED  ,  Eax
	invoke   CreateSolidBrush  ,    00FF0000h         ; blue
	     mov   _brush_BLUE  ,  Eax	     
	invoke   GetStockObject  ,   NULL_BRUSH          ;  NULL Brush
	     mov   _brush_NULL    ,  Eax   
	;=  =  =  =  =  =  =  =  =  =  =  = 
	
          invoke   SelectObject  ,  HDC_   ,  _pen_RED
             mov   _OLD_PEN   ,  eax  
          invoke   SelectObject  ,   HDC_  ,  _brush_BLUE
             mov   _OLD_BRUSH   , eax
             ;-                                        left    top   right   bottom
             invoke   RoundRect ,  HDC_   ,  200  , 30  , 300   , 150  , 6 , 6
           invoke     SelectObject , HDC_  , _brush_NULL
              invoke   Rectangle  , HDC_  ,  350  ,  30  ,  450 , 150 
             ;**************************************************************
          invoke    SelectObject  ,  HDC_  , _pen_GREEN
          invoke    SelectObject  ,  HDC_  , _brush_RED  
            ;-
             invoke   Ellipse   ,   HDC_   ,    200  ,   200  ,   300  , 400
             invoke   Ellipse   ,   HDC_   ,    50  ,   200  ,   150  , 300
     
;-
          
         
;-
$_FINISH_:    
          invoke   SelectObject  ,  HDC_  , _OLD_BRUSH    ;  востанавливаем   кисть
          invoke   SelectObject  ,  HDC_  , _OLD_PEN        ;   востанавливаем  перо
          ;-    delete      object
          invoke   DeleteObject   ,  _brush_RED
          invoke   DeleteObject   ,  _brush_BLUE
          invoke   DeleteObject   ,  _pen_RED                    
          invoke   DeleteObject   ,  _pen_GREEN
          invoke   DeleteObject   ,  _pen_BLUE                    
RET  4 
MODULE_SHAPE_proc       ENDP

;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++
END 









