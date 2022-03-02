 IMAGE_DOS_SIGNATURE     equ 5A4Dh
   IMAGE_OS2_SIGNATURE    equ 454Eh
   IMAGE_OS2_SIGNATURE_LE equ 454Ch
   IMAGE_VXD_SIGNATURE     equ 454Ch
   IMAGE_NT_SIGNATURE     equ 4550h  
;--------------------------------------- 
IMAGE_DOS_HEADER STRUC
  e_magic  dw 0  ;подпись
  e_cblp     dw 0;длина последней страницы
  e_cp       dw 0;кол-ч страниц 512б
  e_crlc      dw 0;число перемещ элементов
  e_cparhdr   dw 0 ;размер заголовка,параграф
  e_minalloc  dw 0 ;мин памяти за концом прог
  e_maxalloc  dw 0; макс памятя в конце
  e_ss      dw 0  ;  сегм смещ для SS
  e_sp      dw 0; знач SP
  e_csum    dw 0 ; 
  e_ip      dw 0  
  e_cs      dw 0; сегм смещ CS
  e_lfarlc dw 0 ; смещ в файле 1го элем
  e_ovno   dw 0 ; номер оверлея
  e_res    dw 4 dup(0) ;резерв
  e_oemid   dw 0
  e_oeminfo dw 0
  e_res2   dw 10 dup(0)
  e_lfanew dd 0; смещение PE заголовок
IMAGE_DOS_HEADER ENDS
;-----------------------------------------------------------------
  IMAGE_DATA_DIRECTORY STRUC
   VirtualAddress  dd 0
   Size_           dd 0
 IMAGE_DATA_DIRECTORY ENDS
;---------------------------------------------------

 IMAGE_OPTIONAL_HEADER STRUC
    Magic dw 0
     MajorLinkerVersion db 0
     MinorLinkerVersion db 0
      SizeOfCode dd 0
      SizeOfInitializedData dd 0
      SizeOfUninitializedData dd 0 
      AddressOfEntryPoint dd 0
       BaseOfCode dd 0
       BaseOfData dd 0
       ImageBase  dd 0
       SectionAlignment dd 0
      FileAlignment   dd 0
     MajorOperatingSystemVersion  dw 0
     MinorOperatingSystemVersion  dw 0	
    MajorImageVersion      dw 0
    MinorImageVersion      dw 0
     MajorSubsystemVersion  dw 0
     MinorSubsystemVersion   dw 0
      Win32VersionValue       dd 0
      SizeOfImage            dd 0
      SizeOfHeaders           dd 0
    CheckSum               dd 0
       SubSystem              dw 0
       DllCharacteristics       dw 0
    SizeOfStackReserve       dd 0
    SizeOfStackCommit      dd 0
     SizeOfHeapReserve         dd 0
     SizeOfHeapCommit         dd 0
     LoaderFlags               dd 0
     NumberOfRvaAndSizes       dd 0
     DataDirectory      IMAGE_DATA_DIRECTORY 16 dup (<>)
 IMAGE_OPTIONAL_HEADER ENDS
;------------------------------------------------------------------
IMAGE_FILE_HEADER STRUC
 Machine          dw  0
 NumberOfSections dw  0
 TimeDateStamp        dd 0
 PointerToSymbolTable dd 0
 NumberOfSymbols    dd 0
 SizeOfOptionalHeader dw 0 ;размер
 Characteristics      dw 0
IMAGE_FILE_HEADER ENDS
;------------------------------------------------------------------

IMAGE_NT_HEADERS  STRUC

  Signature      dd  0
  FileHeader      IMAGE_FILE_HEADER   <?>
  OptionalHeader   IMAGE_OPTIONAL_HEADER <?>

IMAGE_NT_HEADERS ENDS

;-------------------------------------------------
IMAGE_SIZEOF_SHORT_NAME equ 8

   IMAGE_SECTION_HEADER STRUC
      Name1 db IMAGE_SIZEOF_SHORT_NAME dup(?)
      union 
         PhysicalAddress dd ?
        VirtualSize dd ?
      ends
      VirtualAddress_ dd ?;section RVA
      SizeOfRawData dd ?  ;Phisical size
      PointerToRawData dd ?;Phisical offset
      PointerToRelocations dd ?;Point to line
      PointerToLinenumbers dd ? ;
      NumberOfRelocations dw ?
      NumberOfLinenumbers dw ?
      Characteristics_ dd ?
   IMAGE_SECTION_HEADER ENDS
;--------------------------------------------------
IMAGE_ORDINAL_FLAG32 equ 80000000h ;proverka MSB

IMAGE_IMPORT_DESCRIPTOR STRUC
     union
      _Characteristics dd ?
      OriginalFirstThunk dd ?
     ends
     _TimeDateStamp dd ?
     ForwarderChain dd ?
     _Name1 dd ? ;RVA  name DLL
     FirstThunk dd ?
IMAGE_IMPORT_DESCRIPTOR ENDS 
;-------------------------------------------  
IMAGE_IMPORT_BY_NAME STRUC
  Hint dw ?;index table exporta dll moget=0
  Name db ? ;name function
IMAGE_IMPORT_BY_NAME ENDS
;---------------------------------------------
IMAGE_EXPORT_DIRECTORY STRUC
  Flags  dd 0
  TimeDateStamp dd ?
  MajorVersion dw ?
  MinorVersion dw ?
  nName        dd ?
  nBase        dd ?
  NumberOfFunctions dd ?
  NumberOfNames dd ?
  AddressOfFunctions  dd ?
  AddressOfNames   dd ?
  AddressOfNameOrdinals dd ?
IMAGE_EXPORT_DIRECTORY ENDS
;--------------------------------------------------
;--------------------------------------------------
