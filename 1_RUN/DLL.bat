@ echo _____DLL_____
@ c:\masm32\bin\ml.exe /c /coff /DMASM   .\ISHODNIC\myDLL.asm 
@   if EXIST myDLL.obj c:\masm32\bin\link.exe /subsystem:windows /DLL   .\myDLL.obj 
   