   
                              null                                                           equ    0
                              NULL                                                       equ     0
                              true                                                          Equ      1
                              TRUE                                                     Equ     1
                              True                                                         Equ     1
                              false                                                        equ      0
                              FALSE                                                    equ     0
                              False                                                       equ    0
                              Null                                                          equ     0

;----------------------------------------------
;'''''''''''''''''''''''''''''''''''''''''''''''''''''''''
mMOV   MACRO  M1 , M2
                        push    M2
                        pop      M1   
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

