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
Str_FILE_NAME             DB  "nesterenko.txt"
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
             ;        получить ХЭНДЛ файла 
            invoke   CreateFile  ,   addr   Str_FILE_NAME ,   GENERIC_READ + GENERIC_WRITE  ,\
            				 FILE_SHARE_READ + FILE_SHARE_WRITE ,  NULL , \
            				 OPEN_EXISTING  , FILE_ATTRIBUTE_NORMAL  ,  NULL
           .IF   EAX  != INVALID_HANDLE_VALUE  ;  FFFFFFFFh            				 
                         mov  _hFile  ,  EAX   ; ХЭНДЛ файла
                       invoke     CreateFileMapping  ,  _hFile  ,  NULL  ,  PAGE_READWRITE  ,  0 , 0 , NULL
                         mov    _hMap  ,  EAX
                       invoke    MapViewOfFile ,  _hMap  ,   FILE_MAP_ALL_ACCESS  ,  0 , 0 , null
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
ret  4
MODULE_OPEN_FILE       ENDP

END 









