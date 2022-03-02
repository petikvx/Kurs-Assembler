;----------------------------------------------------------

DLL_PROCESS_ATTACH    equ 1
DLL_THREAD_ATTACH     equ 2
DLL_THREAD_DETACH     equ 3
DLL_PROCESS_DETACH    equ 0

WH_MSGFILTER                         equ -1
WH_JOURNALRECORD                     equ 0
WH_JOURNALPLAYBACK                   equ 1
WH_KEYBOARD                          equ 2
WH_GETMESSAGE                        equ 3
WH_CALLWNDPROC                       equ 4
WH_CBT                               equ 5
WH_SYSMSGFILTER                      equ 6
WH_MOUSE                             equ 7
WH_HARDWARE                          equ 8
WH_DEBUG                             equ 9
WH_SHELL                             equ 10
WH_FOREGROUNDIDLE                    equ 11
WH_CALLWNDPROCRET                     equ 12
;----------------------------------------
HSHELL_WINDOWCREATED                 equ 1
HSHELL_WINDOWDESTROYED               equ 2
HSHELL_ACTIVATESHELLWINDOW           equ 3
HSHELL_WINDOWACTIVATED 		equ 4
HSHELL_GETMINRECT 		equ 5
HSHELL_REDRAW 			equ 6
HSHELL_TASKMAN 			equ 7
HSHELL_LANGUAGE 			equ 8
HSHELL_ACCESSIBILITYSTATE 	equ 11
HC_ACTION                            equ 0
HC_GETNEXT                           equ 1
HC_SKIP                              equ 2
HC_NOREMOVE                          equ 3
HC_NOREM                             equ HC_NOREMOVE
HC_SYSMODALON                        equ 4
HC_SYSMODALOFF                       equ 5
HCBT_MOVESIZE                        equ 0
HCBT_MINMAX                          equ 1
HCBT_QS                              equ 2
HCBT_CREATEWND                       equ 3
HCBT_DESTROYWND                      equ 4
HCBT_ACTIVATE                        equ 5
HCBT_CLICKSKIPPED                    equ 6
HCBT_KEYSKIPPED                      equ 7
HCBT_SYSCOMMAND                      equ 8
HCBT_SETFOCUS                        equ 9

HKL_PREV                             equ 0
HKL_NEXT                             equ 1
KLF_ACTIVATE                         equ 1h
KLF_SUBSTITUTE_OK                    equ 2h
KLF_UNLOADPREVIOUS                   equ 4h
KLF_REORDER                          equ 8h
KL_NAMELENGTH                        equ 9
DESKTOP_READOBJECTS                  equ 1h
DESKTOP_CREATEWINDOW                 equ 2h
DESKTOP_CREATEMENU                   equ 4h
DESKTOP_HOOKCONTROL                  equ 8h
DESKTOP_JOURNALRECORD                equ 10h
DESKTOP_JOURNALPLAYBACK              equ 20h
DESKTOP_ENUMERATE                    equ 40h
DESKTOP_WRITEOBJECTS                 equ 80h
WINSTA_ENUMDESKTOPS                  equ 1h
WINSTA_READATTRIBUTES                equ 2h
WINSTA_ACCESSCLIPBOARD               equ 4h
WINSTA_CREATEDESKTOP                 equ 8h
WINSTA_WRITEATTRIBUTES               equ 10h
WINSTA_ACCESSGLOBALATOMS             equ 20h
WINSTA_EXITWINDOWS                   equ 40h
WINSTA_ENUMERATE                     equ 100h
WINSTA_READSCREEN                    equ 200h

;----------------------------------------
DEBUG_PROCESS                        equ 1h
DEBUG_ONLY_THIS_PROCESS              equ 2h
CREATE_SUSPENDED                     equ 4h
CREATE_SEPARATE_WOW_VDM              equ 800h
DETACHED_PROCESS                     equ 8h
CREATE_NEW_CONSOLE                   equ 10h
CREATE_NEW_PROCESS_GROUP             equ 200h
CREATE_NO_WINDOW                     equ 8000000h

NORMAL_PRIORITY_CLASS                equ 20h
IDLE_PRIORITY_CLASS                  equ 40h
HIGH_PRIORITY_CLASS                  equ 80h
REALTIME_PRIORITY_CLASS              equ 100h
;------------------------------------------


;------------------------------------------ 
 STANDARD_RIGHTS_REQUIRED  equ       000F0000h
 SYNCHRONIZE              equ        00100000h

 PROCESS_TERMINATE        equ  0001h  
 PROCESS_CREATE_THREAD    equ  0002h  
 PROCESS_SET_SESSIONID    equ  0004h  
 PROCESS_VM_OPERATION     equ  0008h  
 PROCESS_VM_READ          equ  0010h  
 PROCESS_VM_WRITE         equ  0020h  
 PROCESS_DUP_HANDLE       equ  0040h  
 PROCESS_CREATE_PROCESS   equ  0080h  
 PROCESS_SET_QUOTA        equ  0100h  
 PROCESS_SET_INFORMATION   equ 0200h  
 PROCESS_QUERY_INFORMATION equ 0400h  
 PROCESS_SUSPEND_RESUME    equ 0800h  
 PROCESS_ALL_ACCESS        equ STANDARD_RIGHTS_REQUIRED + SYNCHRONIZE + 00000FFFh
 
 DUPLICATE_CLOSE_SOURCE               equ 1h
 DUPLICATE_SAME_ACCESS                equ 2h
;-------------------------------------------------
extern CreateToolhelp32Snapshot@8:near
extern Process32First@8:near
extern Process32Next@8:near
extern Thread32First@8:near 
extern Thread32Next@8:near
extern Heap32First@12:near
extern Heap32Next@4:near
extern Heap32ListFirst@8:near
extern Heap32ListNext@8:near
extern Module32First@8:near
extern Module32Next@8:near
;

extern GetProcAddress@8:near
extern LoadLibraryA@4:near
extern FreeLibrary@4:near
extern CallNextHookEx@16:near
extern SetWindowsHookExA@16:near
extern UnhookWindowsHookEx@4:near
extern CloseHandle@4:near

extern SystemParametersInfoA@16:near
extern GetModuleHandleA@4:near
extern GetWindowThreadProcessId@8:near
extern CreateProcessA@40:near
extern OpenProcess@12:near

extern GetCurrentProcessId@0:near
extern GetCurrentProcess@0:near
extern GetCurrentThreadId@0:near
extern GetCurrentThread@0:near
 
extern GetModuleFileNameA@12:near
extern GetWindowModuleFileNameA@12:near 

extern ExitProcess@4:near
extern ExitThread@4:near
extern TerminateThread@8:near
extern GetExitCodeThread@8:near
extern ResumeThread@4:near

extern WriteProcessMemory@20:near
extern ReadProcessMemory@20:near
extern VirtualAllocEx@20:near
extern VirtualAlloc@16:near
extern VirtualFree@12:near
extern CreateRemoteThread@28:near
extern GetThreadContext@8:near
extern SetThreadContext@8:near
extern DuplicateHandle@28:near

extern GlobalAlloc@8:near
extern GlobalLock@4:near ;WRITER to handle
extern GlobalUnlock@4:near
extern GlobalFree@4:near
extern GlobalHandle@4:near ;handle to WRITER

extern RtlZeroMemory@8:near
extern LsaFreeMemory@4:near

extern RtlMoveMemory@12:near
extern IsBadCodePtr@4:near
extern IsBadReadPtr@8:near
extern IsBadWritePtr@8:near
extern IsBadStringPtrA@8:near
;---------------------------------------
INVALID_HANDLE_VALUE  equ 0FFFFFFFFh
 GMEM_FIXED                           equ 0h
GMEM_MOVEABLE                        equ 2h
GMEM_NOCOMPACT                       equ 10h
GMEM_NODISCARD                       equ 20h
GMEM_ZEROINIT                        equ 40h
GMEM_MODIFY                          equ 80h
GMEM_DISCARDABLE                     equ 100h
GMEM_NOT_BANKED                      equ 1000h
GMEM_SHARE                           equ 2000h
GMEM_DDESHARE                        equ 2000h
GMEM_NOTIFY                          equ 4000h
GMEM_LOWER                           equ GMEM_NOT_BANKED
GMEM_VALID_FLAGS                     equ 7F72h
GMEM_INVALID_HANDLE                  equ 8000h         /  c   m    
;------------------------------------------------
PROCESS_BASIC_INFORMATION  struc
   ExitStatus               dd ?
   PebBaseAddress               dd ?;pointer
   AffinityMask                 dd ?
   BasePriority                 dd    ?
   UniqueProcessId               dd ?
   InheritedFromUniqueProcessId    dd ?
  PROCESS_BASIC_INFORMATION ends
  ;----------------------------------------------------
      SYSTEM_MODULE_INFORMATION  STRUC
              Reserved       DD     2  dup (0)
              Base                PVOID          0
              _Size                  DWORD      0
              Flags                DWORD       0
              Index                                     WORD       0
              Unknown                              WORD       0
              LoadCount                           WORD         0
              ModuleNameOffset            WORD       0
              ImageName                        DB      256 dup (0)
  SYSTEM_MODULE_INFORMATION  ENDS                 
;------------------------------------------------  
;const// SYSTEM_INFORMATION_CLASS 
  SystemBasicInformation	             equ	0;
  SystemProcessorInformation	         equ	1;
  SystemPerformanceInformation         equ	2;
  SystemTimeOfDayInformation           equ	3;
  SystemNotImplemented1               equ	4;
  SystemProcessesAndThreadsInformation	equ	5;
  SystemCallCounts	                    equ	6;
  SystemConfigurationInformation	    equ	7;
  SystemProcessorTimes                equ	8;
  SystemGlobalFlag                    equ	9;
  SystemNotImplemented2               equ	10;
  SystemModuleInformation             equ	11;
  SystemLockInformation	        equ	12;
  SystemNotImplemented3	         equ	13;
  SystemNotImplemented4                equ	14;
  SystemNotImplemented5	          equ	15;
  SystemHandleInformation              equ	16;
  SystemObjectInformation	         equ	17;
  SystemPagefileInformation            equ	18;
  SystemInstructionEmulationCounts	equ	19;
  SystemInvalidInfoClass                equ	20;
  SystemCacheInformation	           equ	21;
  SystemPoolTagInformation            	equ	22;
  SystemProcessorStatistics	           equ	23;
  SystemDpcInformation                equ	24;
  SystemNotImplemented6	          equ	25;
  SystemLoadImage	                    equ	26;
  SystemUnloadImage	                    equ	27;
  SystemTimeAdjustment                  equ	28;
  SystemNotImplemented7               	equ	29;
  SystemNotImplemented8	           equ	30;
  SystemNotImplemented9               	equ	31;
  SystemCrashDumpInformation          	equ	32;
  SystemExceptionInformation          equ	33;
  SystemCrashDumpStateInformation      equ	34;
  SystemKernelDebuggerInformation     equ	35;
  SystemContextSwitchInformation	  equ	36;
  SystemRegistryQuotaInformation	equ	37;
  SystemLoadAndCallImage               	equ	38;
  SystemPrioritySeparation             equ	39;
  SystemNotImplemented10              equ	40;
  SystemNotImplemented11              equ	41;
  SystemInvalidInfoClass2              equ	42;
  SystemInvalidInfoClass3             equ	43;
  SystemTimeZoneInformation            equ	44;
  SystemLookasideInformation          equ	45;
  SystemSetTimeSlipEvent              equ	46;
  SystemCreateSession                 equ	47;
  SystemDeleteSession                  equ	48;
  SystemInvalidInfoClass4              equ	49;
  SystemRangeStartInformation         equ	50;
  SystemVerifierInformation           equ	51;
  SystemAddVerifier                    equ	52;
  SystemSessionProcessesInformation   equ	53;
  ;-------------------------------------------------------------------
  ;“»œ€ Œ¡⁄≈ “Œ¬
  ;-------------------------------------------------------------------
          OB_TYPE_UNKNOWN        equ 00;
	OB_TYPE_TYPE           equ 01;
          OB_TYPE_DIRECTORY      equ 02;
          OB_TYPE_SYMBOLIC_LINK  equ 03;
	OB_TYPE_TOKEN          equ 04;
          OB_TYPE_PROCESS        equ 05;
	OB_TYPE_THREAD         equ 06;
          OB_TYPE_JOB            equ 07;
	OB_TYPE_EVENT          equ 08;
	OB_TYPE_EVENT_PAIR     equ 09;
	OB_TYPE_MUTANT         equ 10;
	OB_TYPE_SEMAPHORE      equ 12;
	OB_TYPE_TIMER          equ 13;
	OB_TYPE_PROFILE        equ 14;
	OB_TYPE_WINDOW_STATION equ 15;
	OB_TYPE_DESKTOP        equ 16;
	OB_TYPE_SECTION        equ 17;
	OB_TYPE_KEY            equ 18;
	OB_TYPE_PORT           equ 19;
	OB_TYPE_WAITABLE_PORT  equ 20;
	OB_TYPE_IO_COMPLETION  equ 25;
	OB_TYPE_FILE           equ 28;
;------------------------------------------------------------------------
;EVENT HOOK
;------------------------------------------------------------------------	
;---------------------CONSOL_EVENT------------------------------
EVENT_MIN 				equ 1
EVENT_MAX 				equ 7FFFFFFFh
EVENT_SYSTEM_SOUND 		equ 1
EVENT_SYSTEM_ALERT 		equ 2
EVENT_SYSTEM_FOREGROUND 	equ 3
EVENT_SYSTEM_MENUSTART 		equ 4
EVENT_SYSTEM_MENUEND 		equ 5
EVENT_SYSTEM_MENUPOPUPSTART 	equ 6
EVENT_SYSTEM_MENUPOPUPEND 	equ 7
EVENT_SYSTEM_CAPTURESTART 	equ 8
EVENT_SYSTEM_CAPTUREEND 	equ 9
EVENT_SYSTEM_MOVESIZESTART 	equ 0Ah
EVENT_SYSTEM_MOVESIZEEND 	equ 0Bh
EVENT_SYSTEM_CONTEXTHELPSTART equ 0Ch
EVENT_SYSTEM_CONTEXTHELPEND 	equ 0Dh
EVENT_SYSTEM_DRAGDROPSTART 	equ 0Eh
EVENT_SYSTEM_DRAGDROPEND 	equ 0Fh
EVENT_SYSTEM_DIALOGSTART 	equ 10h
EVENT_SYSTEM_DIALOGEND 		equ 11h
EVENT_SYSTEM_SCROLLINGSTART 	equ 12h
EVENT_SYSTEM_SCROLLINGEND 	equ 13h
EVENT_SYSTEM_SWITCHSTART 	equ 14h
EVENT_SYSTEM_SWITCHEND 		equ 15h
EVENT_SYSTEM_MINIMIZESTART 	equ 16h
EVENT_SYSTEM_MINIMIZEEND 	equ 17h
EVENT_OBJECT_CREATE 		equ 8000h
EVENT_OBJECT_DESTROY 		equ 8001h
EVENT_OBJECT_SHOW 		equ 8002h
EVENT_OBJECT_HIDE 		equ 8003h
EVENT_OBJECT_REORDER 		equ 8004h
EVENT_OBJECT_FOCUS 		equ 8005h
EVENT_OBJECT_SELECTION 		equ 8006h
EVENT_OBJECT_SELECTIONADD 	equ 8007h
EVENT_OBJECT_SELECTIONREMOVE 	equ 8008h
EVENT_OBJECT_SELECTIONWITHIN 	equ 8009h
EVENT_OBJECT_STATECHANGE 	equ 800Ah
EVENT_OBJECT_LOCATIONCHANGE 	equ 800Bh
EVENT_OBJECT_NAMECHANGE 	equ 800Ch
EVENT_OBJECT_DESCRIPTIONCHANGE equ 800Dh
EVENT_OBJECT_VALUECHANGE 	equ 800Eh
EVENT_OBJECT_PARENTCHANGE 	equ 800Fh
EVENT_OBJECT_HELPCHANGE 	equ 8010h
EVENT_OBJECT_DEFACTIONCHANGE 	equ 8011h
EVENT_OBJECT_ACCELERATORCHANGE equ 8012h
;------------------------------------------------------------------------
;EVENT CONSOLE
;------------------------------------------------------------------------
EVENT_CONSOLE_CARET                              equ  4001h
EVENT_CONSOLE_UPDATE_REGION             equ  4002h
EVENT_CONSOLE_UPDATE_SIMPLE              equ  4003h
EVENT_CONSOLE_UPDATE_SCROLL              equ  4004h
EVENT_CONSOLE_LAYOUT                            equ  4005h
EVENT_CONSOLE_START_APPLICATION      equ  4006h
EVENT_CONSOLE_END_APPLICATION          equ   4007h
;ÛÒÎÓ‚Ëˇ
WINEVENT_OUTOFCONTEXT 	     	          equ 0
WINEVENT_SKIPOWNTHREAD 		equ 1
WINEVENT_SKIPOWNPROCESS 	          equ 2
WINEVENT_INCONTEXT 	                    equ 4	


  

