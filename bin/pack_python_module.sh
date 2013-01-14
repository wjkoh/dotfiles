#!/usr/bin/env bash

SRC_FNAME=$1
DST_FNAME=${1%.*}

# compress in zip format

# http://sayspy.blogspot.com/2010/03/various-ways-of-distributing-python.html
echo "#!/usr/bin/env python" | cat - $SRC_FNAME > $DST_FNAME
chmod u+x $DST_FNAME
