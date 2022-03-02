          .386
        .model flat,stdcall
  option   casemap:none
                        include C:\masm32\INCLUDE\WINDOWS.INC
                        include C:\masm32\INCLUDE\KERNEL32.INC 
                        include C:\masm32\INCLUDE\USER32.INC
                        include   C:\masm32\INCLUDE\SHELL32.INC                          
                        include C:\masm32\INCLUDE\ADVAPI32.INC 
                        include   C:\masm32\INCLUDE\GDI32.INC       
                        include    C:\masm32\INCLUDE\comdlg32.inc                                    
                        include  my.inc
                        
                        includelib C:\masm32\lib\masm32.lib     
                         includelib C:\MASM32\LIB\ole32.lib                                                                                                         
                         includelib C:\masm32\lib\comdlg32
                        includelib C:\masm32\lib\user32.lib
                        includelib  C:\masm32\lib\shell32.lib
                        includelib C:\masm32\lib\gdi32.lib
                        includelib C:\masm32\lib\kernel32.lib                
                        includelib C:\masm32\lib\user32.lib
                        includelib C:\masm32\lib\advapi32.lib                            
;###################################################

;###################################################
;data--data--data--data--data--data--data--data--data--data--     PROC
;----------------------------------------------------------------------------------------------
.DATA
;-
Name_PROGRAM    DB     "C:\WINDOWS\regedit.exe",0
;###################################################
;code--code--code--code--code--code--code--code--code--code-- PROC
;----------------------------------------------------------------------------------------------
.CODE  
START:
          ;===================
                 invoke   WinExec  ,  addr  Name_PROGRAM , SW_SHOWNORMAL	
          ;===================
EXIT:     
             invoke               ExitProcess        ,       Null
;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
END  START

