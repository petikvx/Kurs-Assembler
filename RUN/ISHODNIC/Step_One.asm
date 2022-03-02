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

;###########################################################
;data--data--data--data--data--data--data--data--data--data--     PROC
;----------------------------------------------------------------------------------------------
.DATA

String_TEXT                  db      100 dup (0)
;##############################################################
;code--code--code--code--code--code--code--code--code--code-- PROC
;--------------------------------------------------------------------------------------------------
.CODE  
START:  	                                  
	;====================	
      MOV  EAX  ,  3
      NEG   EAX  
  
      MOV   EBX  ,  3
      NOT     EBX  
       add      EBX   ,    1
            ;====================   
       MOV  EAX  ,  -3
       NEG    EAX 
       
       MOV  EBX  ,  -3
       NOT  EBX
       add   EBX  , 1            
  
  
          ;====================	
EXIT:     
             invoke               ExitProcess        ,       Null

;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
END  START

