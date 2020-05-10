
AM_LDFLAGS=
AM_CFLAGS=

DEFS+= \
    `getconf LFS_CFLAGS` \
    `getconf LFS64_CFLAGS` \
    -D_GNU_SOURCE \
    -D_FILE_OFFSET_BITS=64 \
    -DHAVE_MMAP64=1 \
    $(NULL)

AM_CFLAGS+= \
    -I$(top_srcdir)/src/ \
    -I$(top_srcdir)/include/ \
    -I$(top_builddir)/ \
    -I$(top_builddir)/src/ \
    -I$(top_builddir)/include/ \
    $(NULL)

AM_LDFLAGS += \
    -L$(top_builddir)/src/ \
    `getconf LFS_LDFLAGS` \
    `getconf LFS64_LDFLAGS` \
    $(NULL)

if DEBUG
# use "valgrind --tool=memcheck --leak-check=yes" to check memory leak, MemWatch will drag the program.
#DEFS+=-DMEMWATCH
DEFS+= -DDEBUG=1
AM_CFLAGS+=-g -Wall

else
AM_CFLAGS+=-O3 -Wall
endif
################################################################################

SRC_BASE= \
    adler32.c \
    compress.c \
    crc32.c \
    deflate.c \
    gzclose.c \
    gzlib.c \
    gzread.c \
    gzwrite.c \
    infback.c \
    inffast.c \
    inflate.c \
    inftrees.c \
    trees.c \
    uncompr.c \
    zutil.c \
    $(NULL)

include_HEADERS = \
    crc32.h \
    deflate.h \
    gzguts.h \
    inffast.h \
    inffixed.h \
    inflate.h \
    inftrees.h \
    trees.h \
    zconf.h \
    zlib.h \
    zutil.h \
    $(NULL)

noinst_HEADERS= \
    $(NULL)

lib_LTLIBRARIES=libz.la

libz_la_SOURCES=$(SRC_BASE)

libz_la_CFLAGS=$(AM_CFLAGS)
#libz_la_CXXFLAGS=$(libz_la_CFLAGS)
libz_la_LDFLAGS=

