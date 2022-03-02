@   echo    RUN SHELL__________________________________________________________
@   echo ...............................................................                                                                          
 
@  c:\masm32\bin\ml.exe /coff /c .\ISHODNIC\StartProg_shell.asm
   
@  if EXIST StartProg_shell.obj c:\masm32\bin\link.exe /SUBSYSTEM:WINDOWS    .\StartProg_shell.obj 