#include "cdecl.h"

int PRE_CDECL _asm_main( void ) POST_CDECL;

int main()
{
  int ret_status;
  ret_status = _asm_main();
  return ret_status;
}
