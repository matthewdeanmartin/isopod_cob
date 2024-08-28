function compile_it(){
  # copilot, please translate above into nice bash with a param for D:\\GnuCOBOL\\
  export COBOL_PATH="/c/Program Files/gnucobol/"
  export COB_MAIN_DIR="${COBOL_PATH}"
  export COB_CONFIG_DIR="${COB_MAIN_DIR}config"
  export COB_COPY_DIR="${COB_MAIN_DIR}copy"
  export COB_CFLAGS="-I\"${COB_MAIN_DIR}include\" $COB_CFLAGS"
  export COB_LDFLAGS="-L\"${COB_MAIN_DIR}lib\" $COB_LDFLAGS"
  export COB_LIBRARY_PATH="${COB_MAIN_DIR}extras"
  export PATH="${COB_MAIN_DIR}bin:$PATH"
  export LOCALEDIR="${COB_MAIN_DIR}locale"
  export TZDIR="${COB_MAIN_DIR}share/zoneinfo"
  mkdir -p dist
  # cobc.exe --free -x -Wall -fnotrunc -Xref -T dist/isopod_cob.lst -o dist/testfunc.exe isopod_cob.cob
  cobc -x -debug modules/gcblunit/gcblunit.cbl --job=-h
}

compile_it