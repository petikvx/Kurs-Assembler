#include "Driver.h"

 ;// -----


 ULONG                 FUKAN = 10 ;
  SEH     seh_my        ;
KSPIN_LOCK   MySpinLock;

#pragma code_seg("INIT") 
extern "C"
// ----------------------------------------------------  ENTRY     PROC                                                                                                
NTSTATUS DriverEntry( IN PDRIVER_OBJECT DriverObject, 
					  IN PUNICODE_STRING RegistryPath ) 
{


	NTSTATUS                                                                 STATUS , status;
	OBJECT_HANDLE_INFORMATION             add_Info;
	PDEVICE_OBJECT                                                 FDO	;
	UNICODE_STRING                                             devName;	  
	UNICODE_STRING                                              symLinkName;    
;// """""""""""""""""""""""                   END DATA          

  
                                             #if DBG      
                                                               DbgPrint("=Example=   START FINISH    OK  ."   );
                                             #endif        
;//  _FINISH_:    
  return      STATUS;
}
#pragma code_seg()
 // --------------------------------------------------   CompleteIrp   PROC  ------------------------------------------------------------------
NTSTATUS CompleteIrp(PIRP   Irp   ,    NTSTATUS     status , ULONG info )
{
            Irp->IoStatus.Status = status;
            Irp->IoStatus.Information = info;
            IoCompleteRequest(Irp , IO_NO_INCREMENT );
            return        status  ;
}
 // ----------------------------------------------------------------------------------   Shutdown   PROC 
