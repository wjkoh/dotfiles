#!/usr/bin/env python

import os

l = [fname for fname in os.listdir('.') if '.png' in fname]
l = sorted(l, reverse=True)
l = zip(l, ['frame_%04d.png' % i for i in range(len(l))])
for x, y in l:
    os.rename(x, y)
