@   echo  ___________FIND_ATTRIBUTES_________________________________________

@   c:\masm32\bin\ml.exe   /coff /c   .\ISHODNIC\Find.asm
@   c:\masm32\bin\ml.exe   /coff /c   .\ISHODNIC\Attributes.asm


@  if EXIST Find.obj if EXIST Attributes.obj c:\masm32\bin\link.exe /SUBSYSTEM:WINDOWS /OUT:FIND_ATTRIBUTES.exe  .\Find.obj .\Attributes.obj