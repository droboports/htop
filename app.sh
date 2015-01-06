### NCURSES ###
_build_ncurses() {
local VERSION="5.9"
local FOLDER="ncurses-${VERSION}"
local FILE="${FOLDER}.tar.gz"
local URL="http://ftp.gnu.org/gnu/ncurses/${FILE}"

_download_tgz "${FILE}" "${URL}" "${FOLDER}"
pushd target/"${FOLDER}"
./configure --host="${HOST}" --prefix="${DEPS}" --libdir="${DEST}/lib" --datadir="${DEST}/share" --with-shared --enable-rpath --enable-widec
make
make install
rm -v "${DEST}/lib"/*.a
popd
}

### HTOP ###
_build_htop() {
local VERSION="1.0.3"
local FOLDER="htop-${VERSION}"
local FILE="${FOLDER}.tar.gz"
local URL="http://hisham.hm/htop/releases/${VERSION}/${FILE}"

_download_tgz "${FILE}" "${URL}" "${FOLDER}"
pushd target/"${FOLDER}"
./configure --host="${HOST}" --prefix="${DEST}" --enable-unicode --disable-native-affinity \
 ac_cv_func_malloc_0_nonnull=yes \
 ac_cv_func_realloc_0_nonnull=yes \
 ac_cv_file__proc_stat=yes \
 ac_cv_file__proc_meminfo=yes 
make clean
make
make install
popd
}

_build() {
  _build_ncurses
  _build_htop
  _package
}
