#!/bin/bash

# Copyright (C) 2016-2020, 2022 Free Software Foundation, Inc.
# Written by Simon Sobisch
#
# This file is part of GnuCOBOL.
#
# The GnuCOBOL compiler is free software: you can redistribute it
# and/or modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# GnuCOBOL is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with GnuCOBOL.  If not, see <https://www.gnu.org/licenses/>.

cd "/C/Program Files/gnucobol/"

# Check if called already
# if yes, check if called from here - exit, in any other case
# raise warning and reset env vars
if [ -n "$COB_MAIN_DIR" ]; then
   echo
   if [ "$COB_MAIN_DIR" == "$(dirname "$0")/" ]; then
      echo "Information: script was already called from \"$COB_MAIN_DIR\""
      echo "             skipping environment setting..."
      if [ -n "$1" ]; then
         goto call_if_needed
      fi
      goto cobcver
   else
      echo "Warning: script was called before from \"$COB_MAIN_DIR\""
      echo "         resetting COB_CFLAGS, COB_LDFLAGS"
      unset COB_CFLAGS
      unset COB_LDFLAGS
   fi
fi

# Get the main dir from the script's position
COB_MAIN_DIR="$(dirname "$0")/"

# settings for cobc
COB_CONFIG_DIR="${COB_MAIN_DIR}config"
COB_COPY_DIR="${COB_MAIN_DIR}copy"
COB_CFLAGS="-I\"${COB_MAIN_DIR}include\" $COB_CFLAGS"
COB_LDFLAGS="-L\"${COB_MAIN_DIR}lib\" $COB_LDFLAGS"

# settings for libcob
COB_LIBRARY_PATH="${COB_MAIN_DIR}extras"

# Add the bin path of GnuCOBOL (including GCC) to PATH for further references
PATH="${COB_MAIN_DIR}bin:$PATH"

# Locales
LOCALEDIR="${COB_MAIN_DIR}locale"

# Timezone database
if [ -d "${COB_MAIN_DIR}share/zoneinfo" ]; then
  TZDIR="${COB_MAIN_DIR}share/zoneinfo"
fi

# Start executable as requested
call_if_needed() {
  if [ -n "$1" ]; then
    echo "environment is prepared:"
    cobcver
    echo "now starting the requested $1"
    "$@"
    # exit 0
  fi
}

# New shell to stay open if not started directly from a terminal window
if [[ $- == *i* ]]; then
  cobc.exe --version && echo && echo "GnuCOBOL 3.2.0 (Jul 28 2023 19:08:58), (MinGW) \"9.2.0\" && echo GMP 6.2.1, cJSON 1.7.14, PDCursesMod 4.3.7, BDB 18.1.40"
  # exit 0
fi

# Compiler and package version output
cobcver() {
  echo
  cobc.exe --version
  echo && echo "GnuCOBOL 3.2.0 (Jul 28 2023 19:08:58), (MinGW) \"9.2.0\" && echo GMP 6.2.1, cJSON 1.7.14, PDCursesMod 4.3.7, BDB 18.1.40"
}

cd /c/github/isopod_cob

"$@"
