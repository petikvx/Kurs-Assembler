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
Win_Event_Proc          PROTO  hWinEventHook :DWORD,  event :DWORD,  hwndEVENT :DWORD,\
                                idObject   :DWORD, idChild  :DWORD,dwEventThread :DWORD, dwmsEventTime :DWORD
                                        	
DLL_SET_HOOK_proc         PROTO         hWnd1:DWORD								       
;############################################################################
;data--data--data--data--data--data--data--data--data--data--data--data--data--data-- proc
;-------------------------------------------------------------------------------------------------------------------------
_EDATA SEGMENT DWORD PUBLIC USE32 'IDATA'
;---
         HINST_DLL                           DD          0
         SHABLON                            db  "%d",0
         CONTENER                          db  256 dup (0)
         temp_hWnd                       DWORD 0;
;---
_EDATA  ENDS
;===================================================================
_DATA SEGMENT DWORD PUBLIC USE32'DATA'         ;  GLOBAL  DATA
;---
        HWND_Look                        DD       NULL                 ; ours WINDOW  
        HHOOK_WIN_EVENT                  DWORD      NULL            ;  HOOK  EVENT
        
;---
_DATA  ENDS 
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
 	      je     $_ATTACH_
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
;                                                    PROC EVENT   HOOK                                                                 
;--------------------------------------------------------------------------------------------------------------------------
Win_Event_Proc          PROC  hWinEventHook :DWORD,  event :DWORD,  hwndEVENT :DWORD,
                            idObject   :DWORD, idChild  :DWORD,dwEventThread :DWORD, dwmsEventTime :DWORD 
                            
           cmp       event      ,   EVENT_SYSTEM_MENUSTART      ;------ активация меню
       jE         $_MENU_START_       
           cmp       event     ,    EVENT_OBJECT_FOCUS   ;--- окно получило клавиатурный фокус
       jE         $_EVENT_OBJECT_FOCUS_                      
           cmp       event     ,    EVENT_SYSTEM_CAPTURESTART  ;---- захват мыши окном (SetCapture)
       jE         $_CAPTURESTART_ 	
           cmp       event      ,   4006h  ;--- старт консольного приложения  EVENT_CONSOLE_START_APPLICATION 
       jE         $_EVENT_CONSOLE_START_APPLICATION_          
           			

       jmp    $_FINISH_
       ;>>>
$_MENU_START_:                                   
                     
                      JMP    $_FINISH_            
$_EVENT_OBJECT_FOCUS_:        
                          invoke  Beep ,  3000 , 30
               ;находим верхнее окно, чтобы узнать его заголовок                            
               invoke GetForegroundWindow 
               mov temp_hWnd  , eax                          
                         invoke  SendMessage ,  temp_hWnd  , WM_GETTEXT  ,  255 , addr CONTENER
                         invoke  SendDlgItemMessage ,  HWND_Look  ,  2 , WM_SETTEXT  ,  null , addr CONTENER
                                                  
                                                  
                ;находим текущий модуль, чтобы узнать его файловый путь                                       
                invoke  GetModuleHandle ,  0
                         invoke  GetModuleFileName  ,  EAX  ,   addr  CONTENER ,  255
                         invoke  SendDlgItemMessage ,  HWND_Look  ,  3 , WM_SETTEXT  ,  null , addr CONTENER
                         
                      JMP    $_FINISH_            
                  ;_/\_____________________________________ 
$_CAPTURESTART_:                                   ;CAPTUREEND:
                       
                    invoke  Beep ,  2000 , 50
                      JMP    $_FINISH_
                    ;_/\_____________________________________
$_EVENT_CONSOLE_START_APPLICATION_:
                   
                      JMP    $_FINISH_
                    ;_/\_____________________________________                     
$_FINISH_:                    
ret 28
Win_Event_Proc         ENDP
;--------------------------------------------------------------------------------------------------------------------------
;                                                    SET  HOOK    EVENT                                                            
;--------------------------------------------------------------------------------------------------------------------------
DLL_SET_HOOK_proc                PROC   export          hWnd1:DWORD  										 
;-
   
        mMOV   HWND_Look   ,  hWnd1
        ;-
        
     invoke   SetWinEventHook  ,  EVENT_MIN   , EVENT_MAX,  ; We want all events
                                                HINST_DLL ,  Win_Event_Proc ,        0, 0,                  
                                                 WINEVENT_INCONTEXT  + WINEVENT_SKIPOWNPROCESS      
                              
          Mov  HHOOK_WIN_EVENT ,   Eax
;-
RET  4
DLL_SET_HOOK_proc               ENDP
;--------------------------------------------------------------------------------------------------------------------------
;                                                    UNSET    HOOK       EVENT                                                      
;--------------------------------------------------------------------------------------------------------------------------
DLL_UNSET_HOOK_proc                PROC   export  		 
;-
   
 	;invoke    UnhookWindowsHookEx  ,   HHOOK_Shell
         
           invoke     UnhookWinEvent  ,  HHOOK_WIN_EVENT
                 		     
;-
RET  
DLL_UNSET_HOOK_proc               ENDP
;--------------------------------------------------------------------------------------------------------------------------
;###################################################################
END DLLENTRY@12



;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

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

EVENT_CONSOLE_CARET                              equ  4001h
EVENT_CONSOLE_UPDATE_REGION             equ  4002h
EVENT_CONSOLE_UPDATE_SIMPLE              equ  4003h
EVENT_CONSOLE_UPDATE_SCROLL              equ  4004h
EVENT_CONSOLE_LAYOUT                            equ  4005h
EVENT_CONSOLE_START_APPLICATION      equ  4006h
EVENT_CONSOLE_END_APPLICATION          equ   4007h

WINEVENT_OUTOFCONTEXT 	     	          equ 0
WINEVENT_SKIPOWNTHREAD 		equ 1
WINEVENT_SKIPOWNPROCESS 	          equ 2
WINEVENT_INCONTEXT 	                    equ 4
SetWinEventHook
The SetWinEventHook function sets an event hook function for a range of events. 

HWINEVENTHOOK WINAPI SetWinEventHook(
  UINT eventMin,
  UINT eventMax,
  HMODULE hmodWinEventProc,
  WINEVENTPROC lpfnWinEventProc,
  DWORD idProcess,
  DWORD idThread,
  UINT dwflags
);
Parameters
eventMin 
[in] Specifies the event constant for the lowest event value in the range of events handled by the hook function. 
This parameter is EVENT_MIN to indicate the lowest possible event value. 
eventMax 
[in] Specifies the event constant for the highest event value in the range of events handled by the hook function. 
This parameter is EVENT_MAX to indicate the highest possible event value. 
hmodWinEventProc 
[in] Handle to the dynamic-link library (DLL) that contains the hook function at lpfnWinEventProc 
if the WINEVENT_INCONTEXT flag is specified in the dwFlags parameter. If the hook function is not located in a DLL, 
or if the WINEVENT_OUTOFCONTEXT flag is specified, this parameter is NULL. 
lpfnWinEventProc 
[in] Pointer to the event hook function. For more information about this function, see WinEventProc Callback Function. 
idProcess 
[in] Specifies the ID of the process from which the hook function receives events. Specify zero (0) to receive 
events from all processes. 
idThread 
[in] Specifies the ID of the thread from which the hook function receives events. If this parameter is zero, 
the hook function is associated with all existing threads. 
dwflags 
[in] Flag values that specify the location of the hook function and events to skip. The following flags are valid: 
WINEVENT_INCONTEXT 
The DLL that contains the callback function is mapped into the address space of the process that generates the 
event. With this flag, the system sends event notifications to the callback function as they occur. The hook function
 must be in a DLL when this flag is specified. For more information, see In-Context Hook Functions. 
WINEVENT_OUTOFCONTEXT 
The callback function is not mapped into the address space of the process that generates the event. Because the
 hook function is called across process boundaries, the system must queue events. Although this method is asynchronous,
  events are guaranteed to be in sequential order. For more information, see Out-of-Context Hook Functions. 
WINEVENT_SKIPOWNPROCESS 
Prevents this instance of the hook from receiving events generated by threads in this process. This flag does not 
prevent threads from generating events. 
WINEVENT_SKIPOWNTHREAD 
Prevents this instance of the hook from receiving events generated by the thread that is registering this hook. 
Following following flag combinations are valid: 

WINEVENT_INCONTEXT | WINEVENT_SKIPOWNPROCESS 
WINEVENT_INCONTEXT | WINEVENT_SKIPOWNTHREAD 
WINEVENT_OUTOFCONTEXT | WINEVENT_SKIPOWNPROCESS 
WINEVENT_OUTOFCONTEXT | WINEVENT_SKIPOWNTHREAD 
Additionally, client applications can specify WINEVENT_INCONTEXT, or WINEVENT_OUTOFCONTEXT alone. 

Return Values
If successful, returns an HWINEVENTHOOK value that identifies this event hook instance. Applications save this 
return value to use with the UnhookWinEvent function. 

If unsuccessful, returns zero. 

Remarks
This function allows you to specify which processes and threads you are interested in. This is useful when you want to
 work only with certain applications or with just the system. 

If the idProcess parameter is non-zero and idThread is zero, the hook function receives the specified events from all
 threads in that process. If the idProcess parameter is zero and idThread is non-zero, the hook function receives the
  specified events only from the thread specified by idThread. If both are zero, the hook function receives the specified 
  events from all threads and processes. 

Clients can call SetWinEventHook if they want to register additional hook functions.

The client thread that calls SetWinEventHook must have a message loop, sometimes known as a "GUI thread," in order
 to receive events. 

When you use a Win32 API that has a callback in managed code, such as SetWinEventHook, you should use GCHandle 
class structure to avoid exceptions. This tells the garbage collector not to move the callback. For more information, see
 GCHandle Structure. 

Requirements 
  Windows NT/2000/XP/Server 2003: Included in Windows 2000 and later.
  Windows 95/98/Me: Included in Windows 98 and later.
  Redistributable: Requires Active Accessibility 1.3 RDK on Windows NT 4.0 SP6 and Windows 95.
  Header: Declared in Winuser.h; include Windows.h.
  Library: Use User32.lib.

See Also
Registering a Hook Function, WinEventProc Callback Function, UnhookWinEvent 
;-------------------------------------------------------------------
Out-of-Context Hook Functions
The following list outlines the key aspects of out-of-context hook functions: 

Out-of-context hook functions are located in the client's address space, whether it is in the code body or in a DLL. 
Out-of-context hook functions are not mapped into the server's address space. 
When an event is triggered, the parameters for the hook function are marshaled across process boundaries. 
Out-of-context hook functions are noticeably slower than in-context hook functions due to marshaling. 
The system queues the event notifications so that they arrive asynchronously (because of the time required to perform marshaling). 
Although the event notifications are asynchronous, Active Accessibility assures that the callback function receives all events in the 
order in which they are generated. 

The USER component of the operating system allocates memory for events that are handled by out-of-context hook functions. 
The memory is freed when the hook functions return. If a hook function does not process events quickly enough,
 USER resources are lowered, eventually resulting in a fault or extremely slow response times. These problems may occur if: 

Events are fired very rapidly. 
The system is slow. 
The hook function processes events slowly. 
The client is running on Windows 9x. 


--------------------------------------------------------------------------------
;--------------------------------------------------------------------------
In-Context Hook Functions
The following list outlines the key aspects of in-context hook functions: 

In-context hooks functions must be located in a dynamic-link library (DLL) that the system maps into the 
server's address space. 
In-context hook functions share the address space with the server. 
When the server triggers an event, the system calls a hook function without marshaling, (packaging and sending inter
face parameters across process boundaries). 
In-context hook functions tend to be very fast and receive event notifications synchronously because there is no marshaling. 
Some events may be delivered out-of-process, even though you request that they be delivered in-process (using the 
WINEVENT_INCONTEXT flag). You might see this situation with 64-bit and 32-bit application interoperability issues and 
with Windows console events. 
;-------------------------------------------------------------------------------------------------------------------------------
 
Event Constants
The following section describes the events generated by the operating system and server applications. The constants are listed 
in ascending numeric order. Additionally, the EVENT_MIN constant represents the lowest possible event values, and the
 EVENT_MAX constant represents the highest possible event values. 

Prior to using these events, client applications should use Accessible Event Watcher to verify that these events are used by user 
interface (UI) elements. 

For more information about events in general, see What Are WinEvents? and System Level and Object Level Events. For more
 information 
about the events sent by the system, see Appendix A: Supported User Interface Elements Reference. 

EVENT_SYSTEM_SOUND 
A sound has been played. The system sends this event when a system sound, such as one for a menu, is played even if no sound is
audible 
(due to the lack of a sound file or sound card, for example). Servers send this event if a custom UI element generates a sound. 
For this event, the WinEventProc callback function receives the OBJID_SOUND value as the idObject parameter. 

EVENT_SYSTEM_ALERT 
An alert has been generated. Server applications send this event when a user needs to know that a user interface element has 
changed. 
For more information, see Alerts. 
This event is not sent consistently by the system for dialog box objects. This is a known issue and is being addressed. 

EVENT_SYSTEM_FOREGROUND 
The foreground window has changed. The system sends this event even if the foreground window has changed to another window in
 the same thread. Server applications never send this event. 
For this event, the WinEventProc callback function's hwnd parameter is the handle to the window that is in the foreground, and the
 idObject parameter is OBJID_WINDOW. The idChild parameter is CHILDID_SELF. 

EVENT_SYSTEM_MENUSTART 
A menu item on the menu bar has been selected. The system sends this event for standard menus, identified by HMENU, created 
using menu-template resources or Microsoft Win32 menu APIs. Servers send this event for custom menus (user interface elements
 that function as menus but are not created in the standard way). 
For this event, the WinEventProc callback function's hwnd, idObject, and idChild parameters refer to the control that contains
 the menu bar
 or the control that activates the context menu. The hwnd parameter is the handle to the window related to the event. The idObject 
 parameter is OBJID_MENU or OBJID_SYSMENU for a menu, or OBJID_WINDOW for a pop-up menu. The idChild parameter is 
 CHILDID_SELF. 

The system triggers more than one EVENT_SYSTEM_MENUSTART event that does not always correspond with the
 EVENT_SYSTEM_MENUEND event. 

EVENT_SYSTEM_MENUEND 
A menu from the menu bar has been closed. The system sends this event for standard menus. Servers send this event for custom
 menus. 
For this event, the WinEventProc callback function's hwnd, idObject, and idChild parameters refer to the control that
 contains the menu bar or the control that activates the context menu. The hwnd parameter is the handle to the window related to 
 the event. The idObject parameter is OBJID_MENU or OBJID_SYSMENU for a menu, or OBJID_WINDOW for a pop-up menu.
The idChild parameter is CHILDID_SELF. 

EVENT_SYSTEM_MENUPOPUPSTART 
A pop-up menu has been displayed. The system sends this event for standard menus, identified by HMENU, created using 
menu-template resources or Win32 menu APIs. Servers send this event for custom menus (user interface elements that 
function as menus but are not created in the standard way). 
This event is not sent consistently by the system. This is a known issue and is being addressed. 

EVENT_SYSTEM_MENUPOPUPEND 
A pop-up menu has been closed. The system sends this event for standard menus. Servers send this event for custom menus. 
When a pop-up menu is closed, the client receives this message followed by the EVENT_SYSTEM_MENUEND event. 

This event is not sent consistently by the system. This is a known problem and is being addressed. 

EVENT_SYSTEM_CAPTURESTART 
A window has received mouse capture. This event is sent by the system; servers never send this event. 
EVENT_SYSTEM_CAPTUREEND 
A window has lost mouse capture. This event is sent by the system; servers never send this event. 
EVENT_SYSTEM_MOVESIZESTART 
A window is being moved or resized. This event is sent by the system; servers never send this event. 
EVENT_SYSTEM_MOVESIZEEND 
The movement or resizing of a window has finished. This event is sent by the system; servers never send this event. 
EVENT_SYSTEM_CONTEXTHELPSTART 
A window has entered context-sensitive Help mode. 
This event is not sent consistently by the system. This is a known issue and is being addressed. 

EVENT_SYSTEM_CONTEXTHELPEND 
A window has exited context-sensitive Help mode. 
This event is not sent consistently by the system. This is a known issue and is being addressed. 

EVENT_SYSTEM_DRAGDROPSTART 
An application is about to enter drag-and-drop mode. Applications that support drag-and-drop operations must send this 
event; the system does not send this event. 
EVENT_SYSTEM_DRAGDROPEND 
An application is about to exit drag-and-drop mode. Applications that support drag-and-drop operations must send this
 event; the system does not send this event. 
EVENT_SYSTEM_DIALOGSTART 
A dialog box has been displayed. This event is sent by the system for standard dialog boxes, created using resource 
templates or Win32 dialog box APIs. Servers send this event for custom dialog boxes (windows that function as dialog boxes 
but are not created in the standard way). 
This event is not sent consistently by the system. This is a known issue and is being addressed. 

EVENT_SYSTEM_DIALOGEND 
A dialog box has been closed. This event is sent by the system for standard dialog boxes. Servers send this event for 
custom dialog boxes. 
This event is not sent consistently by the system. This is a known issue and is being addressed. 

EVENT_SYSTEM_SCROLLINGSTART 
Scrolling has started on a scroll bar. This event is sent by the system for scroll bars attached to a window and for standard
 scroll bar controls. Servers send this event for custom scroll bars (user interface elements that function as scroll bars but
  are not created in the standard way). 
The idObject parameter sent to the WinEventProc callback function is OBJID_HSCROLL for horizontal scrolls bars or 
OBJID_VSCROLL for vertical scroll bars. 

EVENT_SYSTEM_SCROLLINGEND 
Scrolling has ended on a scroll bar. This event is sent by the system for scroll bars attached to a window and for standard 
scroll bar controls. Servers send this event for custom scroll bars. 
The idObject parameter sent to the WinEventProc callback function is OBJID_HSCROLL for horizontal scroll bars or 
OBJID_VSCROLL for vertical scroll bars. 

EVENT_SYSTEM_SWITCHSTART 
The user has pressed ALT+TAB, which activates the switch window. This event is sent by the system; servers never send 
this event. The hwnd parameter of the WinEventProc callback function identifies the window the user is switching to. 
If only one application is running when the user presses ALT+TAB, the system sends an EVENT_SYSTEM_SWITCHEND 
event without a corresponding EVENT_SYSTEM_SWITCHSTART event. 

EVENT_SYSTEM_SWITCHEND 
The user has released ALT+TAB. This event is sent by the system; servers never send this event. The hwnd parameter 
of the WinEventProc callback function identifies the window the user has switched to. 
If only one application is running when the user presses ALT+TAB, the system sends this event without a corresponding 
EVENT_SYSTEM_SWITCHSTART event. 

EVENT_SYSTEM_MINIMIZESTART 
A window object is about to be minimized or maximized. This event is sent by the system; servers never send this event. 
EVENT_SYSTEM_MINIMIZEEND 
A window object has been minimized or maximized. This event is sent by the system; servers never send this event. 
EVENT_OBJECT_CREATE 
An object has been created. The system sends this event for the following user interface elements: caret, header control, 
list view control, tab control, toolbar control, tree view control, and window object. Server applications send this event for
 their accessible objects. 
Servers must send this event for all of an object's child objects before sending the event for the parent object. Servers must 
ensure that all child objects are fully created and ready to accept IAccessible calls from clients when the parent object
 sends this event. 

Because a parent object is created after its child objects, clients must make sure that an object's parent has been created
 before calling IAccessible::get_accParent, particularly if in-context hook functions are used. 

EVENT_OBJECT_DESTROY 
An object has been destroyed. The system sends this event for the following user interface elements: caret, header control,
 list view control, tab control, toolbar control, tree view control, and window object. Server applications send this event for
  their accessible objects. 
Clients assume that all of an object's children are destroyed when the parent object sends this event. 

Clients do not call an object's IAccessible properties or methods after receiving this event because the interface pointer is
 no longer valid. Servers prevent this situation by creating proxy objects that wrap accessible objects and monitor the life 
 span of those objects. 

EVENT_OBJECT_SHOW 
A hidden object is shown. The system sends this event for the following user interface elements: caret, cursor, and window
 object. Server applications send this event for their accessible objects. 
Clients assume that when this event is sent by a parent object, all child objects are already displayed. Therefore, server 
applications do not send this event for the child objects. 

Hidden objects include the STATE_SYSTEM_INVISIBLE flag; shown objects do not include this flag. 
The EVENT_OBJECT_SHOW event also indicates that the STATE_SYSTEM_INVISIBLE flag is cleared. 
Therefore, servers do not send the EVENT_STATE_CHANGE event in this case. 

EVENT_OBJECT_HIDE 
An object is hidden. The system sends this event for the following user interface elements: caret and cursor. 
Server applications send this event for their accessible objects. 
When this event is generated for a parent object, all child objects are already hidden. Server applications do not 
send this event for the child objects. 

Hidden objects include the STATE_SYSTEM_INVISIBLE flag; shown objects do not include this flag. 
The EVENT_OBJECT_HIDE event also indicates that the STATE_SYSTEM_INVISIBLE flag is set. Therefore, 
servers do not send the EVENT_STATE_CHANGE event in this case. 

This event is not sent consistently by the system. This is a known issue and is being addressed. 

EVENT_OBJECT_REORDER 
A container object has added, removed, or reordered its children. The system sends this event for the following 
user interface elements: header control, list view control, toolbar control, and window object. Server applications
 send this event as appropriate for their accessible objects. 
For example, this event is generated by a list view object when the number of child elements or the order of the 
elements changes. This event is also sent by a parent window when the z order for the child windows changes. 

EVENT_OBJECT_FOCUS 
An object has received the keyboard focus. The system sends this event for the following user interface elements: 
list view control, menu bar, pop-up menu, switch window, tab control, tree view control, and window object. Server 
applications send this event for their accessible objects. 
The hwnd parameter of the WinEventProc callback function identifies the window that receives the keyboard focus. 

EVENT_OBJECT_SELECTION 
The selection within a container object has changed. The system sends this event for the following user interface
 elements: list view control, tab control, tree view control, and window object. Server applications send this event 
 for their accessible objects. 
This event signals a single selectioneither a child is selected in a container that previously did not contain any 
selected children or the selection has changed from one child to another. 

The hwnd and idObject parameters of the WinEventProc callback function describe the container. The idChild 
parameter identifies the object that is selected. The idChild parameter is OBJID_WINDOW if the selected child 
is a window that also contains objects. 

EVENT_OBJECT_SELECTIONADD 
An item within a container object has been added to the selection. The system sends this event for the following 
user interface elements: list box, list view control, and tree view control. Server applications send this event for their 
accessible objects. 
This event signals that a child is added to an existing selection. 

The hwnd and idObject parameters of the WinEventProc callback function describe the container. The idChild parameter
 is the child added to the selection. 

EVENT_OBJECT_SELECTIONREMOVE 
An item within a container object has been removed from the selection. The system sends this event for the following user 
interface elements: list box, list view control, and tree view control. Server applications send this event for their accessible 
objects. 
This event signals that a child is removed from an existing selection. 

The hwnd and idObject parameters of the WinEventProc callback function describe the container. The idChild parameter
 identifies the child added to the selection. 

EVENT_OBJECT_SELECTIONWITHIN 
Numerous selection changes have occurred within a container object. The system sends this event for list boxes. Server 
applications send this event for their accessible objects. 
This event is sent when the selected items within a control have changed substantially. This event informs the client that
 many selection changes have occurred, and is used instead of sending several EVENT_OBJECT_SELECTIONADD or 
 EVENT_OBJECT_SELECTIONREMOVE events. The client queries for the selected items by calling the container
  object's IAccessible::get_accSelection method and enumerating the selected items. 

For this event notification, the hwnd and idObject parameters of the WinEventProc callback function describe the 
container in which the changes occurred. 

EVENT_OBJECT_STATECHANGE 
An object's state has changed. The system sends this event for the following user interface elements: check box, 
combo box, header control, push button, radio button, scroll bar, toolbar control, tree view control, up-down control,
 and window object. Server applications send this event for their accessible objects. 
For example, a state change occurs when a button object is pressed or released, or when an object is enabled or disabled. 

For this event notification, the idChild parameter of the WinEventProc callback function identifies the child object 
whose state has changed. 

This event is not sent consistently by the system. This is a known issue and is being addressed. 

EVENT_OBJECT_LOCATIONCHANGE 
An object has changed location, shape, or size. The system sends this event for the following user interface elements:
 caret and window object. Server applications send this event for their accessible objects. 
This event is generated in response to the top-level object within the object hierarchy that has changed, not for any children 
it might contain. For example, if the user resizes a window, the system sends this notification for the window, but not for the
 menu bar, title bar, scroll bars, or other objects that have also changed. 

The system does not send this event for every non-floating child window when the parent moves. However, if an application 
explicitly resizes child windows as a result of resizing, the system sends multiple events for the resized children. 

If an object's State property is set to STATE_SYSTEM_FLOATING, servers sends EVENT_OBJECT_LOCATIONCHANGE 
whenever the object changes location. If an object does not have this state, servers only trigger this event when the object
moves relative to its parent. 

For this event notification, the idChild parameter of the WinEventProc callback function identifies the child object that 
changed. 

EVENT_OBJECT_NAMECHANGE 
An object's Name property has changed. The system sends this event for the following user interface elements: check box,
 cursor, list view control, push button, radio button, status bar control, tree view control, and window object. Server
  applications send this event for their accessible objects. 
EVENT_OBJECT_DESCRIPTIONCHANGE 
An object's Description property has changed. Server applications send this event for their accessible objects. 
EVENT_OBJECT_VALUECHANGE 
An object's Value property has changed. The system sends this event for the following user interface elements: edit control,
 header control, hot key control, progress bar control, scroll bar, slider control, and up-down control. Server applications 
 send this event for their accessible objects. 
EVENT_OBJECT_PARENTCHANGE 
An object has a new parent object. Server applications send this event for their accessible objects. 
EVENT_OBJECT_HELPCHANGE 
An object's Help property has changed. Server applications send this event for their accessible objects. 
EVENT_OBJECT_DEFACTIONCHANGE 
An object's DefaultAction property has changed. The system sends this event for dialog boxes. Server applications send 
this event for their accessible objects. 
EVENT_OBJECT_ACCELERATORCHANGE 
An object's KeyboardShortcut property has changed. Server applications send this event for their accessible objects. 

