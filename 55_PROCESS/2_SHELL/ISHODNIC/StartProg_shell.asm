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
Operation_explore         DB  "explore",0
Operation_properties    DB  "properties",0
Operation_open              DB  "open",0
;-
Name_WINDOWS    DB     "C:\WINDOWS ",0
Url_Net        DB    "http://exevideo.net",0
RegEdit    DB     "C:\WINDOWS\regedit.exe",0
;-
WinWord   DB     "WINWORD",0 ; /f DECADA.doc",0;
param  db     "english-verbs.doc ",0
folder      db     "." ,0
;-
CMD    db   "cmd.exe",0
param_dir  db   "/kdir",0
;-
SExInfo                  SHELLEXECUTEINFO   <?>

;###################################################
;code--code--code--code--code--code--code--code--code--code-- PROC
;----------------------------------------------------------------------------------------------
.CODE  
START:
          ;===================
              invoke     ShellExecute ,  null , \          ;
              		     addr  Operation_explore   ,\   ;  "EXPLORE"
              		     addr  Name_WINDOWS ,\      ;  "C:\WINDOWS "     просмотрщик   windows
              		      NULL  ,\        			   
              		      NULL  ,\				 
              		      SW_SHOWNORMAL 	
          ;===================
          
           ;===================
              invoke     ShellExecute ,  null , \           
              		     addr  Operation_open   ,\          ; "OPEN"
              		     addr  Url_Net  ,\                            ; "http://exevideo.net"     интернет-страница (web-броузер)   -  
              		      NULL  ,\        			 
              		      NULL  ,\				  
              		      SW_SHOWNORMAL 	
          ;===================
          
          ;===================
              invoke     ShellExecute ,  null , \           
              		     addr  Operation_open   ,\          ; "OPEN"
              		     addr  WinWord  ,\                       ; "WINWORD"     документ Word   
              		     addr  param ,\        	               ;  "/f  english-verbs.doc"  
              		     addr folder   ,\		               ;  текущий каталог      "."
              		     SW_SHOWNORMAL           
          ;===================
          
           ;===================
              invoke   ShellExecute , null ,\ 
                                   addr  Operation_open ,   ; "OPEN"
                                   addr  CMD ,\                          ; cmd.exe   -  командная строка в черном окне         
                                   addr param_dir ,\                 ;  "/kdir"  -  вывод  списка файлов текущего каталога
                                   addr folder ,\ 
                                   SW_SHOWNORMAL          
           ;===================
          
          ;===================
              invoke  RtlZeroMemory  ,  addr  SExInfo  ,  size  SHELLEXECUTEINFO
              ;>>>>>>>>>>>>>>>>>
                     MOV     SExInfo.cbSize   ,   size  SHELLEXECUTEINFO
                     MOV     SExInfo.lpFile     ,     offset   RegEdit                                        ;  "C:\WINDOWS\regedit.exe"
                     MOV     SExInfo.lpVerb   ,     offset   Operation_properties               ;  "properties"    свойства файла
                     MOV     SExInfo.fMask    ,         SEE_MASK_INVOKEIDLIST
              ;>>>>>>>>>>>>>>>>> 
             invoke     ShellExecuteEx ,  addr SExInfo     
                  ;-----------
            
                  invoke  Sleep, 10000
                 
                 
EXIT:     
             invoke               ExitProcess        ,       Null
;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
END  START

