;*********************************************************************************************************************************************
CRITICAL_SECTION     struc
         Debug_Info                   DWORD  ?
         LockCount                    DWORD  ?
         RecursionCount           DWORD ?
         OwningThread             DWORD ?
         LockSemaphore       DWORD ?
         SpinCount                       DWORD ?
CRITiCAL_SECTION       ends
;*********************************************************************************************************************************************
InitializeCriticalSection   proto  stdcall      :dword
EnterCriticalSection     proto   stdcall        :dword
LeaveCriticalSection   proto  stdcall      :dword 
DeleteCriticalSection   proto  stdcall     :dword 