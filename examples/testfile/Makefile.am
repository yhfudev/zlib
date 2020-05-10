
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

include_HEADERS = \
    $(NULL)

noinst_HEADERS= \
    $(NULL)

BIN_TEST=
BIN_TEST+=testfile

testfile_SOURCES= \
    ../native/main.cpp \
    testmain.cpp \
    $(NULL)

testfile_LDADD = $(top_builddir)/src/libz.la $(libz_LIBADD)
testfile_CFLAGS=$(AM_CFLAGS) $(libz_la_CFLAGS)
testfile_CXXFLAGS=$(testfile_CFLAGS)
testfile_LDFLAGS=$(AM_LDFLAGS) -lz $(libz_la_LDFLAGS) -lm



#bin_PROGRAMS=$(BIN_TEST)
noinst_PROGRAMS=$(BIN_TEST)
#TESTS=ciutexe
#check_PROGRAMS=ciutexe

################################################################################

.pde.cpp:
	cp $< $@
.ino.cpp:
	cp $< $@
dummy.cpp:
	touch $@


