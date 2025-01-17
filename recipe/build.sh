#!/usr/bin/env bash

set -o xtrace -o nounset -o pipefail -o errexit

export DISABLE_AUTOBREW=1

if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" == "1" ]]; then
    cp ${PREFIX}/lib/R/share/make/shlib.mk ${SRC_DIR}
    sed -i "s?\$(R_HOME)/bin?${BUILD_PREFIX}/bin?g" ${SRC_DIR}/shlib.mk
    sed -i "s?\${R_HOME}/bin?${BUILD_PREFIX}/bin?g" tools/make-recursive.sh
    sed -i "s?\${R_share}/make/\$file?${SRC_DIR}/shlib.mk?g" tools/make-recursive.sh
    sed -i "s?\${R_etc}?${PREFIX}/lib/R/etc?g" tools/make-recursive.sh
    sed -i "s?\`\"\${R_bin}/Rscript\" -e 'cat(tools::makevars_site())'\`?''?" tools/make-recursive.sh
    sed -i "s?\`\"\${R_bin}/Rscript\" -e 'cat(tools::makevars_user())'\`?''?" tools/make-recursive.sh
fi
${R} CMD INSTALL --build . ${R_ARGS:-}
