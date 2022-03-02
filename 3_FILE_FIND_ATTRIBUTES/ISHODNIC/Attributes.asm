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
                         
;###########################################################                        
GET_ATTRIBUTESS_proc    PROTO       hWnd_  :DWORD ,     ptrName_:DWORD         
FORMAT_TIME_proc    PROTO           ptrFILETIME_:DWORD,  ptrLabel: DWORD ,  ptrBuffer:DWORD  
FORMAT_ATTRIBUTES_proc    PROTO    ATTRIBUTE:DWORD,  ptrLabel: DWORD , ptrBuffer:DWORD         
;###########################################################
;data--data--data--data--data--data--data--data--data--data--     PROC
;----------------------------------------------------------------------------------------------
.DATA
;-
My_      PROGRAMM_CONST  <>
;-
str_FILE_ATTRIBUTE_ARCHIVE             db   "архивный файл",0 
str_FILE_ATTRIBUTE_COMPRESSED      db   "сжатый файл",0 
str_FILE_ATTRIBUTE_DIRECTORY         db   "директория",0 
str_FILE_ATTRIBUTE_HIDDEN              db   "скрытый файл",0 
str_FILE_ATTRIBUTE_NORMAL              db   "обычный файл",0 
str_FILE_ATTRIBUTE_OFFLINE              db   "файл недоступен",0 
str_FILE_ATTRIBUTE_READONLY           db   "файл только для чтения",0 
str_FILE_ATTRIBUTE_SYSTEM               db   "системный файл",0 
str_FILE_ATTRIBUTE_TEMPORARY         db   "временный файл",0 
               
     
TEMPLATE    DB       "%s%dчас:%dмин, %dгод",0
CONTENER         DB    256   dup (0)
;##############################################################
;code--code--code--code--code--code--code--code--code--code-- PROC
;--------------------------------------------------------------------------------------------------
.CODE  
START:         
;---------------------------------------------------------------------------------------------------------------------------
;                                           WINDOW        PROCEDURE                                                              
;---------------------------------------------------------------------------------------------------------------------------
GET_ATTRIBUTESS_proc    PROC   USES  EBX   ESI  EDI  \
                  	                                         hWnd_  :DWORD ,    ptrName_:DWORD  
                  	                                                                             
local    H_FIND: DWORD   
local    FILE_DATA_   :WIN32_FIND_DATA
local    formatString[256]:BYTE             	                                                                              
;-
invoke Beep , 3000 , 100
           ;--- находим  файл в текущей директории
           invOKe    FindFirstFile ,   ptrName_ ,   addr   FILE_DATA_
           mov     H_FIND   ,   EAX                                                 ;-          
           ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
           .if      H_FIND   !=    NULL

                     ; время  создания 
                     invoke  FORMAT_TIME_proc,    addr  FILE_DATA_.ftCreationTime,    addr  My_.TEXT_TIME_CREATE,  
                                                                                                                      addr  formatString          
                     invoke    SetDlgItemText,  hWnd_,  My_.CONTROL_TIME_CREATE,  addr  formatString       
                                                      
                     ; время  последнего доступа
                     invoke  FORMAT_TIME_proc,    addr  FILE_DATA_.ftLastAccessTime,   addr  My_.TEXT_TIME_ACCESS,  
                                                                                                                                    addr  formatString     
                     invoke    SetDlgItemText,  hWnd_,  My_.CONTROL_TIME_ACCESS ,  addr  formatString
                        
                     ; время  последней записи
                     invoke   FORMAT_TIME_proc,    addr  FILE_DATA_.ftLastWriteTime,     addr  My_.TEXT_TIME_WRITE,  
                                                                                                                                    addr  formatString   
                     invoke    SetDlgItemText,  hWnd_,  My_.CONTROL_TIME_WRITE,  addr  formatString
                        
                     ; атрибут
                     invoke  FORMAT_ATTRIBUTES_proc,    FILE_DATA_.dwFileAttributes,       addr  My_.TEXT_ATTRIBUTES,  
                                                                                                                                          addr  formatString  
                     invoke    SetDlgItemText,  hWnd_,  My_.CONTROL_ATTRIBUTES,  addr  formatString                               
                        
                     invoke    FindClose   ,  H_FIND                                   
             .endif                                                                                   	
;- 
FINISH:
RET  8                      					  
GET_ATTRIBUTESS_proc    ENDP
;-----------------------------------------------------------------------------------------------------------------------------------------
;                                                TIME   to     STRING                                                                      
;-----------------------------------------------------------------------------------------------------------------------------------------
FORMAT_TIME_proc    PROC   USES  EBX   ESI  EDI \ 
                                            ptrFILETIME_:DWORD,  ptrLabel: DWORD,  ptrBuffer:DWORD  
                	                                                                             
;-                                         
local    _Loc_Time: SYSTEMTIME
local  _MY_DATE[8]:DWORD              	                                                                             
;-                  			       
       ;-  переводим файловое время в локальное время                          
       invoke    FileTimeToSystemTime,  ptrFILETIME_  ,   addr  _Loc_Time
		 ;-
		 invoke    RtlZeroMemory  ,  addr   _MY_DATE ,  32

		             mMOV      word ptr   _MY_DATE[0]     ,     _Loc_Time.wYear
		             mMOV      word ptr   _MY_DATE[4]     ,     _Loc_Time.wMonth		              
		             mMOV      word ptr   _MY_DATE[8]     ,     _Loc_Time.wDayOfWeek
		             mMOV      word ptr   _MY_DATE[12]   ,     _Loc_Time.wDay
		             mMOV      word ptr   _MY_DATE[16]   ,     _Loc_Time.wHour
		             mMOV      word ptr   _MY_DATE[20]   ,     _Loc_Time.wMinute
		             mMOV      word ptr   _MY_DATE[24]   ,     _Loc_Time.wSecond		          
		             mMOV      word ptr   _MY_DATE[28]   ,     _Loc_Time.wMilliseconds
					                		              		              		              		              		              		              
         ;-  форматируем вывод   
         invoke    wsprintf,   ptrBuffer   ,  addr  TEMPLATE  , ptrLabel ,   _MY_DATE[16],\  ;TIME_.wHour ,  
	                                                                                                  _MY_DATE[20],\  ;TIME_.wMinute,  
	                                                                                                  _MY_DATE[0]      ;TIME_. wYear       
;- 
FINISH:
RET  12                      					  
FORMAT_TIME_proc    ENDP
;-----------------------------------------------------------------------------------------------------------------------------------------
;                                                   ATTRIBUTES   to    STRING                                                               
;-----------------------------------------------------------------------------------------------------------------------------------------
FORMAT_ATTRIBUTES_proc    PROC   USES  EBX   ESI  EDI \ 
                                     ATTRIBUTE:DWORD,  ptrLabel: DWORD , ptrBuffer:DWORD                                              
   	                                                                             
;-                  			       
                                 invoke    RtlZeroMemory,  ptrBuffer,  256  ;обнуляем строку-буфер
                                 invoke    lstrcpy,   ptrBuffer ,   ptrLabel    ; копируем  "метку" для строки

                         mov  EBX   ,   ATTRIBUTE
                         
                        CMP  EBX   ,   FILE_ATTRIBUTE_ARCHIVE	
                      je    $_FILE_ATTRIBUTE_ARCHIVE_                      
                        CMP  EBX   ,   FILE_ATTRIBUTE_COMPRESSED	
                      je    $_FILE_ATTRIBUTE_COMPRESSED_                      
                        CMP  EBX   ,   FILE_ATTRIBUTE_DIRECTORY	
                      je    $_FILE_ATTRIBUTE_DIRECTORY_                      
                        CMP  EBX   ,   FILE_ATTRIBUTE_HIDDEN	
                      je    $_FILE_ATTRIBUTE_HIDDEN_                      
                        CMP  EBX   ,   FILE_ATTRIBUTE_NORMAL	
                      je    $_FILE_ATTRIBUTE_NORMAL_                      
                        CMP  EBX   ,   FILE_ATTRIBUTE_OFFLINE	
                      je    $_FILE_ATTRIBUTE_OFFLINE_                      
                        CMP  EBX   ,   FILE_ATTRIBUTE_READONLY	
                      je    $_FILE_ATTRIBUTE_READONLY_                      
                        CMP  EBX   ,   FILE_ATTRIBUTE_SYSTEM	
                      je    $_FILE_ATTRIBUTE_SYSTEM_                      
                        CMP  EBX   ,   FILE_ATTRIBUTE_TEMPORARY
                      je    $_FILE_ATTRIBUTE_TEMPORARY_      		              		              		              		              		              
        
        
$_FILE_ATTRIBUTE_ARCHIVE_:
                              invoke    lstrcat,   ptrBuffer   ,  addr  str_FILE_ATTRIBUTE_ARCHIVE
          jmp FINISH                      
$_FILE_ATTRIBUTE_COMPRESSED_:
                              invoke    lstrcat,   ptrBuffer   ,  addr  str_FILE_ATTRIBUTE_COMPRESSED
          jmp FINISH                                            
$_FILE_ATTRIBUTE_DIRECTORY_ :
                              invoke    lstrcat,   ptrBuffer   ,  addr  str_FILE_ATTRIBUTE_DIRECTORY
          jmp FINISH                                           
$_FILE_ATTRIBUTE_HIDDEN_ :
                              invoke    lstrcat,   ptrBuffer   ,  addr  str_FILE_ATTRIBUTE_HIDDEN
          jmp FINISH                                           
$_FILE_ATTRIBUTE_NORMAL_:
                              invoke    lstrcat,   ptrBuffer   ,  addr  str_FILE_ATTRIBUTE_NORMAL
          jmp FINISH                                            
$_FILE_ATTRIBUTE_OFFLINE_ :
                              invoke    lstrcat,   ptrBuffer   ,  addr  str_FILE_ATTRIBUTE_OFFLINE
          jmp FINISH                                           
$_FILE_ATTRIBUTE_READONLY_:
                              invoke    lstrcat,   ptrBuffer   ,  addr  str_FILE_ATTRIBUTE_READONLY
          jmp FINISH                                            
$_FILE_ATTRIBUTE_SYSTEM_ :
                              invoke    lstrcat,   ptrBuffer   ,  addr  str_FILE_ATTRIBUTE_SYSTEM
          jmp FINISH                                           
$_FILE_ATTRIBUTE_TEMPORARY_ :
                              invoke    lstrcat,   ptrBuffer   ,  addr  str_FILE_ATTRIBUTE_TEMPORARY
          jmp FINISH                                   
     
;- 
FINISH:


RET  12                      					  
FORMAT_ATTRIBUTES_proc    ENDP
;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

END

