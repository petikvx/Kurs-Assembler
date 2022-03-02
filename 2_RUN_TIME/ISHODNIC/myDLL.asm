.386P
.model flat, stdcall
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
                         includelib C:\masm32\lib\comdlg32
                        includelib C:\masm32\lib\user32.lib
                        includelib  C:\masm32\lib\shell32.lib
                        includelib C:\masm32\lib\gdi32.lib
                        includelib C:\masm32\lib\kernel32.lib                
                        includelib C:\masm32\lib\user32.lib
                        includelib C:\masm32\lib\advapi32.lib     
;-PROTO--PROTO--PROTO--PROTO--PROTO--PROTO--PROTO--PROTO-                        
DLL_GET_TIME_proc               PROTO      hWnd1:DWORD  ,\
								       ptrSHABLON :DWORD , ptrCONTENER :DWORD
;############################################################################
;data--data--data--data--data--data--data--data--data--data--data--data--data--data-- proc
;-------------------------------------------------------------------------------------------------------------------------
.DATA
;---
HINST_DLL                           DD          0
;---
.CODE
;#############################################################################
;code--code--code--code--code--code--code--code--code--code--code--code--code- proc 
;--------------------------------------------------------------------------------------------------------------------------
DLLENTRY@12:

MAIN_DLL_FUNC        PROC         hinstDLL :DWORD  ,  hReason:DWORD ,  ReservedParam:DWORD
;   
            		   mov   EAX  ,   hReason
		CMP    EAX    ,  DLL_PROCESS_ATTACH  ;   equ 1        загрузка DLL в процесс
	       je    $_ATTACH_
	       ;---
		CMP    EAX    ,  DLL_THREAD_ATTACH      ;   equ 2       загрузка  DLL в поток
 	      je     FINISH
 	      ;---
		CMP    EAX   ,  DLL_THREAD_DETACH       ;   equ 3      выгрузка  из  потока
 	       je    FINISH
 	       ;---
		CMP    EAX   ,  DLL_PROCESS_DETACH    ;   equ 0      выгрузка  из процесса
  	       je   FINISH
  	       ;---
  	       ;===========================================
$_ATTACH_:
                       mMOV   HINST_DLL    ,   hinstDLL
             jmp   FINISH
             
;-
FINISH:  
      mov           EAX   ,  TRUE
RET 12
MAIN_DLL_FUNC     ENDP
;--------------------------------------------------------------------------------------------------------------------------
;                                                    TIME                                                                                           
;--------------------------------------------------------------------------------------------------------------------------
DLL_GET_TIME_proc                PROC   export          hWnd1:DWORD  ,\
										 ptrSHABLON :DWORD , ptrCONTENER :DWORD 
local  _Loc_Time:SYSTEMTIME      
local  _MY_DATE[8]:DWORD
;-
		invoke   GetLocalTime   , addr  _Loc_Time
		 ;-
		 invoke   RtlZeroMemory  ,  addr   _MY_DATE ,  32
		             
		            mMOV     word ptr     _MY_DATE[0]  ,         _Loc_Time.wYear
		            mMOV      word ptr   _MY_DATE[4]   ,       _Loc_Time.wMonth		              
		             mMOV      word ptr   _MY_DATE[8]   ,      _Loc_Time.wDayOfWeek
		             mMOV     word ptr   _MY_DATE[12]   ,      _Loc_Time.wDay
		             mMOV      word ptr   _MY_DATE[16]   ,      _Loc_Time.wHour
		             mMOV      word ptr   _MY_DATE[20]   ,      _Loc_Time.wMinute
		             mMOV      word ptr   _MY_DATE[24]   ,      _Loc_Time.wSecond		          
		             mMOV      word ptr   _MY_DATE[28]   ,     _Loc_Time.wMilliseconds
 	                ;-                          
		      invoke   wsprintf  ,   ptrCONTENER   ,  ptrSHABLON  , _MY_DATE[0] ,\
							 _MY_DATE[4]  , _MY_DATE[8]  , _MY_DATE[12]  , _MY_DATE[16]  ,\
							  _MY_DATE[20]  , _MY_DATE[24]    ,  _MY_DATE[28] 	              		              		              		              		              		              		              
		     invoke    SendDlgItemMessage   , hWnd1 ,  2  ,  WM_SETTEXT  ,  0  ,   ptrCONTENER
		     

;-
RET  12
DLL_GET_TIME_proc                ENDP
;--------------------------------------------------------------------------------------------------------------------------
;###################################################################
END DLLENTRY@12

