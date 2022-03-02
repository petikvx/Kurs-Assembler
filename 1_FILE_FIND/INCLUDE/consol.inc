STD_OUTPUT_HANDLE equ -11
STD_INPUT_HANDLE equ -10
STARTF_USESHOWWINDOW equ 1

GWL_WNDPROC                         equ -4
GWL_HINSTANCE                         equ -6
GWL_HWNDPARENT                      equ -8
GWL_ID                                                      equ -12
GWL_STYLE                            equ -16
GWL_EXSTYLE                          equ -20
GWL_USERDATA                         equ -21

GCL_MENUNAME	  = -8
GCL_HBRBACKGROUND = -10
GCL_HCURSOR	  = -12
GCL_HICON	  = -14
GCL_HMODULE	  = -16
GCL_CBWNDEXTRA	  = -18
GCL_CBCLSEXTRA	  = -20
GCL_WNDPROC	  = -24
GCL_STYLE	  = -26
GCW_ATOM	  = -32
GCL_HICONSM	  = -34

;--------------------------------
FILE_ATTRIBUTE_READONLY equ 1h
FILE_ATTRIBUTE_HIDDEN equ 2h
FILE_ATTRIBUTE_SYSTEM equ 4h
FILE_ATTRIBUTE_DIRECTORY equ 10h
FILE_ATTRIBUTE_ARCHIVE equ 20h
FILE_ATTRIBUTE_NORMAL equ 80h
FILE_ATTRIBUTE_TEMPORARY equ 100h
FILE_ATTRIBUTE_COMPRESSED equ 800h

;----------------------------------------  
FILE_ATTRIBUTE_OFFLINE equ 1000h 
  
GENERIC_READ equ 80000000h
GENERIC_WRITE equ 40000000h
FILE_FLAG_RANDOM_ACCESS equ 10000000h
FILE_ATTRIBUTE_NORMAL   equ 80h
OPEN_EXISTING equ 3
FILE_SHARE_READ  equ 1
 GEN_1= GENERIC_WRITE or GENERIC_READ 
 
FILE_MAP_COPY equ 1
FILE_MAP_WRITE equ 2
FILE_MAP_READ equ  4
FILE_MAP_ALL equ 000F0000h+00000002h+00000008h+00000010h

FILE_BEGIN   equ 0
FILE_CURRENT equ 1
FILE_END     equ 2

FILE_BEGIN                           equ 0
FILE_CURRENT                         equ 1
FILE_END                             equ 2
FILE_FLAG_WRITE_THROUGH              equ 80000000h
FILE_FLAG_OVERLAPPED                 equ 40000000h
FILE_FLAG_NO_BUFFERING               equ 20000000h
FILE_FLAG_RANDOM_ACCESS              equ 10000000h
FILE_FLAG_SEQUENTIAL_SCAN            equ 8000000h
FILE_FLAG_DELETE_ON_CLOSE            equ 4000000h
FILE_FLAG_BACKUP_SEMANTICS           equ 2000000h
FILE_FLAG_POSIX_SEMANTICS            equ 1000000h
;-----------------------------------------------------------                                   

;

extern CharToOemA@8:near
extern GetStdHandle@4:near
extern WriteConsoleA@20:near
extern ReadConsoleA@20:near
extern GetCommandLineA@0:near
wsprintfA PROTO C :DWORD,:VARARG



extern lstrlenA@4:near
extern lstrcpyA@8:near
extern lstrcat@8:near 
extern lstrcmp@8:near
extern lstrcmpi@8:near
extern WideCharToMultiByte@32:near
extern MultiByteToWideChar@24:near

extern GetFileTitleA@12:near
extern GetFileSize@8:near
extern GetFileAttributesA@4:near
extern SetFileAttributesA@8:near
extern SetFilePointer@16:near
extern CreateFileA@28:near
extern ReadFile@20:near
extern FindFirstFileA@8:near
extern FindNextFileA@8:near
extern FindClose@4:near

extern GetFullPathNameA@16:near
extern GetCurrentDirectoryA@8:near
extern SetCurrentDirectoryA@4:near

extern CreateFileMappingA@24:near
extern MapViewOfFile@20:near
extern UnmapViewOfFile@4:near
extern CreateMutexA@12:near


extern PostQuitMessage@4:near
extern RegisterClassA@4:near
extern RegisterClassExA@4:near
extern GetMessageA@16:near
extern TranslateMessage@4:near
extern DispatchMessageA@4:near
extern GetLastError@0:near


extern CreateWindowExA@48:near
extern CreateUpDownControl@48:near
extern DialogBoxParamA@20:near
extern MessageBoxA@16:near
extern EndDialog@8:near

extern PostMessageA@16:near
extern SendMessageA@16:near
extern SendDlgItemMessageA@20:near
extern GetDlgItem@8:near
extern DefWindowProcA@16:near
extern CallWindowProcA@20:near
extern SetWindowLongA@12:near
extern TrackMouseEvent@4:near
extern Beep@8:near

extern GetDesktopWindow@0:near
extern EnableWindow@8:near
extern SetWindowTextA@8:near
extern GetWindowTextA@12:near
extern IsWindow@4:near
extern IsWindowVisible@4:near
extern IsIconic@4:near
extern GetParent@4:near
extern GetWindow@8:near
extern GetDlgCtrlID@4:near
extern FindWindowA@8:near
extern FindWindowExA@16:near
extern GetCursorPos@4:near
extern SetCursorPos@8:near
extern WindowFromPoint@8:near
extern ChildWindowFromPoint@12:near
extern SetFocus@4:near
extern ShowWindow@8:near
extern UpdateWindow@4:near
extern GetWindowLongA@8:near
extern SetWindowLongA@12:near
extern SetWindowPos@28:near
extern GetWindowRect@8:near
extern MoveWindow@24:near
extern GetWindowRect@8:near
extern GetForegroundWindow@0:near
extern SetForegroundWindow@4:near



extern SetClassLongA@12:near
extern GetClassLongA@8:near
extern GetClassNameA@12:near
extern GlobalAddAtomA@4:near
extern GlobalFindAtomA@4:near
extern GlobalGetAtomNameA@12:near
extern GlobalDeleteAtom@4:near
extern InitAtomTable@4:near


extern Sleep@4:near
extern CreateThread@24:near
extern SetTimer@16:near
extern KillTimer@8:near
extern timeSetEvent@20:near
extern timeKillEvent@4:near

extern MessageBeep@4:near
extern Beep@8:near
extern PlaySound@12:near

extern RegisterClassExA@4:near
extern RegisterWindowMessageA@4:near
extern EnumWindows@8:near
extern EnumChildWindows@12:near

extern ClientToScreen@8:near
extern ShowCursor@4:near
extern SetCursor@4:near
extern SetCapture@4:near
extern GetCapture@0:near
extern ReleaseCapture@0:near


;--------------------------------------------------------------
HWND_BROADCAST                       equ 0FFFFh
WM_USER                              equ 400h
WM_NULL                              equ 0h
WM_CREATE                            equ 1h
WM_DESTROY                           equ 2h
WM_MOVE                              equ 3h
WM_SIZE                              equ 5h
WM_ACTIVATE                          equ 6h
WA_INACTIVE                          equ 0
WA_ACTIVE                            equ 1
WA_CLICKACTIVE                       equ 2
WM_SETFOCUS                          equ 7h
WM_KILLFOCUS                         equ 08h
WM_ENABLE                            equ 0Ah
WM_SETREDRAW                         equ 0Bh
WM_SETTEXT                           equ 0Ch
WM_GETTEXT                           equ 0Dh
WM_GETTEXTLENGTH                     equ 0Eh
WM_PAINT                             equ 0Fh
WM_CLOSE                             equ 10h
WM_QUERYENDSESSION                   equ 11h
WM_QUIT                              equ 12h
WM_QUERYOPEN                         equ 13h
WM_ERASEBKGND                        equ 14h
WM_SYSCOLORCHANGE                    equ 15h
WM_ENDSESSION                        equ 16h
WM_SHOWWINDOW                        equ 18h
WM_WININICHANGE                      equ 1Ah
WM_SETTINGCHANGE                	  equ WM_WININICHANGE
WM_DEVMODECHANGE                     equ 1Bh
WM_ACTIVATEAPP                       equ 1Ch
WM_FONTCHANGE                        equ 1Dh
WM_TIMECHANGE                        equ 1Eh
WM_CANCELMODE                        equ 1Fh
WM_SETCURSOR                         equ 20h
WM_MOUSEACTIVATE                     equ 21h
WM_CHILDACTIVATE                     equ 22h
WM_QUEUESYNC                         equ 23h
WM_GETMINMAXINFO                     equ 24h
WM_PAINTICON                         equ 26h
WM_ICONERASEBKGND                    equ 27h
WM_NEXTDLGCTL                        equ 28h
WM_SPOOLERSTATUS                     equ 2Ah
WM_DRAWITEM                          equ 2Bh
WM_MEASUREITEM                       equ 2Ch
WM_DELETEITEM                        equ 2Dh
WM_VKEYTOITEM                        equ 2Eh
WM_CHARTOITEM                        equ 2Fh
WM_SETFONT                           equ 30h
WM_GETFONT                           equ 31h
WM_SETHOTKEY                         equ 32h
WM_GETHOTKEY                         equ 33h
WM_QUERYDRAGICON                     equ 37h
WM_COMPAREITEM                       equ 39h
WM_GETOBJECT                    	  equ 3Dh
WM_COMPACTING                        equ 41h
WM_OTHERWINDOWCREATED                equ 42h
WM_OTHERWINDOWDESTROYED              equ 43h
WM_COMMNOTIFY                        equ 44h
CN_RECEIVE                           equ 1h
CN_TRANSMIT                          equ 2h
CN_EVENT                             equ 4h
WM_WINDOWPOSCHANGING                 equ 46h
WM_WINDOWPOSCHANGED                  equ 47h
WM_POWER                             equ 48h
PWR_OK                               equ 1
PWR_FAIL                             equ -1
PWR_SUSPENDREQUEST                   equ 1
PWR_SUSPENDRESUME                    equ 2
PWR_CRITICALRESUME                   equ 3
WM_COPYDATA                          equ 4Ah
WM_CANCELJOURNAL                     equ 4Bh
WM_NOTIFY                            equ 4Eh
WM_INPUTLANGCHANGEREQUEST            equ 50h
WM_INPUTLANGCHANGE                   equ 51h
WM_TCARD                             equ 52h
WM_HELP                              equ 53h
WM_USERCHANGED                       equ 54h
WM_NOTIFYFORMAT                      equ 55h
WM_CONTEXTMENU                       equ 7Bh
WM_STYLECHANGING                     equ 7Ch
WM_STYLECHANGED                      equ 7Dh
WM_DISPLAYCHANGE                     equ 7Eh
WM_GETICON                           equ 7Fh
WM_SETICON                           equ 80h
WM_NCCREATE                          equ 81h
WM_NCDESTROY                         equ 82h
WM_NCCALCSIZE                        equ 83h
WM_NCHITTEST                         equ 84h
WM_NCPAINT                           equ 85h
WM_NCACTIVATE                        equ 86h
WM_GETDLGCODE                        equ 87h
WM_SYNCPAINT                    	  equ 88h
WM_NCMOUSEMOVE                       equ 0A0h
WM_NCLBUTTONDOWN                     equ 0A1h
WM_NCLBUTTONUP                       equ 0A2h
WM_NCLBUTTONDBLCLK                   equ 0A3h
WM_NCRBUTTONDOWN                     equ 0A4h
WM_NCRBUTTONUP                       equ 0A5h
WM_NCRBUTTONDBLCLK                   equ 0A6h
WM_NCMBUTTONDOWN                     equ 0A7h
WM_NCMBUTTONUP                       equ 0A8h
WM_NCMBUTTONDBLCLK                   equ 0A9h
WM_KEYFIRST                          equ 100h
WM_KEYDOWN                           equ 100h
WM_KEYUP                             equ 101h
WM_CHAR                              equ 102h
WM_DEADCHAR                          equ 103h
WM_SYSKEYDOWN                        equ 104h
WM_SYSKEYUP                          equ 105h
WM_SYSCHAR                           equ 106h
WM_SYSDEADCHAR                       equ 107h
WM_KEYLAST                           equ 108h
WM_INITDIALOG                        equ 110h
WM_COMMAND                           equ 111h
WM_SYSCOMMAND                        equ 112h
WM_TIMER                             equ 113h
WM_HSCROLL                           equ 114h
WM_VSCROLL                           equ 115h
WM_INITMENU                          equ 116h
WM_INITMENUPOPUP                     equ 117h
WM_MENUSELECT                        equ 11Fh
WM_MENUCHAR                          equ 120h
WM_ENTERIDLE                         equ 121h
WM_CTLCOLORMSGBOX                    equ 132h
WM_CTLCOLOREDIT                      equ 133h
WM_CTLCOLORLISTBOX                   equ 134h
WM_CTLCOLORBTN                       equ 135h
WM_CTLCOLORDLG                       equ 136h
WM_CTLCOLORSCROLLBAR                 equ 137h
WM_CTLCOLORSTATIC                    equ 138h
WM_MOUSEFIRST                        equ 200h
WM_MOUSEMOVE                         equ 200h
WM_LBUTTONDOWN                       equ 201h
WM_LBUTTONUP                         equ 202h
WM_LBUTTONDBLCLK                     equ 203h
WM_RBUTTONDOWN                       equ 204h
WM_RBUTTONUP                         equ 205h
WM_RBUTTONDBLCLK                     equ 206h
WM_MBUTTONDOWN                       equ 207h
WM_MBUTTONUP                         equ 208h
WM_MBUTTONDBLCLK                     equ 209h
WM_MOUSELAST                         equ 209h
WM_PARENTNOTIFY                      equ 210h
WM_ENTERMENULOOP                     equ 211h
WM_EXITMENULOOP                      equ 212h
WM_MDICREATE                         equ 220h
WM_MDIDESTROY                        equ 221h
WM_MDIACTIVATE                       equ 222h
WM_MDIRESTORE                        equ 223h
WM_MDINEXT                           equ 224h
WM_MDIMAXIMIZE                       equ 225h
WM_MDITILE                           equ 226h
WM_MDICASCADE                        equ 227h
WM_MDIICONARRANGE                    equ 228h
WM_MDIGETACTIVE                      equ 229h
WM_MDISETMENU                        equ 230h
WM_DROPFILES                         equ 233h
WM_MDIREFRESHMENU                    equ 234h
WM_CUT                               equ 300h
WM_COPY                              equ 301h
WM_PASTE                             equ 302h
WM_CLEAR                             equ 303h
WM_UNDO                              equ 304h
WM_RENDERFORMAT                      equ 305h
WM_RENDERALLFORMATS                  equ 306h
WM_DESTROYCLIPBOARD                  equ 307h
WM_DRAWCLIPBOARD                     equ 308h
WM_PAINTCLIPBOARD                    equ 309h
WM_VSCROLLCLIPBOARD                  equ 30Ah
WM_SIZECLIPBOARD                     equ 30Bh
WM_ASKCBFORMATNAME                   equ 30Ch
WM_CHANGECBCHAIN                     equ 30Dh
WM_HSCROLLCLIPBOARD                  equ 30Eh
WM_QUERYNEWPALETTE                   equ 30Fh
WM_PALETTEISCHANGING                 equ 310h
WM_PALETTECHANGED                    equ 311h
WM_HOTKEY                            equ 312h
WM_PRINT                        	  equ 317h
WM_PRINTCLIENT                       equ 318h
WM_PENWINFIRST                       equ 380h
WM_PENWINLAST                        equ 38Fh
BM_CLICK         equ 0f5h
BM_SETIMAGE                          equ 0F7h


CM_MOUSELEAVE    equ 0b014h
CM_MOUSEENTER    equ 0b013h
;TrackBarWndProc
;----------------------------------------------------------------
HTERROR   equ  0fffffffeh
HTSYSMENU	equ  03h

;------------------------
_FIND STRUC;характеристика файла
ATR dword  ?
CRTIME dword ?
       dword ?
ACTIME dword ?
       dword ?
WRTIME dword ?
       dword ?
SIZEN dword ?
SIZEL dword ?
      dword ?
      dword ?
NAM db 260 dup (0)
ANAM db 14 dup (0)
_FIND ENDS
 ;-----------------------------------------------------------------
 MSGSTRUCT STRUC
       MSHWND    DD ?
       MSMESAGE DD ?
       MSWPARAM  DD ?
       MSLPARAM  DD ?
       MSTIME    DD ?
       MSPT      DD ?
 MSGSTRUCT ENDS    
 ;----------------------------------------

 WNDCLASS STRUC
       
        CLSSTYLE   DD ?
        CLWNDPROC  DD ?
        CLSCBCLSEX DD ?
        CLSCBWNDEX DD ?
        CLSHINST   DD ?
        CLSHICON   DD ?
        CLSHCURSOR DD ?
        CLBKGROUND DD ?
        CLMENNAME  DD ?
        CLSNAME    DD ?
        
 WNDCLASS ENDS
;...........................................  
 WNDCLASSEX STRUCT
  CLSSIZE    DD      ?
  CLSSTYLE   DD ?
  CLWNDPROC  DD ?
  CLSCBCLSEX DD ?
  CLSCBWNDEX DD ?
  CLSHINST   DD ?
  CLSHICON   DD ?
  CLSHCURSOR DD ?
  CLBKGROUND DD ?
  CLMENNAME  DD ?
  CLSNAME    DD ?
  HICONSML   DD      ?
WNDCLASSEX ENDS  
 ;-----------------------------------------
 WH_KEYBOARD  equ  2
 WH_DEBUG     equ  9
 WH_CALLWNDPROC equ 4
 WH_CALLWNDPROCRET equ 0ch
 
 
 
 WS_OVERLAPPED                       equ        0h
WS_POPUP                             equ 80000000h
WS_CHILD                             equ 40000000h
WS_MINIMIZE                          equ 20000000h
WS_VISIBLE                           equ 10000000h
WS_DISABLED                          equ  8000000h
WS_CLIPSIBLINGS                      equ  4000000h
WS_CLIPCHILDREN                      equ  2000000h
WS_MAXIMIZE                          equ  1000000h
WS_CAPTION                           equ  0C00000h
WS_BORDER                            equ   800000h
WS_DLGFRAME                          equ   400000h
WS_VSCROLL                           equ   200000h
WS_HSCROLL                           equ   100000h
WS_SYSMENU                           equ    80000h
WS_THICKFRAME                        equ    40000h
WS_GROUP                             equ    20000h
WS_TABSTOP                           equ    10000h
WS_MINIMIZEBOX                       equ    20000h
WS_MAXIMIZEBOX                       equ    10000h
WS_TILED                             equ WS_OVERLAPPED
WS_ICONIC                            equ WS_MINIMIZE
WS_SIZEBOX                           equ WS_THICKFRAME
WS_OVERLAPPEDWINDOW                  equ WS_OVERLAPPED OR WS_CAPTION OR WS_SYSMENU OR WS_THICKFRAME OR WS_MINIMIZEBOX OR WS_MAXIMIZEBOX
WS_TILEDWINDOW                       equ WS_OVERLAPPEDWINDOW
WS_POPUPWINDOW                       equ WS_POPUP OR WS_BORDER OR WS_SYSMENU
WS_CHILDWINDOW                       equ WS_CHILD
WS_EX_DLGMODALFRAME                  equ        1h
WS_EX_NOPARENTNOTIFY                 equ        4h
WS_EX_TOPMOST                        equ        8h
WS_EX_ACCEPTFILES                    equ       10h
WS_EX_TRANSPARENT                    equ       20h
WS_EX_MDICHILD                       equ 00000040h
WS_EX_TOOLWINDOW                     equ 00000080h
WS_EX_WINDOWEDGE                     equ 00000100h
WS_EX_CLIENTEDGE                     equ 00000200h
WS_EX_CONTEXTHELP                    equ 00000400h
WS_EX_RIGHT                          equ 00001000h
WS_EX_LEFT                           equ 00000000h
WS_EX_RTLREADING                     equ 00002000h
WS_EX_LTRREADING                     equ 00000000h
WS_EX_LEFTSCROLLBAR                  equ 00004000h
WS_EX_RIGHTSCROLLBAR                 equ 00000000h
WS_EX_CONTROLPARENT                  equ 00010000h
WS_EX_STATICEDGE                     equ 00020000h
WS_EX_APPWINDOW                      equ 00040000h
WS_EX_OVERLAPPEDWINDOW               equ WS_EX_WINDOWEDGE OR WS_EX_CLIENTEDGE
WS_EX_PALETTEWINDOW                  equ WS_EX_WINDOWEDGE OR WS_EX_TOOLWINDOW OR WS_EX_TOPMOST
 
  SW_HIDE                              equ 0
  SW_SHOWNORMAL                        equ 1
  SW_NORMAL                            equ 1
  SW_SHOWMINIMIZED                     equ 2
  SW_SHOWMAXIMIZED                     equ 3
  SW_MAXIMIZE                          equ 3
  SW_SHOWNOACTIVATE                    equ 4
  SW_SHOW                              equ 5
  SW_MINIMIZE                          equ 6
  SW_SHOWMINNOACTIVE                   equ 7
  SW_SHOWNA                            equ 8
  SW_RESTORE                           equ 9
  SW_SHOWDEFAULT                       equ 10
  SW_MAX                                      equ 10
SWP_NOSIZE                              equ 1h
SWP_NOMOVE                           equ 2h
SWP_NOZORDER                     equ 4h
SWP_NOREDRAW                    equ 8h
SWP_NOACTIVATE                  equ 10h
SWP_FRAMECHANGED         equ 20h
SWP_SHOWWINDOW             equ 40h
SWP_HIDEWINDOW                equ 80h
SWP_NOCOPYBITS                  equ 100h
SWP_NOOWNERZORDER      equ 200h
SWP_DRAWFRAME                   equ SWP_FRAMECHANGED
SWP_NOREPOSITION              equ SWP_NOOWNERZORDER
SWP_DEFERERASE      	           equ 2000h
SWP_ASYNCWINDOWPOS  	 equ 4000h
    BS_DEFPUSHBUTTON    equ 1
    BS_3STATE           equ 5
    BS_USERBUTTON       equ 8
    BS_ICON             equ   00000040h
    BS_FLAT             			  equ 8000h

  BS_BITMAP       equ   00000080h
  IMAGE_BITMAP                equ 0
IMAGE_ICON                  equ 1
IMAGE_CURSOR                equ 2
IMAGE_ENHMETAFILE           equ 3

    
    DS_3DLOOK           equ 4 
    ES_MULTILINE equ  4h
 CS_HREDRAW   equ  2h
 CS_VREDRAW   equ   1h
 CS_GLOBALCLASS  equ 4000h
 CS_NOCLOSE      equ 512	
  IDI_APPLICATION                      equ 32512
  IDI_HAND                             equ 32513
  IDI_QUESTION                         equ 32514
  IDI_EXCLAMATION                      equ 32515
  IDI_ASTERISK                         equ 32516

IDC_ARROW                            equ 32512
IDC_IBEAM                            equ 32513
IDC_WAIT                             equ 32514
IDC_CROSS                            equ 32515
IDC_UPARROW                          equ 32516
IDC_SIZE                             equ 32640
IDC_ICON                             equ 32641
IDC_SIZENWSE                         equ 32642
IDC_SIZENESW                         equ 32643
IDC_SIZEWE                           equ 32644
IDC_SIZENS                           equ 32645
IDC_SIZEALL                          equ 32646
IDC_NO                               equ 32648
IDC_HAND            			  equ 32649
IDC_APPSTARTING                      equ 32650
IDC_HELP            			  equ 32651         
 HC_ACTION   equ   0
 HC_NOREMOVE  equ  3
 ES_READONLY equ 800h ;style edit
 RT_RCDATA   equ 0ah
 CW_USEDEFAULT equ	80000000h  
   
 
;---------------------------------------
SPI_GETMOUSEOVERHEIGHT equ 64h
SPI_GETMOUSEHOVERWIDTH equ 62h
SPI_GETMOUSEHOVERTIME  equ 66h
;----------------------------------------
 
 CP_ACP              equ      0   ; default to ANSI code page
 CP_OEMCP            equ      1   ; default to OEM  code page
 CP_MACCP            equ      2   ; default to MAC  code page
 
 
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
HSHELL_WINDOWCREATED                 equ 1
HSHELL_WINDOWDESTROYED               equ 2
HSHELL_ACTIVATESHELLWINDOW           equ 3
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
PM_NOREMOVE                          equ 0h
PM_REMOVE                            equ 1h
PM_NOYIELD                           equ 2h
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

;###########################################################
;###########################################################
;GETWINDOW
;###########################################################
GW_HWNDFIRST                         equ 0
GW_HWNDLAST                          equ 1
GW_HWNDNEXT                          equ 2
GW_HWNDPREV                          equ 3
GW_OWNER                             equ 4
GW_CHILD                             equ 5
GW_MAX                               equ 5
GW_ENABLEDPOPUP     			  equ 6
;------------------------------------------------------------
MF_INSERT                            equ 0h
MF_CHANGE                            equ 80h
MF_APPEND                            equ 100h
MF_DELETE                            equ 200h
MF_REMOVE                            equ 1000h
MF_BYCOMMAND                         equ 0h
MF_BYPOSITION                        equ 400h
MF_SEPARATOR                         equ 800h
MF_ENABLED                           equ 0h
MF_GRAYED                            equ 1h
MF_DISABLED                          equ 2h
MF_UNCHECKED                         equ 0h
MF_CHECKED                           equ 8h
MF_USECHECKBITMAPS                   equ 200h
MF_STRING                            equ 0h
MF_BITMAP                            equ 4h
MF_OWNERDRAW                         equ 100h
MF_POPUP                             equ 10h
MF_MENUBARBREAK                      equ 20h
MF_MENUBREAK                         equ 40h
MF_UNHILITE                          equ 0h
MF_HILITE                            equ 80h
MF_SYSMENU                           equ 2000h
MF_HELP                              equ 4000h
MF_MOUSESELECT                       equ 8000h
MF_END                               equ 80h
MF_DEFAULT          	       equ 1000h
MF_RIGHTJUSTIFY     	       equ 4000h
;---------------------------------------------------------------
HWND_TOP                             equ 0
HWND_BOTTOM                          equ 1
HWND_TOPMOST                         equ -1
HWND_NOTOPMOST                       equ -2
;---------------------------------------------------------------
HORZRES                              equ 8
VERTRES                              equ 10
