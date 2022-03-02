@   echo  ___________FIND_NEXT_________________________________________

@   c:\masm32\bin\ml.exe   /coff /c   .\ISHODNIC\Find.asm

@  if EXIST Find.obj c:\masm32\bin\link.exe /SUBSYSTEM:WINDOWS /OUT:FIND_NEXT.exe  .\Find.obj