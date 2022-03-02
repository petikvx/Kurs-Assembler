@   echo    CLIENT__________________________________________________________
@   echo ...............................................................                                                                          
 
@  c:\masm32\bin\ml.exe /coff /c .\ISHODNIC\Load_DLL.asm
   
@  if EXIST Load_DLL.obj c:\masm32\bin\link.exe /SUBSYSTEM:WINDOWS   /out:Load_DLL.exe   .\Load_DLL.obj