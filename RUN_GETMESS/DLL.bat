@ echo _____DLL_____
@ c:\masm32\bin\ml.exe /c /coff /DMASM   .\ISHODNIC\myDLLhook.asm 
@   if EXIST myDLLhook.obj c:\masm32\bin\link.exe /subsystem:windows /DLL /section:.data,SRW  /OUT:hookMES.dll    .\myDLLhook.obj  
   