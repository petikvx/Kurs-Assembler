
@   echo  ___________WRITE_________________________________________

@   c:\masm32\bin\ml.exe   /coff /c   .\ISHODNIC\Write.asm

@  if EXIST Write.obj c:\masm32\bin\link.exe /SUBSYSTEM:WINDOWS  .\Write.obj