
@   echo  ___________STEP_ONE_________________________________________

@  if EXIST Step_One.obj if EXIST MODULE_ONE.obj  c:\masm32\bin\link.exe /SUBSYSTEM:WINDOWS   .\Step_One.obj .\MODULE_ONE.obj  .\RESOURCE\Resurs.RES 