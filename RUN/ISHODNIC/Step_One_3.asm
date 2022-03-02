          .386
        .model flat,stdcall
  option   casemap:none
                        include C:\masm32\INCLUDE\WINDOWS.INC
                        include C:\masm32\INCLUDE\KERNEL32.INC 
                        include C:\masm32\INCLUDE\USER32.INC
                        include C:\masm32\INCLUDE\ADVAPI32.INC                                                  
                        include  my.inc
                                                                     
                        includelib C:\masm32\lib\comctl32.lib
                        includelib C:\masm32\lib\user32.lib
                        includelib C:\masm32\lib\gdi32.lib
                        includelib C:\masm32\lib\kernel32.lib                
                        includelib C:\masm32\lib\user32.lib
                        includelib C:\masm32\lib\advapi32.lib      
;###########################################################
FUNCTION_CLIENT   PROTO   :DWORD ,  :DWORD 
;###########################################################
;data--data--data--data--data--data--data--data--data--data--     PROC
;----------------------------------------------------------------------------------------------
.DATA

;-
String_CAPTION             DB  "LOCAL  STRING",0

;##############################################################
;code--code--code--code--code--code--code--code--code--code-- PROC
;--------------------------------------------------------------------------------------------------
.CODE  
START:

	     mov   EAX  ,  55555555h
	     mov    EBX  ,  66666666h	     
	     ;-
	INVOKE FUNCTION_CLIENT     ,   EAX  , EBX 
	          ;-        
	          
          ;====================	
EXIT:     
             invoke               ExitProcess        ,       Null
;----------------------------------------------------------------------------------------------------------
;                                    GET   POINT  SCREEN                                                        
;---------------------------------------------------------------------------------------------------------- 
FUNCTION_CLIENT  PROC     Par_1  :DWORD  , Par_2 :DWORD 
local _Var1: DWORD 
local  _Var2  :DWORD 
;-
      		mov      Eax , Par_1
      		mov      _Var1  ,  Eax
;- 
      push   Par_2
      push   _Var2
               
;-
ret  8
FUNCTION_CLIENT   ENDP
;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
END  START

