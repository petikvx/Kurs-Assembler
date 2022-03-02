@   echo    RUN EXEC__________________________________________________________
@   echo ...............................................................                                                                          
 
@  c:\masm32\bin\ml.exe /coff /c .\ISHODNIC\StartProg_winexec.asm
   
@  if EXIST StartProg_winexec.obj c:\masm32\bin\link.exe /SUBSYSTEM:WINDOWS    .\StartProg_winexec.obj 