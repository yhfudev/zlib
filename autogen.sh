#!/bin/bash

MY_PREFIX=`pwd`/build/
if [ ! "${PREFIX}" = "" ]; then
MY_PREFIX="${PREFIX}"
fi
echo "=========== zlib MY_PREFIX=${MY_PREFIX}"

./autoclean.sh

rm -f configure

rm -f Makefile.in

rm -f config.guess
rm -f config.sub
rm -f install-sh
rm -f missing
rm -f depcomp

if [ 0 = 1 ]; then
autoscan
else

touch NEWS
touch README
touch README.md
touch AUTHORS
touch ChangeLog
touch config.h.in
touch install-sh

libtoolize --force --copy --install --automake
aclocal
automake -a -c
autoconf
# run twice to get rid of 'ltmain.sh not found'
autoreconf -f -i -Wall,no-obsolete
autoreconf -f -i -Wall,no-obsolete

if [ 0 = 1 ]; then
  exit 0

  #./configure --prefix="${MY_PREFIX}" --exec-prefix="${MY_PREFIX}" --enable-debug --disable-shared --enable-static --enable-coverage --enable-valgrind
  ./configure --prefix="${MY_PREFIX}" --exec-prefix="${MY_PREFIX}" --libdir="${MY_PREFIX}/lib" --disable-debug --disable-shared --enable-static --disable-coverage --disable-valgrind

  make clean
  make ChangeLog
  make dist-gzip
  #make -C doc/latex/
else
  DN_CUR=`pwd`
  mkdir -p "${MY_PREFIX}"

  if [ ! -d cpp-ci-unit-test ]; then
    git clone -q --depth=1 https://github.com/yhfudev/cpp-ci-unit-test.git
  fi
  cd cpp-ci-unit-test
  git checkout master
  git pull
  cd "${DN_CUR}"

  ./submodule-update.sh

  if [ ! -d "${MY_PREFIX}/libosporting/src" ]; then
    ln -s "${DN_CUR}/lib/libosporting/" "${MY_PREFIX}/libosporting"
  fi
  cd "${MY_PREFIX}/libosporting"
  git checkout master
  git pull
  cd "${DN_CUR}"
  # remove the git submodule:
  # NAME_SUBM=cpp-osporting
  # git submodule deinit $NAME_SUBM
  # git rm lib/$NAME_SUBM
  # git rm --cached lib/$NAME_SUBM
  # Delete the relevant section from .git/config.
  # git commit -m "Removed submodule "
  # rm -rf .git/modules/$NAME_SUBM
  cd "${MY_PREFIX}/libosporting"
  PREFIX="${MY_PREFIX}" ./autogen.sh
  #make DESTDIR="`pwd`/lib/" install
  make install
  cd "${DN_CUR}"

  which "$CC" || CC=gcc
  which "$CXX" || if [[ "$CC" =~ .*clang.* ]]; then CXX=clang++; else CXX=g++; fi
  echo "=========== compiling zlib MY_PREFIX=${MY_PREFIX}"
  CC=$CC CXX=$CXX ./configure --prefix="${MY_PREFIX}" --exec-prefix="${MY_PREFIX}" --libdir="${MY_PREFIX}/lib" --disable-shared --enable-static --disable-debug --enable-coverage --enable-valgrind \
    --with-ciut=`pwd`/cpp-ci-unit-test \
    --with-osporting-include=${MY_PREFIX}/include/ \
    --with-osporting-lib=${MY_PREFIX}/lib/ \
    --disable-xz \
    ${NULL}
  make clean; make -j 8 coverage CC=$CC CXX=$CXX; make check CC=$CC CXX=$CXX; make check-valgrind CC=$CC CXX=$CXX
  echo "=========== installing zlib MY_PREFIX=${MY_PREFIX}"
  make install
  echo "=========== DONE installing zlib MY_PREFIX=${MY_PREFIX}"
fi


fi
