#!/usr/bin/env bash
set -eux -o pipefail

autoreconf -vfi

./configure "--prefix=${PREFIX}" --with-readline --with-ui

make

if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" != "1" || "${CROSSCOMPILING_EMULATOR}" != "" ]]; then
    make check
fi

make install

mv "${PREFIX}/bin/hunspell" "${PREFIX}/bin"

chmod a+x $PREFIX/bin/hunspell
