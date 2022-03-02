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
MODULE_OPEN_FILE     PROTO     hWnd1:DWORD 
 
;###########################################################
EXTERN    HINST:DWORD 

;###########################################################
;data--data--data--data--data--data--data--data--data--data--     PROC
;----------------------------------------------------------------------------------------------
.DATA
;-
SECTION_CREATE_FILE   DB  "CREATE_FILE",0   ; SECTION
       NAME_FILE      db   "NAME_FILE",0
SECTION_CREATE_MAP   DB  "CREATE_MAP",0    ; SECTION
       READ_BYTES   db    "READ_BYTES",0	
;---
FILE_PROFILE_NAME   DB  ".\PROFILE.cnt",0  ; .\   указывает на текущий каталог
;---
DEF_STRING       db   "NO FILE",0
Str_FILE_NAME             DB  256 dup (0);
NULL_STRING               DB  0 , 0 , 0 , 0
;##############################################################
;code--code--code--code--code--code--code--code--code--code-- PROC
;--------------------------------------------------------------------------------------------------
.CODE 
START: 
;---------------------------------------------------------------------------------------------------------------------------------
;                                                       TIMER                                                                              
;---------------------------------------------------------------------------------------------------------------------------------
MODULE_OPEN_FILE      PROC   hWnd1:DWORD 
local   _hFile :DWORD
local   _hMap:DWORD
local   _Ptr  :DWORD
;-

             ;  считываем   им€ файла  
                 invoke   GetPrivateProfileString  , addr  SECTION_CREATE_FILE   , addr  NAME_FILE   ,\
                 					      addr  DEF_STRING ,  addr  Str_FILE_NAME , 255  ,\
                 					      addr   FILE_PROFILE_NAME               
             ;        получить ’ЁЌƒЋ файла 
            invoke   CreateFile  ,   addr   Str_FILE_NAME ,   GENERIC_READ + GENERIC_WRITE  ,\
            				 FILE_SHARE_READ + FILE_SHARE_WRITE ,  NULL , \
            				 OPEN_EXISTING  , FILE_ATTRIBUTE_NORMAL  ,  NULL
            				
           .IF   EAX  != INVALID_HANDLE_VALUE  ;  FFFFFFFFh            				 
                         mov  _hFile  ,  EAX   ; ’ЁЌƒЋ файла

                       
                       invoke     CreateFileMapping  ,  _hFile  ,  NULL  ,  PAGE_READWRITE  ,  0 ,  0 , 0
                         mov    _hMap  ,  EAX
                                ;  считываем   данные  размера области  мэппинга
  			  invoke   GetPrivateProfileInt  ,  addr  SECTION_CREATE_MAP  , addr READ_BYTES  ,\
  			       NULL  ,  addr   FILE_PROFILE_NAME 
  			     
  			  ;-                    
                       invoke    MapViewOfFile ,  _hMap  ,   FILE_MAP_WRITE ,  0 ,  0  ,   EAX                    
                         mov    _Ptr  ,  EAX 
                        
                        ;---------------------------------------
                            invoke   SendDlgItemMessage  ,   hWnd1  ,  1 ,  WM_SETTEXT  ,  Null  ,  _Ptr
                        
                        ;---------------------------------------
                        invoke   UnmapViewOfFile  ,  _Ptr
                        invoke   CloseHandle   ,   _hMap
                        invoke   CloseHandle   ,   _hFile
           .ENDIF
;-
$_FINISH_:
XOR   EAX  , EAX  ;  обнулим  EAX   на выходе 
ret  4
MODULE_OPEN_FILE       ENDP

END 









