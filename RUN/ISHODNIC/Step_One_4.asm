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
MY_PROC_COMMAND  PROTO   :DWORD , :DWORD 
;###########################################################
;data--data--data--data--data--data--data--data--data--data--     PROC
;----------------------------------------------------------------------------------------------
.DATA
HWND_WIN             DWORD        NULL
ptr_STRING             DD         NULL       ; ��������� �� ������ 
Len_STRING            DD         NULL           ; ������ ������
;-
String_CAPTION             db      "��������",0
String_TEXT                  db      100 dup (0)
;##############################################################
;code--code--code--code--code--code--code--code--code--code-- PROC
;--------------------------------------------------------------------------------------------------
.CODE  
START:  	                                  
	;====================	
	invoke   GetCommandLine 
	  Mov    ptr_STRING    ,   Eax   
	;-       
	invoke   lstrlen  ,  ptr_STRING
	  Mov    Len_STRING   ,  Eax        
	;-
	INVOKE   MY_PROC_COMMAND  ,  ptr_STRING , Len_STRING                                     	       
          ;====================	
EXIT:     
             invoke               ExitProcess        ,       Null
;-------------------------------------------------------------------==
;                        GET      COMMAND   PARAMS                               
;---------------------------------------------------------------------
MY_PROC_COMMAND   PROC   ptrString_ :DWORD , LenString_ :DWORD
;-
PUSHAD
   ;------
     MOV     EBX  ,   ptrString_
     XOR     ECX  ,   ECX      
     ;-  ����  ��������   ������� ������� � ������
   $_CIKLE_:
                     ;-
                         CMP    byte ptr [ EBX ]  ,   ' ' ; 20h ( ������ )
                      jne   $$_dalshe_    
                               ;###  ���� ������� ��  ��������
                               invoke  MessageBox ,  Null ,\
                               			EBX ,\ ; ������ ���������
                               			addr String_CAPTION ,\
                               			Null  
                                  POPAD			
                               Jmp   $_FINISH_ 			                              
                               ;###
               $$_dalshe_:
                       inc   ECX
                       inc   EBX
                       ;-
                       CMP    ECX  ,   LenString_
                    JB  $_CIKLE_  
   ;------
POPAD
;-
$_FINISH_:
RET  8
MY_PROC_COMMAND   ENDP
;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
END  START

