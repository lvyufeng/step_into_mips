/*
 * The MIT License (MIT)
 *
 * Copyright (c) 2015 G. Elian Gidoni
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

#include <stdio.h>
#include <common.h>

/*
 * Private functions.
 */

static int
is_space(char c)
{
        return (c == ' ' || c == '\t' || c == '\v' ||
                c == '\f' || c == '\r' || c == '\n');
}

static char*
skip_spaces(const char *str)
{
        while (is_space(*str)){
                ++str;
        }
        return (char*)str;
}

/* Returns a pointer after the last read char, or 'str' on error. */
static char*
dec_to_signed(const char *str, long *out)
{
        const char * cur = skip_spaces(str);
        long value = 0;
        int isneg = 0, isempty = 1;
        if (cur[0] == '+'){
                cur += 1;
        }else if(cur[0] == '-'){
                cur += 1;
                isneg = 1;
        }
        while (*cur != '\0' && *cur >= '0' && *cur <= '9'){
                value = (value * 10) + (*cur - '0');
                isempty = 0;
                ++cur;
        }
        if (isempty){
                return (char*)str;
        }
        if (isneg){
                *out = -value;
        }else{
                *out = value;
        }
        return (char*)cur;
}

/* Returns a pointer after the last read char, or 'str' on error. */
static char*
dec_to_unsigned(const char *str, unsigned long *out)
{
        const char * cur = skip_spaces(str);
        unsigned long value = 0;
        int isempty = 1;
        while (*cur != '\0' && *cur >= '0' && *cur <= '9'){
                value = (value * 10) + (*cur - '0');
                isempty = 0;
                ++cur;
        }
        if (isempty){
                return (char*)str;
        }
        *out = value;
        return (char*)cur;
}

/* Returns a pointer after the last read char, or 'str' on error. */
static char*
hex_to_signed(const char *str, long *out)
{
        const char * cur = skip_spaces(str);
        long value = 0;
        int isneg = 0, isempty = 1;
        if (cur[0] == '+'){
                cur += 1;
        }else if(cur[0] == '-'){
                cur += 1;
                isneg = 1;
        }
        if (cur[0] == '0' && cur[1] == 'x'){
                cur += 2;
        }
        while (*cur != '\0'){
                if(*cur >= '0' && *cur <= '9'){
                        value = (value * 16) + (*cur - '0');
                }else if (*cur >= 'a' && *cur <= 'f'){
                        value = (value * 16) + 10 + (*cur - 'a');
                }else if (*cur >= 'A' && *cur <= 'F'){
                        value = (value * 16) + 10 + (*cur - 'A');
                }else{
                        break;
                }
                isempty = 0;
                ++cur;
        }
        if (isempty){
                return (char*)str;
        }
        if (isneg){
                *out = -value;
        }else{
                *out = value;
        }
        return (char*)cur;
}

/* Returns a pointer after the last read char, or 'str' on error. */
static char*
hex_to_unsigned(const char *str, unsigned long *out)
{
        const char * cur = skip_spaces(str);
        unsigned long value = 0;
        int isempty = 1;
        if (cur[0] == '0' && cur[1] == 'x'){
                cur += 2;
        }
        while (*cur != '\0'){
                if(*cur >= '0' && *cur <= '9'){
                        value = (value * 16) + (*cur - '0');
                }else if (*cur >= 'a' && *cur <= 'f'){
                        value = (value * 16) + 10 + (*cur - 'a');
                }else if (*cur >= 'A' && *cur <= 'F'){
                        value = (value * 16) + 10 + (*cur - 'A');
                }else{
                        break;
                }
                isempty = 0;
                ++cur;
        }
        if (isempty){
                return (char*)str;
        }
        *out = value;
        return (char*)cur;
}

#define MFMT_DEC_TO_SIGNED(TYPE, NAME)                          \
static char*                                                    \
dec_to_##NAME(const char *str, TYPE *out)                       \
{                                                               \
        long v;                                                 \
        char *cur = dec_to_signed(str, &v);                     \
        if (cur != str){                                        \
                *out = (TYPE)v;                                 \
        }                                                       \
        return cur;                                             \
}

#define MFMT_DEC_TO_UNSIGNED(TYPE, NAME)                        \
static char*                                                    \
dec_to_##NAME(const char *str, TYPE *out)                       \
{                                                               \
        unsigned long v;                                        \
        char *cur = dec_to_unsigned(str, &v);                   \
        if (cur != str){                                        \
                *out = (TYPE)v;                                 \
        }                                                       \
        return cur;                                             \
}

#define MFMT_HEX_TO_SIGNED(TYPE, NAME)                                  \
static char*                                                            \
hex_to_##NAME(const char *str, TYPE *out)                               \
{                                                                       \
        long v;                                                         \
        char *cur = hex_to_signed(str, &v);                             \
        if (cur != str){                                                \
                *out = (TYPE)v;                                         \
        }                                                               \
        return cur;                                                     \
}

#define MFMT_HEX_TO_UNSIGNED(TYPE, NAME)                        \
static char*                                                    \
hex_to_##NAME(const char *str, TYPE *out)                       \
{                                                               \
        unsigned long v;                                        \
        char *cur = hex_to_unsigned(str, &v);                   \
        if (cur != str){                                        \
                *out = (TYPE)v;                                 \
        }                                                       \
        return cur;                                             \
}

/* Returns a pointer after the last written char, or 'str' on error. */
#define MFMT_SIGNED_TO_HEX(TYPE, NAME)                                  \
static char*                                                            \
NAME##_to_hex(TYPE val, int uppercase, char padchar, size_t padlen,     \
              size_t len, char *str)                                    \
{                                                                       \
        char buf[24];                                                   \
        size_t isneg = 0, cnt = 0;                                      \
        if (uppercase){                                                 \
                uppercase = 'A';                                        \
        }else{                                                          \
                uppercase = 'a';                                        \
        }                                                               \
        if (val < 0){                                                   \
                isneg = 1;                                              \
                val = -val;                                             \
        }                                                               \
        do{                                                             \
                buf[cnt++] = val % 16;                                  \
                val = val / 16;                                         \
        }while (val != 0);                                              \
        if (padlen > isneg + cnt){                                      \
                padlen -= isneg + cnt;                                  \
                padlen = (padlen < len ? padlen : len);                 \
                memset(str, padchar, padlen);                           \
                str += padlen;                                          \
                len -= padlen;                                          \
        }                                                               \
        if (isneg && len > 0){                                          \
                str[0] = '-';                                           \
                str += 1;                                               \
                len -= 1;                                               \
        }                                                               \
        while (cnt-- > 0 && len-- > 0){                                 \
                if (buf[cnt] < 10){                                     \
                        *str = buf[cnt] + '0';                          \
                }else{                                                  \
                        *str = (buf[cnt] - 10) + uppercase;             \
                }                                                       \
                ++str;                                                  \
        }                                                               \
        return str;                                                     \
}

/* Returns a pointer after the last written char, or 'str' on error. */
#define MFMT_SIGNED_TO_DEC(TYPE, NAME)                                  \
static char*                                                            \
NAME##_to_dec(TYPE val, char padchar, size_t padlen,                    \
              size_t len, char *str)                                    \
{                                                                       \
        char buf[24];                                                   \
        size_t isneg = 0, cnt = 0;                                      \
        if (val < 0){                                                   \
                isneg = 1;                                              \
                val = -val;                                             \
        }                                                               \
        do{                                                             \
                buf[cnt++] = val % 10;                                  \
                val = val / 10;                                         \
        }while (val != 0);                                              \
        if (padlen > isneg + cnt){                                      \
                padlen -= isneg + cnt;                                  \
                padlen = (padlen < len ? padlen : len);                 \
                memset(str, padchar, padlen);                           \
                str += padlen;                                          \
                len -= padlen;                                          \
        }                                                               \
        if (isneg && len > 0){                                          \
                str[0] = '-';                                           \
                str += 1;                                               \
                len -= 1;                                               \
        }                                                               \
        while (cnt-- > 0 && len-- > 0){                                 \
                *str = buf[cnt] + '0';                                  \
                ++str;                                                  \
        }                                                               \
        return str;                                                     \
}

/* Returns a pointer after the last written char, or 'str' on error. */
#define MFMT_UNSIGNED_TO_HEX(TYPE, NAME)                                \
static char*                                                            \
NAME##_to_hex(TYPE val, int uppercase, char padchar, size_t padlen,     \
              size_t len, char *str)                                    \
{                                                                       \
        char buf[24];                                                   \
        size_t cnt = 0;                                                 \
        if (uppercase){                                                 \
                uppercase = 'A';                                        \
        }else{                                                          \
                uppercase = 'a';                                        \
        }                                                               \
        do{                                                             \
                buf[cnt++] = val % 16;                                  \
                val = val / 16;                                         \
        }while (val != 0);                                              \
        if (padlen > cnt){                                              \
                padlen -= cnt;                                          \
                padlen = (padlen < len ? padlen : len);                 \
                memset(str, padchar, padlen);                           \
                str += padlen;                                          \
                len -= padlen;                                          \
        }                                                               \
        while (cnt-- > 0 && len-- > 0){                                 \
                if (buf[cnt] < 10){                                     \
                        *str = buf[cnt] + '0';                          \
                }else{                                                  \
                        *str = (buf[cnt] - 10) + uppercase;             \
                }                                                       \
                ++str;                                                  \
        }                                                               \
        return str;                                                     \
}

/* Returns a pointer after the last written char, or 'str' on error. */
#define MFMT_UNSIGNED_TO_DEC(TYPE, NAME)                                \
static char*                                                            \
NAME##_to_dec(TYPE val, char padchar, size_t padlen,                    \
              size_t len, char *str)                                    \
{                                                                       \
        char buf[24];                                                   \
        size_t cnt = 0;                                                 \
        do{                                                             \
                buf[cnt++] = val % 10;                                  \
                val = val / 10;                                         \
        }while (val != 0);                                              \
        if (padlen > cnt){                                              \
                padlen -= cnt;                                          \
                padlen = (padlen < len ? padlen : len);                 \
                memset(str, padchar, padlen);                           \
                str += padlen;                                          \
                len -= padlen;                                          \
        }                                                               \
        while (cnt-- > 0 && len-- > 0){                                 \
                *str = buf[cnt] + '0';                                  \
                ++str;                                                  \
        }                                                               \
        return str;                                                     \
}

MFMT_DEC_TO_SIGNED(int, int)
MFMT_HEX_TO_SIGNED(int, int)
MFMT_SIGNED_TO_DEC(int, int)
MFMT_SIGNED_TO_HEX(int, int)

MFMT_DEC_TO_UNSIGNED(unsigned int, uint)
MFMT_HEX_TO_UNSIGNED(unsigned int, uint)
MFMT_UNSIGNED_TO_DEC(unsigned int, uint)
MFMT_UNSIGNED_TO_HEX(unsigned int, uint)
MFMT_UNSIGNED_TO_HEX(size_t, siz)

static const char*
parse_arg(const char *fmt, const char *str, va_list args)
{
        int *intp, intv = 0;
        unsigned int *uintp, uintv = 0, width = 0;
        char *charp;
        const char *cur = str;
        fmt = dec_to_uint(fmt, &width);
        if (*fmt == 'd'){
                cur = dec_to_int(str, &intv);
                if (cur != str){
                        intp = va_arg(args, int*);
                        *intp = intv;
                }
        }else if (*fmt == 'u'){
                cur = dec_to_uint(str, &uintv);
                if (cur != str){
                        uintp = va_arg(args, unsigned int*);
                        *uintp = uintv;
                }
        }else if (*fmt == 'x' || *fmt == 'X'){
                cur = hex_to_uint(str, &uintv);
                if (cur != str){
                        uintp = va_arg(args, unsigned int*);
                        *uintp = uintv;
                }
        }else if (*fmt == 'c'){
                charp = va_arg(args, char*);
                if (width == 0){
                        width = 1;
                }
                while (cur[0] != '\0' && uintv < width){
                        charp[uintv] = cur[0];
                        ++cur;
                        ++uintv;
                }
        }else if (*fmt == 's'){
                charp = va_arg(args, char*);
                while (cur[0] != '\0' && ! is_space(cur[0]) &&
                       (width == 0 || uintv < width)){
                        charp[uintv] = cur[0];
                        ++cur;
                        ++uintv;
                }
                charp[uintv] = '\0';
        }else if (*fmt == '%' && str[0] == '%'){
                ++cur;
        }
        return cur;
}

static char*
print_arg(const char *fmt, char *str, size_t len, va_list args)
{
        unsigned int uintv, width = 0;
        size_t charplen = 0, padlen = 0;
        int intv;
        char *charp, padchar = (*fmt == '0' ? '0' : ' ');
        fmt = dec_to_uint(fmt, &width);
        if (*fmt == 'd' || *fmt == 'i'){
                intv = va_arg(args, int);
                str = int_to_dec(intv, padchar, width, len, str);
        }else if (*fmt == 'u'){
                uintv = va_arg(args, unsigned int);
                str = uint_to_dec(uintv, padchar, width, len, str);
        }else if (*fmt == 'x' || *fmt == 'X'){
                uintv = va_arg(args, unsigned int);
                str = uint_to_hex(uintv, (*fmt == 'X'), padchar, width,
                                  len, str);
        }else if (*fmt == 'p'){
                charp = (char*)va_arg(args, void*);
                str = siz_to_hex((size_t)charp, 0, padchar, width,
                                 len, str);
        }else if (*fmt == 'c'){
                intv = va_arg(args, int);
                if (width > 1){
                        padlen = (size_t)width - 1;
                        padlen = (padlen < len ? padlen : len);
                        memset(str, ' ', padlen);
                        str += padlen;
                        len -= padlen;
                }
                if (len > 0){
                        str[0] = (char) intv;
                        str += 1;
                        len -= 1;
                }
        }else if (*fmt == 's'){
                charp = va_arg(args, char*);
                charplen = strlen(charp);
                if (width > 0 && (size_t)width > charplen){
                        padlen = (size_t)width - charplen;
                        padlen = (padlen < len ? padlen : len);
                        memset(str, ' ', padlen);
                        str += padlen;
                        len -= padlen;
                }
                charplen = (charplen < len ? charplen : len);
                memcpy(str, charp, charplen);
                str += charplen;
                len -= charplen;
        }else if (*fmt == '%'){
                str[0] = '%';
                ++str;
        }
        return str;
}

/*
 * Public functions.
 */

int
sscanf(const char *str, const char *fmt, ...)
{
        int ret = 0;
        va_list args;
        va_start(args, fmt);
        while (fmt[0] != '\0' && str[0] != '\0'){
                if (fmt[0] == '%'){
                        const char * tmp = parse_arg(&fmt[1], str, args);
                        if (tmp == str){
                                break;
                        }
                        if (fmt[1] != '%'){
                                ++ret;
                        }
                        ++fmt;
                        while (fmt[0] >= '0' && fmt[0] <= '9'){
                                ++fmt;
                        }
                        ++fmt;
                        str = tmp;
                }else if (is_space(fmt[0])){
                        ++fmt;
                        str = skip_spaces(str);
                }else if (fmt[0] == str[0]){
                        ++fmt;
                        ++str;
                }else{
                        break;
                }
        }

        va_end(args);
        return ret;
}

