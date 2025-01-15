#!/usr/bin/env bash
set -eux

sed -i \
    "s;^#define LIBDIR ;#define LIBDIR \"${PREFIX}/share/hunspell:${PREFIX}/share/hunspell_dictionaries:\" ;" \
    tools/hunspell.cxx

autoreconf -vfi

./configure \
    --prefix="${PREFIX}" \
    --with-readline \
    --with-ui

make

if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" != "1" || "${CROSSCOMPILING_EMULATOR}" != "" ]]
then
    make check
fi

make install

chmod a+x "${PREFIX}/bin/hunspell"
