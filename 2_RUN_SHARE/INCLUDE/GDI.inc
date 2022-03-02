
extern BeginPaint@8:near
extern EndPaint@8:near   ;---------
extern GetDC@4:near
extern GetWindowDC@4:near
extern ReleaseDC@8:near  ;---------
extern CreateDCA@16:near
extern CreateICA@16:near
extern CreateCompatibleDC@4:near
extern DeleteDC@4:near   ;---------
extern CreateMetaFileA@4:near
extern CloseMetaFile@4:near

extern InvalidateRect@12:near 
extern InvalidateRgn@12:near
extern GetUpdateRect@12:near
extern GetUpdateRgn@12:near
extern UpdateWindow@4:near
extern ValidateRect@8:near
extern ValidateRgn@8:near
extern LockWindowUpdate@4:near
extern RedrawWindow@16:near



extern RestoreDC@8:near
extern SaveDC@4:near
extern SelectObject@8:near

extern LoadCursorA@8:near
extern LoadBitmapA@8:near
extern LoadIconA@8:near
extern DeleteObject@4:near
extern CreatePatternBrush@4:near
extern GetStockObject@4:near
extern CreateSolidBrush@4:near
extern CreatePen@12:near

extern RoundRect@28:near
extern GetClientRect@8:near
extern Ellipse@20:near
extern GetCurrentPositionEx@8:near;текущее положение пера

extern GetDeviceCaps@8:near

extern DestroyIcon@4:near
extern ExtractIconA@12:near
extern ExtractIconExA@20:near
extern ExtractAssociatedIconA@12:near
extern SHGetFileInfoA@20:near
extern LoadAlterBitmap@12:near

extern FindResourceA@12:near
extern LoadResource@8:near
extern LockResource@4:near

extern FreeResource@4:near
extern LoadMenuA@8:near
extern SetMenu@8:near

extern SetDIBitsToDevice@48:near
extern CreateDIBitmap@24:near
extern StretchDIBits@52:near
extern BitBlt@36:near
extern PatBlt@24:near
extern StretchBlt@44:near
extern SetDIBits@28:near
extern GetDIBits@28:near

extern CreateBitmap@20:near
extern CreateBitmapIndirect@4:near 
extern CreateCompatibleBitmap@12:near
extern CreateDiscardableBitmap@12:near
extern GetBitmapBits@12:near
extern SetBitmapBits@12:near
extern GetObjectA@12:near
extern DeleteObject@4:near

extern CopyIcon@4:near
extern DrawIcon@16:near
extern FillRect@12:near


;----------------------
;/* Pen Styles */
 PS_SOLID         equ   0
 PS_DASH           equ  1       /* -------  */
 PS_DOT           equ  2       /* .......  */
 PS_DASHDOT        equ   3       /* _._._._  */
 PS_DASHDOTDOT      equ 4       /* _.._.._  */
 PS_NULL           equ  5
 PS_INSIDEFRAME     equ  6
 
 
 WHITE_BRUSH                          equ 0
LTGRAY_BRUSH                         equ 1
GRAY_BRUSH                           equ 2
DKGRAY_BRUSH                         equ 3
BLACK_BRUSH                          equ 4
NULL_BRUSH                           equ 5
HOLLOW_BRUSH                         equ NULL_BRUSH
WHITE_PEN                            equ 6
BLACK_PEN                            equ 7
NULL_PEN                             equ 8

 
 WM_GETICON     equ   07Fh
 ICON_SMALL     equ     0
 ICON_BIG       equ     1
 ;-----------------------
POINT STRUC
  x  DWORD ?
  y  DWORD ?
POINT ENDS
;-
POINTS STRUC
  x WORD ?
  y WORD ?
POINTS ENDS
;-
RECT STRUC
  left    dd      ?
  top     dd      ?
  right   dd      ?
  bottom  dd      ?
RECT ENDS
;-
PAINTSTRUCT STRUC
  hdc           DWORD      ?
  fErase        DWORD      ?
  rcPaint       RECT       <>
  fRestore      DWORD      ?
  fIncUpdate    DWORD      ?
  rgbReserved   BYTE 32 dup(?)
PAINTSTRUCT ENDS
;-
 SHFILEINFO struc
  ;------
                    hIcon_SH dd ?;     // out: icon
                    iIcon dd ?;       // out: icon index
             dwAttributes dd ?;        // out: SFGAO_ flags
            szDisplayName db 260 dup(?);// out: display name (or path)
            szTypeName    db 80 dup (?);// out: type name
 SHFILEINFO ends
 
 
 SHGFI_ICON           equ   00000100h;     // get icon
 SHGFI_DISPLAYNAME    equ   00000200h;     // get display name
 SHGFI_TYPENAME       equ   00000400h;     // get type name
 SHGFI_ATTRIBUTES     equ   00000800h;     // get attributes
 SHGFI_ICONLOCATION   equ   00001000h;     // get icon location
 SHGFI_EXETYPE        equ   00002000h;     // return exe type
 SHGFI_SYSICONINDEX   equ   00004000h;     // get system icon index
 SHGFI_LINKOVERLAY    equ   00008000h;     // put a link overlay on icon
 SHGFI_SELECTED       equ   00010000h;     // show icon in selected state
 SHGFI_ATTR_SPECIFIED  equ  00020000h;     // get only specified attributes
 SHGFI_LARGEICON       equ  00000000h;     // get large icon
 SHGFI_SMALLICON       equ  00000001h;     // get small icon
 SHGFI_OPENICON        equ  00000002h;     // get open icon
 SHGFI_SHELLICONSIZE   equ  00000004h;     // get shell size icon
 SHGFI_PIDL             equ 00000008h;     // pszPath is a pidl
 SHGFI_USEFILEATTRIBUTES equ 00000010h;     // use passed dwFileAttribute
 
 example_icon equ SHGFI_SMALLICON +SHGFI_ICON+SHGFI_OPENICON;
 
 LR_DEFAULTCOLOR 			equ 0
LR_MONOCHROME 			equ 1
LR_COLOR 				equ 2
LR_COPYRETURNORG 			equ 4
LR_COPYDELETEORG 			equ 8
LR_LOADFROMFILE 			equ 10h
LR_LOADTRANSPARENT 		equ 20h
LR_DEFAULTSIZE 			equ 40h
LR_VGACOLOR 			equ 80h
LR_LOADMAP3DCOLORS 		equ 1000h
LR_CREATEDIBSECTION 		equ 2000h
LR_COPYFROMRESOURCE 		equ 4000h
LR_SHARED 				equ 8000h
	 
;------------------------------------------------------------------------- 
;STRUCT DIB
BITMAPFILEHEADER STRUC 
 bfType             WORD   ? ;	Байты"BM" для битовых образов
 bfSize   	DWORD  ? ;	Общий размер файла
 bfReserved1	WORD   0 ; 	Установлено в 0
 bfReserved2	WORD   0 ;         Установлено в 0
 bfOffBits	DWORD  ? ;	Смещение битов битового образа от начала файла
BITMAPFILEHEADER ENDS
 
BITMAPINFOHEADER STRUC
 biSize   	DWORD ?;	Размер структуры в байтах
 biWidth  	DWORD  ?; 	Ширина битового образа в пикселях
 biHeight	          DWORD  ?; 	Высота битового образа в пикселях
 biPlanes	          WORD  1;	Установлено в 1
 biBitCount	WORD  ?;	Число битов цвета на пиксель (1, 4, 8, 24)
 biCompression	DWORD ?;	Схема компрессии (если нет - 0)
 biSizeImage	DWORD ? ;	Размер битов битового образа в байтах (нужен только при компрессии)
 biXPelsPerMeter	DWORD  ?;	Разрешение в пикселях на метр  по горизонтали
 biYPelsPerMeter	DWORD  ?;	Разрешение в пикселях на метр  по вертикали
 biClrUsed	DWORD ?; 	Число цветов, используемых  в изображении
 biClrImportant	DWORD ?;	Число важных цветов в изображении

BITMAPINFOHEADER ENDS

RGBQUAD  STRUC
   rgbBlue	BYTE ?;	Интенсивность голубого
   rgbGreen	BYTE ?; 	Интенсивность зеленого
   rgbRed 	BYTE ?;	Интенсивность красного
rgbReserved	BYTE 0;	Равно 0

RGBQUAD  ENDS
;--------------------------------------------------------------------------
BITMAP STRUC 

bmType    	DWORD  0;	Установлено в 0
bmWidth   	DWORD  ?;	Ширина битового образа в пикселях
bmHeight  	DWORD  ?;	Высота битового образа в пикселях


bmWidthBytes        DWORD  ?;	Ширина битового образа в байтах (min четным)

bmPlanes  	WORD  ?; 	Число цветовых плоскостей
bmBitsPixel	WORD  ?;	Число битов цвета на пиксель
bmBits	          DWORD ?; 	Указатель на массив битов
BITMAP ENDS
;----------------------------------------------------------------------------------------
SRCCOPY                              equ 0CC0020h
SRCPAINT                             equ 0EE0086h
SRCAND                               equ 8800C6h
SRCINVERT                            equ 660046h
SRCERASE                             equ 440328h
NOTSRCCOPY                           equ 330008h
NOTSRCERASE                          equ 1100A6h
MERGECOPY                            equ 0C000CAh
MERGEPAINT                           equ 0BB0226h
PATCOPY                              equ 0F00021h
PATPAINT                             equ 0FB0A09h
PATINVERT                            equ 5A0049h
DSTINVERT                            equ 550009h

;---------------
DIB_RGB_COLORS                       equ 0
DIB_PAL_COLORS                       equ 1
DIB_PAL_INDICES                      equ 2
DIB_PAL_PHYSINDICES                  equ 2
DIB_PAL_LOGINDICES                   equ 4 
