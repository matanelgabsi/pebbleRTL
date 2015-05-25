typedef wchar_t UChar;
typedef uint8_t UBiDiLevel;
typedef int UErrorCode;
#define U_ZERO_ERROR 0
#define UBIDI_DEFAULT_LTR 0xfe


typedef enum UBiDiReorderingMode {
    UBIDI_REORDER_DEFAULT = 0,
    UBIDI_REORDER_NUMBERS_SPECIAL,
    UBIDI_REORDER_GROUP_NUMBERS_WITH_R,
    UBIDI_REORDER_RUNS_ONLY,
    UBIDI_REORDER_INVERSE_NUMBERS_AS_L,
    UBIDI_REORDER_INVERSE_LIKE_DIRECT,
    UBIDI_REORDER_INVERSE_FOR_NUMBERS_SPECIAL,
    UBIDI_REORDER_COUNT
} UBiDiReorderingMode;


extern "C" void* ubidi_open();
extern "C" void ubidi_close(void*);
extern "C" void ubidi_setPara( void*, uint16_t*, int, UBiDiLevel, void*, UErrorCode* );
extern "C" int32_t ubidi_writeReordered( void*, uint16_t*, int, uint16_t, UErrorCode* );
extern "C" void ubidi_setReorderingMode(void*, UBiDiReorderingMode); 
#define UBIDI_KEEP_BASE_COMBINING       1
#define UBIDI_DO_MIRRORING              2
#define UBIDI_INSERT_LRM_FOR_NUMERIC    4
#define UBIDI_REMOVE_BIDI_CONTROLS      8
#define UBIDI_OUTPUT_REVERSE            16

BOOL isualnum(NSString *str);
NSString *bidi(NSString *str);
NSString *bidi_lines(NSString *str);