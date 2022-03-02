@   echo    RUN PROCESS__________________________________________________________
@   echo ...............................................................                                                                          
 
@  c:\masm32\bin\ml.exe /coff /c .\ISHODNIC\StartProg_process.asm
   
@  if EXIST StartProg_process.obj c:\masm32\bin\link.exe /SUBSYSTEM:WINDOWS    .\StartProg_process.obj 