#! /bin/sh
#
# stow_install.sh
# Copyright (C) 2017 ckitagawa <ckitagawa@ckarch>
#
# Distributed under terms of the MIT license.
#

for D in *; do
  if [[ ! "${D}" =~ ^(midsun)$ ]] && [ -d "${D}" ]; then
    stow "${D}"
  fi
done


