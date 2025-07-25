AC_INIT([FadakaCrypto], [1.0], [dev@fadaka.org])
AC_CONFIG_MACRO_DIR([blockchain])
AC_CONFIG_HEADERS([config.h])
AC_CONFIG_AUX_DIR([build-aux])
AC_PROG_CC

m4_include([blockchain/fadaka_secp.m4])

SECP_X86_64_ASM_CHECK
SECP_ARM32_ASM_CHECK
SECP_VALGRIND_CHECK
SECP_MSAN_CHECK
SECP_TRY_APPEND_CFLAGS([-O3], CFLAGS)

AC_OUTPUT([
  Makefile
  src/Makefile
])
