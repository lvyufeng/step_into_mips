#include <asm.h>
#include <regdef.h>
#include <inst_test.h>

LEAF(n51_mtlo_test)
    .set noreorder
    addiu s0, s0 ,1
    li  s2, 0x0
###test inst
    TEST_MTLO(0xc10d76f1, 0xc10d76f1)
    TEST_MTLO(0x6a7f52c1, 0x6a7f52c1)
    TEST_MTLO(0xb96c12c0, 0xb96c12c0)
    TEST_MTLO(0x922cb737, 0x922cb737)
    TEST_MTLO(0xd8f877fc, 0xd8f877fc)
    TEST_MTLO(0x6fdf1878, 0x6fdf1878)
    TEST_MTLO(0xdceb6950, 0xdceb6950)
    TEST_MTLO(0x4511b208, 0x4511b208)
    TEST_MTLO(0xf34dc984, 0xf34dc984)
    TEST_MTLO(0xe2152930, 0xe2152930)
    TEST_MTLO(0x2ca63aa0, 0x2ca63aa0)
    TEST_MTLO(0xaa58aaf8, 0xaa58aaf8)
    TEST_MTLO(0x59f0d4c0, 0x59f0d4c0)
    TEST_MTLO(0x1f8ad31a, 0x1f8ad31a)
    TEST_MTLO(0xcc81d4b7, 0xcc81d4b7)
    TEST_MTLO(0x329dcb30, 0x329dcb30)
    TEST_MTLO(0x7ca62fd0, 0x7ca62fd0)
    TEST_MTLO(0x93faad78, 0x93faad78)
    TEST_MTLO(0x82713960, 0x82713960)
    TEST_MTLO(0x13be36f0, 0x13be36f0)
    TEST_MTLO(0x578d90c0, 0x578d90c0)
    TEST_MTLO(0x5084f9c8, 0x5084f9c8)
    TEST_MTLO(0x9b354320, 0x9b354320)
    TEST_MTLO(0x27034740, 0x27034740)
    TEST_MTLO(0x716f02dc, 0x716f02dc)
    TEST_MTLO(0x1fc92e60, 0x1fc92e60)
    TEST_MTLO(0xb2fad4e0, 0xb2fad4e0)
    TEST_MTLO(0x8647273f, 0x8647273f)
    TEST_MTLO(0x3ee2e33c, 0x3ee2e33c)
    TEST_MTLO(0xeae97850, 0xeae97850)
    TEST_MTLO(0x68f00140, 0x68f00140)
    TEST_MTLO(0x30f585e0, 0x30f585e0)
    TEST_MTLO(0x64d43ee8, 0x64d43ee8)
    TEST_MTLO(0x1700565c, 0x1700565c)
    TEST_MTLO(0xefd20ca0, 0xefd20ca0)
    TEST_MTLO(0xa42e4ca4, 0xa42e4ca4)
    TEST_MTLO(0x1cc16ab8, 0x1cc16ab8)
    TEST_MTLO(0x12716a00, 0x12716a00)
    TEST_MTLO(0x516e9dd0, 0x516e9dd0)
    TEST_MTLO(0x40b9e420, 0x40b9e420)
    TEST_MTLO(0x663e53c4, 0x663e53c4)
    TEST_MTLO(0x1e52da16, 0x1e52da16)
    TEST_MTLO(0x3332b636, 0x3332b636)
    TEST_MTLO(0x733ddc00, 0x733ddc00)
    TEST_MTLO(0x6e0a7e0f, 0x6e0a7e0f)
    TEST_MTLO(0x843d8d6e, 0x843d8d6e)
    TEST_MTLO(0xbaf0e236, 0xbaf0e236)
    TEST_MTLO(0x8416a092, 0x8416a092)
    TEST_MTLO(0x11fa2c80, 0x11fa2c80)
    TEST_MTLO(0x5330fcd8, 0x5330fcd8)
    TEST_MTLO(0x123e3dbd, 0x123e3dbd)
    TEST_MTLO(0xdf39f580, 0xdf39f580)
    TEST_MTLO(0xbc2c7318, 0xbc2c7318)
    TEST_MTLO(0xc4689c4d, 0xc4689c4d)
    TEST_MTLO(0x56efe74c, 0x56efe74c)
    TEST_MTLO(0xfac2f060, 0xfac2f060)
    TEST_MTLO(0x1c7ee058, 0x1c7ee058)
    TEST_MTLO(0xa0be59c0, 0xa0be59c0)
    TEST_MTLO(0xee707bd0, 0xee707bd0)
    TEST_MTLO(0x00000000, 0x00000000)
###detect exception
    bne s2, zero, inst_error
    nop
###score ++
    addiu s3, s3, 1
###output (s0<<24)|s3
inst_error:  
    sll t1, s0, 24
    or t0, t1, s3 
    sw t0, 0(s1)
    jr ra
    nop
END(n51_mtlo_test)
