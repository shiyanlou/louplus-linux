#!/bin/sed -f

/^$/{N;/\n$/D}
s/^\n\[/\n\!\[/