#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")"

if [ ! -e /opt/bc2/conda-meta ]; then
  conda env create -p /opt/bc2 --file environment.yml
fi

conda env config vars set -p /opt/bc2 BINDCRAFT_WEIGHTS=/opt/bc2/cache > /dev/null

eval "$(conda shell.bash hook)"
conda activate /opt/bc2
python -m pip install -e ".[cuda13]"
bindcraft fetch-weights
python -m bindcraft.selfcheck cuda13
