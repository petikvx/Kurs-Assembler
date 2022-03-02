includelib C:\masm32\LIB\ntdll.lib
RtlInitUnicodeString  PROTO    :DWORD , :DWORD          
RtlAnsiStringToUnicodeString  PROTO  :DWORD , :DWORD  , :DWORD   
ZwOpenSection           PROTO  :DWORD , :DWORD  , :DWORD    
  
ANSI_STRING  struc
     _MaxLen        dw         0
     _Length           dw        0
     _Buffer             DD       0
     
ANSI_STRING  ends
;-
UNICODE_STRING    TYPEDEF   ANSI_STRING 
PUNICODE_STRING   TYPEDEF    PTR UNICODE_STRING

ULONG     typedef      DWORD
PVOID         typedef      DWORD
;------------------------------------------------------------------------
 OBJ_CASE_INSENSITIVE    equ     00000040h
 OBJ_OPENIF                            equ      00000080h
 OBJ_OPENLINK                      equ       00000100h
OBJ_KERNEL_HANDLE      equ        00000200h
 DELETE                            equ                 00010000h
 READ_CONTROL         equ                 00020000h
 WRITE_DAC                   equ                 00040000h
 WRITE_OWNER           equ                 00080000h
 SYNCHRONIZE             equ                 00100000h
 ;-------------------------------------------------------------------------
 OBJECT_ATTRIBUTES    struc
                    _Length                                       ULONG      0     ;
                    _RootDirectory                       HANDLE    0      ;
                    _ObjectName                            PUNICODE_STRING    0  ;
                   _Attributes                                    ULONG     0      ;
                   _SecurityDescriptor                 PVOID      0         ;        // Points to type SECURITY_DESCRIPTOR
                    _SecurityQualityOfService    PVOID    0           ;       // Points to type SECURITY_QUALITY_OF_SERVICE
OBJECT_ATTRIBUTES  ends
;------------------------------
 GATE_DESCRIPTOR  struc  
                   OffsetLo     Word    0;   // нижние 2 байта адреса
                   Selector      Word    0;   // кодовый селектор (определяет привилегии)
                   Attributes      Word    0; // атрибуты шлюза
                  OffsetHi      Word    0;   // верхние 2 байта адреса
 GATE_DESCRIPTOR   ends
 ;----------
 TFAR_CALL     struc   WORD
                 _Offset            DWORD       ?
                 _Selector        Word             ?
TFAR_CALL     ends      


;"""""""""""""""""""""""""""""""""""""
GDT_INFO  struc    byte
                _LIMIT    WORD     ?
                _BASE   DWORD  ?
GDT_INFO  ends
;"""""""""""""""""""""""""""""""""""""
 NO_INHERITANCE                                         equ    0
 SUB_OBJECTS_ONLY_INHERIT          equ    1
 SUB_CONTAINERS_ONLY_INHERIT   equ    2
 SUB_CONTAINERS_AND_OBJECTS_INHERIT   equ    3
 INHERIT_NO_PROPAGATE      equ    4
 INHERIT_ONLY                equ    8
;""""""""""""""""""""""""""""""""""""""
;typedef  enum   _SE_OBJECT_TYPE    
;{

              SE_UNKNOWN_OBJECT_TYPE   equ   0 
              SE_FILE_OBJECT                               equ  1
              SE_SERVICE                                         equ  2
               SE_PRINTER                                      equ 3
               SE_REGISTRY_KEY                       equ  4
               SE_LMSHARE                                 equ   5
               SE_KERNEL_OBJECT                equ  6
               SE_WINDOW_OBJECT             equ  7
;}  SE_OBJECT_TYPE ends ;
;-----------------------------------------------------------------------------------------------------------------
ACL   struct
       AclRevision      BYTE                 ?; 
       Sbz1                    BYTE                 ?; 
       
       AclSize         WORD     ?; 
       AceCount      WORD    ?; 
       Sbz2                WORD   ?; 
ACL   ENDS

;typedef enum _TRUSTEE_FORM
;{
    TRUSTEE_IS_SID             equ   0
    TRUSTEE_IS_NAME       equ    1
;} TRUSTEE_FORM;
;" " " " " " " " " " " " " " " " " " " " " 
;typedef enum _MULTIPLE_TRUSTEE_OPERATION
;{
        NO_MULTIPLE_TRUSTEE     equ  0
        TRUSTEE_IS_IMPERSONATE     equ  1
;} MULTIPLE_TRUSTEE_OPERATION    
;" " " " " " " " " " " " " " " " " " " " " 
;typedef enum _TRUSTEE_TYPE
;{
                   TRUSTEE_IS_UNKNOWN     equ  0
                   TRUSTEE_IS_USER                 equ  1
                   TRUSTEE_IS_GROUP              equ 2
;} TRUSTEE_TYPE;
;" " " " " " " " " " " " " " " " " " " " " "
TRUSTEE    STRUC

                       pMultipleTrustee                           DD          0    ;          PTRUSTEE
                        MultipleTrusteeOperation        dword   0         ;MULTIPLE_TRUSTEE_OPERATION
                       TrusteeForm                                  dword   0         ; TRUSTEE_FORM
                       TrusteeType                                  dword     0;TRUSTEE_TYPE
                      ptstrName                                     DD            0;    LPTSTR
    
TRUSTEE   ENDS

;ENUM  ACCESS_MODE

               NOT_USED_ACCESS            equ  0
               GRANT_ACCESS                   equ     1     
               SET_ACCESS                          equ        2
               DENY_ACCESS                      equ        3
               REVOKE_ACCESS                equ      4 
               SET_AUDIT_SUCCESS        equ     5   
               SET_AUDIT_FAILURE        equ        6
;ACCESS_MODE
;""""""""""""""""""""""
EXPLICIT_ACCESS    struc
                                                 grfAccessPermissions      DWORD    0 
                                                 grfAccessMode                  DWORD     0 ;ACCESS_MODE   
                                                 grfInheritance                       DWORD    0 
                                                 Trustee                                 TRUSTEE     <>
EXPLICIT_ACCESS   ends

;------------------------------------------------------------------------------------------------------------------

;//
;// VOID
;// InitializeObjectAttributes(
;//     OUT POBJECT_ATTRIBUTES p,
;//     IN PUNICODE_STRING n,
;//     IN ULONG a,
;//     IN HANDLE r,
;//     IN PSECURITY_DESCRIPTOR s
;//     )
;//
;//--

InitializeObjectAttributes     MACRO   p, n, a, r, s 
Mov     ebx  ,   p
                       ASSUME  EBX  :  ptr  OBJECT_ATTRIBUTES
                       MOV  [ EBX ]._Length ,  size  OBJECT_ATTRIBUTES 
                       MOV  [ EBX ]._RootDirectory ,   r                       
                       MOV  [ EBX ]._Attributes ,  a
                      MOV  [ EBX ]._ObjectName    ,   n
                      MOV   [ EBX ]._SecurityDescriptor ,   s
                   mMOV  [ EBX ]._SecurityQualityOfService  ,  NULL
                     ASSUME  EBX :NOTHING
  
ENDM
