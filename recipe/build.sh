#!/usr/bin/env bash

set -o xtrace -o nounset -o pipefail -o errexit

export DISABLE_AUTOBREW=1

if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" == "1" ]]; then
    sed -i "s?\${R_HOME}/bin?${BUILD_PREFIX}/bin?g" tools/make-recursive.sh
    sed -i "s?\${R_share}?${PREFIX}/lib/R/share?g" tools/make-recursive.sh
    sed -i "s?\${R_etc}?${PREFIX}/lib/R/etc?g" tools/make-recursive.sh
fi
${R} CMD INSTALL --build . ${R_ARGS:-}
