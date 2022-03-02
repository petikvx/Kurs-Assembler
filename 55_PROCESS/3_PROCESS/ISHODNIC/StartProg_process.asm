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
 St_INFO          STARTUPINFO      <0>
  Pr_INFO        PROCESS_INFORMATION    <0>
;-
CMD    DB     "C:\WINDOWS\system32\cmd.exe",0
param_dir  db   "/kdir",0

;###################################################
;code--code--code--code--code--code--code--code--code--code-- PROC
;----------------------------------------------------------------------------------------------
.CODE  
START:
          ;===================
              ;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                   mov St_INFO.cb   ,  size STARTUPINFO 
                   mov St_INFO.dwX , 100
                   mov St_INFO.dwY , 200
                   mov  St_INFO.dwXSize , 500
                   mov  St_INFO.dwYSize , 500
                   mov  St_INFO.dwFillAttribute , BACKGROUND_BLUE +  FOREGROUND_GREEN +\
                   							FOREGROUND_RED +  FOREGROUND_INTENSITY
                   								;----------------------------------------------------
                   mov  St_INFO.dwFlags , STARTF_USEPOSITION  + \
                                                                      STARTF_USESIZE + STARTF_USEFILLATTRIBUTE
              ;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>           
              invoke     CreateProcess ,  addr CMD  , \  ;"C:\WINDOWS\system32\cmd.exe"
              		             addr   param_dir,\                         ;"/kdir"
              		             NULL ,\
              		             NULL  ,\
              		             NULL , \
              		             NULL , \
              		             NULL , \
              		             NULL , \
              		           addr  St_INFO   , \ 
              		           addr  Pr_INFO
              		     
           invoke GetLastError   		           

EXIT:     
             invoke               ExitProcess        ,       Null
;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
END  START

