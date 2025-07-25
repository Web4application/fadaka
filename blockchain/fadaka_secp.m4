AC_DEFUN([SECP_TRY_APPEND_CFLAGS], [
  save_CFLAGS="$CFLAGS"
  CFLAGS="$CFLAGS $1"
  AC_MSG_CHECKING([whether C compiler accepts $1])
  AC_COMPILE_IFELSE([AC_LANG_PROGRAM([], [])],
    [AC_MSG_RESULT(yes)
     CFLAGS="$save_CFLAGS $1"],
    [AC_MSG_RESULT(no)
     CFLAGS="$save_CFLAGS"])
])

AC_DEFUN([SECP_X86_64_ASM_CHECK], [
  AC_MSG_CHECKING([for x86_64 assembly support])
  AC_COMPILE_IFELSE([AC_LANG_SOURCE([
    __asm__(".intel_syntax noprefix\nmov rax, rbx\n");
    int main() { return 0; }
  ])], [AC_MSG_RESULT(yes); AC_DEFINE([HAS_X86_64_ASM], 1, [Enable x86_64 ASM]); has_x86_asm=yes],
      [AC_MSG_RESULT(no); has_x86_asm=no])
  AM_CONDITIONAL([HAS_X86_64_ASM], [test "x$has_x86_asm" = "xyes"])
])

AC_DEFUN([SECP_ARM32_ASM_CHECK], [
  AC_MSG_CHECKING([for ARM32 assembly support])
  AC_COMPILE_IFELSE([AC_LANG_SOURCE([
    __asm__("add r0, r0, r1");
    int main() { return 0; }
  ])], [AC_MSG_RESULT(yes); AC_DEFINE([HAS_ARM32_ASM], 1, [Enable ARM32 ASM]); has_arm_asm=yes],
      [AC_MSG_RESULT(no); has_arm_asm=no])
  AM_CONDITIONAL([HAS_ARM32_ASM], [test "x$has_arm_asm" = "xyes"])
])

AC_DEFUN([SECP_VALGRIND_CHECK], [
  AC_CHECK_HEADER([valgrind/memcheck.h],
    [AC_DEFINE([USE_VALGRIND], 1, [Enable Valgrind support])])
])

AC_DEFUN([SECP_MSAN_CHECK], [
  AC_MSG_CHECKING([whether compiling with MemorySanitizer])
  if echo "$CFLAGS" | grep -q "fsanitize=memory"; then
    AC_MSG_RESULT(yes)
    AC_DEFINE([USE_MSAN], 1, [Enable MemorySanitizer support])
  else
    AC_MSG_RESULT(no)
  fi
])
