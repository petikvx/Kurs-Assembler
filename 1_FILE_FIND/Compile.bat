@   echo  ___________FIND_________________________________________

@   c:\masm32\bin\ml.exe   /coff /c   .\ISHODNIC\Find.asm

@  if EXIST Find.obj c:\masm32\bin\link.exe /SUBSYSTEM:WINDOWS  .\Find.obj