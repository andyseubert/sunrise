#! /bin/bash

raspistill --nopreview -o /tmp/now.jpg
mpack -s "what i see now" /tmp/now.jpg andys\@florapdx.com
