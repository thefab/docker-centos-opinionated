#!/bin/env python

from __future__ import print_function
import os
import sys
from jinja2 import Template

template_content = sys.stdin.read()
template = Template(template_content)
new_content = template.render(os.environ)

print(new_content)
