#include "./zopfli_ffi.h"

#define DEFAULT_FORMAT ZOPFLI_FORMAT_ZLIB

#if defined(__cplusplus) || defined(c_plusplus)
extern "C" {
#endif

/*
Loads a file into a memory array.
*/
static void LoadFile(const char* filename,
                     unsigned char** out, size_t* outsize) {
  FILE* file;

  *out = 0;
  *outsize = 0;
  file = fopen(filename, "rb");
  if (!file) return;

  fseek(file , 0 , SEEK_END);
  *outsize = ftell(file);
  rewind(file);

  *out = (unsigned char*)malloc(*outsize);

  if (*outsize && (*out)) {
    size_t testsize = fread(*out, 1, *outsize, file);
    if (testsize != *outsize) {
      /* It could be a directory */
      free(*out);
      *out = 0;
      *outsize = 0;
    }
  }

  assert(!(*outsize) || out);  /* If size is not zero, out must be allocated. */
  fclose(file);
}

/*
Saves a file from a memory array, overwriting the file if it existed.
*/
static void SaveFile(const char* filename,
                     const unsigned char* in, size_t insize) {
  FILE* file = fopen(filename, "wb" );
  assert(file);
  fwrite((char*)in, 1, insize, file);
  fclose(file);
}

/*
outfilename: filename to write output to, or 0 to write to stdout instead
*/
static void CompressFile(const ZopfliOptions* options,
                         ZopfliFormat output_type,
                         const char* infilename,
                         const char* outfilename) {
  unsigned char* in;
  size_t insize;
  unsigned char* out = 0;
  size_t outsize = 0;
  LoadFile(infilename, &in, &insize);
  if (insize == 0) {
    fprintf(stderr, "Invalid filename: %s\n", infilename);
    return;
  }

  ZopfliCompress(options, output_type, in, insize, &out, &outsize);

  if (outfilename) {
    SaveFile(outfilename, out, outsize);
  } else {
    size_t i;
    for (i = 0; i < outsize; i++) {
      /* Works only if terminal does not convert newlines. */
      printf("%c", out[i]);
    }
  }

  free(out);
  free(in);
}

int zopfli_convert(const char *in_file, const char *out_file, const ZopfliConfig *zopfli_config) {
  ZopfliOptions options;
  ZopfliFormat output_type = ZOPFLI_FORMAT_GZIP;

  ZopfliInitOptions(&options);

  if (zopfli_config->type == 1) {
    output_type = ZOPFLI_FORMAT_DEFLATE;
  } else if (zopfli_config->type == 2) {
    output_type = ZOPFLI_FORMAT_GZIP;
  } else {
    output_type = DEFAULT_FORMAT;
  }

  if (zopfli_config->numiterations > 0) {
    options.numiterations = zopfli_config->numiterations;
  }

  CompressFile(&options, output_type, in_file, out_file);

  return 0;
}

// test
int test_c(int n) {
  return n + 100;
}


#if defined(__cplusplus) || defined(c_plusplus)
}    // extern "C"
#endif