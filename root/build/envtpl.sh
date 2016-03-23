#!/bin/bash

mkdir /opt/dco
virtualenv /opt/dco/envtpl
source /opt/dco/envtpl/bin/activate
pip install envtpl
pip uninstall -y pip

cat >/usr/local/bin/envtpl <<EOF
#!/bin/bash
# wrapper script for envtpl in DCO context

source /opt/dco/envtpl/bin/activate
exec envtpl $*
EOF

chmod +x /usr/local/bin/envtpl
