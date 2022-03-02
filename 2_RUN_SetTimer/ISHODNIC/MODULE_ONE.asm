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
MODULE_CALLBACK_SHAPE_proc    PROTO \
                       hWnd1:DWORD , uMsg :DWORD , uID:DWORD ,curTIME:DWORD

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
 	        ;            		 	          
 	         invoke   SetTimer  ,   hWnd1  ,  1  ,  1000 ,  MODULE_CALLBACK_SHAPE_proc
 
RET  4
MODULE_CREATE_CHILD_proc                 ENDP
;------------------------------------------------------------------------------------------
;                                   START         SHAPE                                                           
;------------------------------------------------------------------------------------------
MODULE_CALLBACK_SHAPE_proc    PROC \
                       hWnd1:DWORD , uMsg :DWORD , uID:DWORD ,curTIME:DWORD
;-
             invoke    GetDC  ,  hWnd1
         push  EAX    
            INVOKE  MODULE_SHAPE_proc  ,  Eax 
         pop   EAX
            invoke   ReleaseDC   ,  hWnd1  ,  EAX  
;-
RET 16
MODULE_CALLBACK_SHAPE_proc    ENDP
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
local   _pen_RED   , _OLD_PEN      :DWORD
local      _Poly[8]  :DWORD
;- INIT  PEN                               
          invoke   CreatePen  , PS_SOLID  , 5  ,    0000FFh    ; red
            mov  _pen_RED   , EAX 
	;=  =  =  =  =  =  =  =  =  =  =  = 	
          invoke   SelectObject  ,  HDC_   ,  _pen_RED
             mov   _OLD_PEN   ,  eax  
             ;-                                       init  POINT
             LEA   EBX  , _Poly
             MOV   dword ptr [ EBX  ] , 400        ;x 
             MOV   dword ptr [ EBX + 4 ] , 20            ;y
             MOV   dword ptr [ EBX + 8 ] , 250	     ;x
             MOV   dword ptr [ EBX  + 12 ] , 100		;y
             MOV   dword ptr [ EBX  + 16 ] , 350       ;x
             MOV   dword ptr [ EBX + 20 ] , 200		;y
             MOV   dword ptr [ EBX + 24 ] , 400       ;x
             MOV  dword ptr  [ EBX  + 28 ] , 400            ;y

          invoke   Polyline  , HDC_  ,  addr  _Poly  ,  4
    
;-
$_FINISH_:    
          invoke   SelectObject  ,  HDC_  , _OLD_PEN        ;   востанавливаем  перо
          
          ;-    delete      object    
          invoke   DeleteObject   ,  _pen_RED                                  
RET  4 
MODULE_SHAPE_proc       ENDP

;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++
END 









