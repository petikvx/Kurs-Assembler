   
                              null                                                           equ    0
                              NULL                                                       equ     0
                              true                                                          Equ      1
                              TRUE                                                     Equ     1
                              True                                                         Equ     1
                              false                                                        equ      0
                              FALSE                                                    equ     0
                              False                                                       equ    0
                              Null                                                          equ     0

;==============================
LOGFONT_MY   STRUC   
    lfHeight                  DWORD     0; 
    lfWidth                    DWORD      0; 
    lfEscapement      DWORD     0; 
   lfOrientation          DWORD  0  ; 
    lfWeight                 DWORD    0; 
    lfItalic                                  BYTE    0;  
    lfUnderline                        BYTE    0; 
    lfStrikeOut                          BYTE    0; 
    lfCharSet                            BYTE    0; 
    lfOutPrecision                   BYTE    0; 
    lfClipPrecision                  BYTE    0; 
    lfQuality                               BYTE    0; 
    lfPitchAndFamily                  BYTE    0; 
   lfFaceName                       BYTE                "MS Sans Serif"
                                                   BYTE              29   dup    (0); 
LOGFONT_MY   ENDS  
;==============================  

;----------------------------------------------
;'''''''''''''''''''''''''''''''''''''''''''''''''''''''''
mMOV   MACRO  M1 , M2
                        push    M2
                        pop      M1   
ENDM
;---------------------------------
msMOV   MACRO  M1 , M2
                       xor  eax , eax 
                       mov  eax ,  M2
                       mov  M1 ,  eax   
ENDM
;---------------------------------
mCMP    MACRO  M1 , M2
                        mov   EAX  ,  M2
                        cmp   M1   ,   EAX
ENDM
;---------------------------------
mADD   MACRO  M1 , M2
                  
                           mov    EAX   ,  M2
                            add    M1    ,     EAX
ENDM
;---------------------------------
mSUB   MACRO  M1 , M2
                            mov    EAX   ,   M2
                            sub     M1     ,    EAX
ENDM
;---------------------------------
mSUBeax  MACRO  M1  , M2
                    push  ECX   
                          push   M1
                          push   M2
                                  POP   ECX  
                                  POP   EAX  
                            sub      EAX   ,  ECX
                    pop    ECX           
ENDM
;---------------------------------
mADDeax  MACRO  M1  , M2
                            MOV    EAX  ,  M1
                            add      EAX   ,  M2
ENDM
;---------------------------------
mSHR   MACRO  M1   ,   M2
                 PUSH  ECX                 
                           MOV    EAX   ,   M1
                           MOV    ECX   ,   M2
                           SHR     EAX    ,   CL
                           MOV   M1  ,   EAX
                  POP    ECX          
ENDM
;---------------------------------
mSHL   MACRO  M1   ,   M2
                 PUSH  ECX                 
                           MOV    EAX   ,   M1
                           MOV    ECX   ,   M2
                           SHL      EAX    ,   CL
                           MOV   M1   ,    EAX
                 POP    ECX          
ENDM
;---------------------------------
mSHReax  MACRO  M1   ,   M2
                  PUSH  ECX
                           MOV    EAX   ,   M1
                           MOV    ECX   ,   M2
                           SHR     EAX    ,  CL
                  POP       ECX         
ENDM
;---------------------------------
mSHLeax  MACRO  M1   ,   M2
                   PUSH   ECX
                           MOV    EAX   ,   M1
                           MOV    ECX   ,   M2
                           SHL     EAX    , CL
                  POP       ECX    
ENDM
;---------------------------------
mMUL  MACRO  M1  , M2
                 push  ECX  
                              mov  ECX   ,  M2
                            xor   edx  ,  edx
                            MOV     EAX  ,  M1
                            MUL        ECX
                            mov   M1   ,   EAX
                pop    ECX            
ENDM
;---------------------------------
mDIV       MACRO  M1  , M2
                 push  ECX  
                              mov  ECX  ,  M2
                            xor   edx  ,  edx
                            MOV    EAX  ,  M1
                            DIV       ECX
                            mov   M1  ,  EAX
                pop    ECX                          
ENDM
;-----------------------------------
mMULeax   MACRO  M1  , M2
                 push  ECX  
                              mov     ECX  ,  M2
                            xor   edx  ,  edx
                            MOV     EAX  ,   M1
                            MUL       ECX
                pop    ECX                           
ENDM
;---------------------------------
mDIVeax  MACRO  M1  , M2
                 push  ECX
                              mov  ECX  ,  M2
                            xor   edx  ,  edx
                            MOV     EAX  ,  M1
                            DIV       ECX
                pop    ECX                               
ENDM
;---------------------------------

