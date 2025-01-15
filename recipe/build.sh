#!/usr/bin/env bash
set -eux

sed -i -e \
    "s;^#define LIBDIR ;#define LIBDIR \"${PREFIX}/share/hunspell:${PREFIX}/share/hunspell_dictionaries:\" ;" \
    src/tools/hunspell.cxx

autoreconf -vfi

./configure \
    --prefix="${PREFIX}" \
    --with-readline \
    --with-ui

make "-j${CPU_COUNT}"

if [[ "${target_platform}" == "${build_platform}" ]]; then
    make check
fi

make install

chmod a+x "${PREFIX}/bin/hunspell"
