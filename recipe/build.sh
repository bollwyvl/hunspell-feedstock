#!/usr/bin/env bash
set -eux

# Add hunspell dictionary paths relative to PREFIX. We have to do this here so
# that $PREFIX gets expanded into the patch.
patch -p1 <<EOF
diff --git a/src/tools/hunspell.cxx b/src/tools/hunspell.cxx
--- a/src/tools/hunspell.cxx
+++ b/src/tools/hunspell.cxx
@@ -116,6 +116,8 @@
 #include "../parsers/odfparser.hxx"

 #define LIBDIR                \
+  "${PREFIX}/share/hunspell:" \
+  "${PREFIX}/share/hunspell_dictionaries:" \
   "/usr/share/hunspell:"      \
   "/usr/share/myspell:"       \
   "/usr/share/myspell/dicts:" \

EOF

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
