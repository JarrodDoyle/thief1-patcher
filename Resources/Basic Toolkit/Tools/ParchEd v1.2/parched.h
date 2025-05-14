
#include "resources.h"

extern HBITMAP LoadImageFile(LPCTSTR filename, unsigned long *width, unsigned long *height, COLORREF *colors);
extern char** LoadStrFile(LPCTSTR filename, int *num_pages);
extern int SaveStrFile(LPCTSTR filename, char **pages, int num_pages);

extern void ErrorDialog(DWORD id, DWORD code, const char* file, unsigned int line);

