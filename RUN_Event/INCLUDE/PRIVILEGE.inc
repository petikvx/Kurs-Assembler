
extern OpenProcessToken@12:near
extern LookupPrivilegeValueA@12:near
extern AdjustTokenPrivileges@24:near

LUID STRUC
  LowPart   DWORD      ?
  HighPart  DWORD      ?
LUID ENDS

LUID_AND_ATTRIBUTES STRUC
    Luid_ LUID <?>
    Attributes dd ?
LUID_AND_ATTRIBUTES ENDS

TOKEN_PRIVILEGES STRUC
  PrivilegeCount    DWORD      ?
  Privileges_        LUID_AND_ATTRIBUTES <>;ANYSIZE_ARRAY dup
TOKEN_PRIVILEGES ENDS



PRIVILEGE_SET STRUC
  PrivilegeCount    DWORD      ?
  Control           DWORD      ?
  Privilege  LUID_AND_ATTRIBUTES <>;ANYSIZE_ARRAY dup
PRIVILEGE_SET ENDS

SE_PRIVILEGE_ENABLED_BY_DEFAULT equ (00000001h)
SE_PRIVILEGE_ENABLED equ 00000002h
SE_PRIVILEGE_USED_FOR_ACCESS equ (80000000h)
PRIVILEGE_SET_ALL_NECESSARY equ (1)
SE_CREATE_TOKEN_NAME equ "SeCreateTokenPrivilege"
SE_ASSIGNPRIMARYTOKEN_NAME equ "SeAssignPrimaryTokenPrivilege"
SE_LOCK_MEMORY_NAME equ "SeLockMemoryPrivilege"
SE_INCREASE_QUOTA_NAME equ ("SeIncreaseQuotaPrivilege")
SE_UNSOLICITED_INPUT_NAME equ ("SeUnsolicitedInputPrivilege")
SE_MACHINE_ACCOUNT_NAME equ ("SeMachineAccountPrivilege")
SE_TCB_NAME equ ("SeTcbPrivilege")
SE_SECURITY_NAME equ ("SeSecurityPrivilege")
SE_TAKE_OWNERSHIP_NAME equ ("SeTakeOwnershipPrivilege")
SE_LOAD_DRIVER_NAME equ ("SeLoadDriverPrivilege")
SE_SYSTEM_PROFILE_NAME equ ("SeSystemProfilePrivilege")
SE_SYSTEMTIME_NAME equ ("SeSystemtimePrivilege")
SE_PROF_SINGLE_PROCESS_NAME equ ("SeProfileSingleProcessPrivilege")
SE_INC_BASE_PRIORITY_NAME equ ("SeIncreaseBasePriorityPrivilege")
SE_CREATE_PAGEFILE_NAME equ ("SeCreatePagefilePrivilege")
SE_CREATE_PERMANENT_NAME equ ("SeCreatePermanentPrivilege")
SE_BACKUP_NAME equ ("SeBackupPrivilege")
SE_RESTORE_NAME equ ("SeRestorePrivilege")
SE_SHUTDOWN_NAME equ ("SeShutdownPrivilege")
SE_DEBUG_NAME equ ("SeDebugPrivilege")
SE_AUDIT_NAME equ ("SeAuditPrivilege")
SE_SYSTEM_ENVIRONMENT_NAME equ ("SeSystemEnvironmentPrivilege")
SE_CHANGE_NOTIFY_NAME equ ("SeChangeNotifyPrivilege")
SE_REMOTE_SHUTDOWN_NAME equ ("SeRemoteShutdownPrivilege")

TOKEN_ASSIGN_PRIMARY equ (0001h)
TOKEN_DUPLICATE equ (0002h)
TOKEN_IMPERSONATE equ (0004h)
TOKEN_QUERY equ (0008h)
TOKEN_QUERY_SOURCE equ (0010h)
TOKEN_ADJUST_PRIVILEGES equ (0020h)
TOKEN_ADJUST_GROUPS equ (0040h)
TOKEN_ADJUST_DEFAULT equ (0080h)
TOKEN_ADJUST_SESSIONID equ (0100h)
TOKEN_ALL_ACCESS equ (STANDARD_RIGHTS_REQUIRED+TOKEN_ASSIGN_PRIMARY+TOKEN_DUPLICATE+ \
                          TOKEN_IMPERSONATE+TOKEN_QUERY+TOKEN_QUERY_SOURCE+ \
                          TOKEN_ADJUST_PRIVILEGES+TOKEN_ADJUST_GROUPS+TOKEN_ADJUST_SESSIONID+ \
                          TOKEN_ADJUST_DEFAULT)
TOKEN_READ equ (STANDARD_RIGHTS_READ+TOKEN_QUERY)
TOKEN_WRITE equ (STANDARD_RIGHTS_WRITE+TOKEN_ADJUST_PRIVILEGES+TOKEN_ADJUST_GROUPS+TOKEN_ADJUST_DEFAULT)
TOKEN_EXECUTE equ (STANDARD_RIGHTS_EXECUTE)
TOKEN_SOURCE_LENGTH equ 8


;##############################################################
;SAMPLE
;push offset hToken
;push TOKEN_ADJUST_PRIVILEGES
;push -1
;call OpenProcessToken@12
;
;push offset hLuid
;push offset  SE_DEBUG_NAME_
;push 0
;call LookupPrivilegeValueA@12
;;....................................
;   mov eax,hLuid.LowPart
;mov DWORD PTR cardin[4],eax
;   mov eax,hLuid.HighPart
;mov DWORD PTR cardin[8],eax 
;
;mov DWORD PTR cardin,1
;mov DWORD PTR cardin[12],SE_PRIVILEGE_ENABLED
; push ebp
; mov ebp,esp
; sub esp,24h
; mov DWORD PTR [esp],1
;         mov eax,hLuid.LowPart
; mov  [esp+4],EAX
;        mov eax,hLuid.HighPart
; mov  [esp+8],EAX
; mov  [esp+0ch],DWORD PTR 2
; mov eax,esp
;push 0    ;receives required size of the PreviousState buffer
;push 0    ;receives original state of changed privileges
;push 0    ;size, in bytes, of the PreviousState buffer
;push eax      ;pointer to new privilege information
;push 0          ;flag for disabling all privileges
;
;push hToken
;call AdjustTokenPrivileges@24