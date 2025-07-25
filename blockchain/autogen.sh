#!/bin/bash
set -e
aclocal
autoheader
automake --add-missing
autoconf
