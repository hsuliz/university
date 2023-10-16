#!/bin/tcsh
# Hlib-Oleksandr Suliz, Script Language, group no.2

set SHOW_HELP = 0
set QUIET_MODE = 0

alias help 'echo "~~~~~~~~~~~~~~~~~~~~~ EXERCISE 01 ~~~~~~~~~~~~~~~~~~~~~"; \
            echo "Help:"; \
            echo "      Printing current user login, name, and surname."; \
            echo "Usage: "; \
            echo "      tcsh ex_01.tcsh [-h --help] [-q --quiet]"; \
            echo "Options:"; \
            echo "      -h, --help    Display this help message."; \
            echo "      -q, --quiet   Quiet mode, do nothing."; \
            echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"; \
            exit 0'

foreach FLAG ($argv:q)
  switch ($FLAG)
    case -h:
    case --help:
      set SHOW_HELP = 1
      breaksw
    case -q:
    case --quiet:
      set QUIET_MODE = 1
      breaksw
    default:
      breaksw
  endsw
end

if ($SHOW_HELP) then
  help
endif

if ($QUIET_MODE) then
  exit 0
endif

set CURRENT_USER = `getent passwd $USER`
set CURRENT_USER = `echo $CURRENT_USER | cut -d : -f 5 | cut -d, -f1`
echo "Current username is: $USER"
echo "Name and surname is: $CURRENT_USER"