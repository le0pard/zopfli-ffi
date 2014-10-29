#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "zopfli/zopfli.h"

#if defined(__cplusplus) || defined(c_plusplus)
extern "C" {
#endif

  typedef struct {
    int type;           // type
    int numiterations;  // number of iterations
  } ZopfliConfig;


  int zopfli_convert(const char *in_file, const char *out_file, const ZopfliConfig *zopfli_config);
  int test_c(int n);

#if defined(__cplusplus) || defined(c_plusplus)
}    // extern "C"
#endif