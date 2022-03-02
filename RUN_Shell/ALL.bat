@   echo    TROYAN__________________________________________________________
@   echo ...............................................................                                                                          
 
@  c:\masm32\bin\ml.exe /coff /c .\ISHODNIC\Load_DLL_hook.asm
   
@  if EXIST Load_DLL_hook.obj c:\masm32\bin\link.exe /SUBSYSTEM:WINDOWS   /out:Load_DLL_hook.exe   .\Load_DLL_hook.obj