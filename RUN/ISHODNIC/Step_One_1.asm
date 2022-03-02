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
FUNCTION_CLIENT   PROTO  
;###########################################################
;data--data--data--data--data--data--data--data--data--data--     PROC
;----------------------------------------------------------------------------------------------
.DATA

;-
String_CAPTION             DB  30 dup  (0)

;##############################################################
;code--code--code--code--code--code--code--code--code--code-- PROC
;--------------------------------------------------------------------------------------------------
.CODE  
START:
    
	     ;-
	INVOKE FUNCTION_CLIENT 
	          ;-        
	          
          ;====================	
EXIT:     
             invoke               ExitProcess        ,       Null
;----------------------------------------------------------------------------------------------------------
;                                    GET   POINT  SCREEN                                                        
;---------------------------------------------------------------------------------------------------------- 
FUNCTION_CLIENT  PROC    
local  _Var1 , _Var2 , _Var3  :DWORD 
local   _String[256] : BYTE
local   _pMas [30]    :DWORD  
local  _Var4           :WORD
local  _Var5       :POINT
;-

 
;- 
               
;-
RET
FUNCTION_CLIENT   ENDP
;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
END  START

