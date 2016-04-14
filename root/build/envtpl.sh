#!/bin/bash

set -e

mkdir /opt/envtpl
virtualenv /opt/envtpl
source /opt/envtpl/bin/activate
pip install envtpl
pip uninstall -y pip

cat >/usr/local/bin/envtpl <<EOF
#!/bin/bash
# wrapper script for envtpl in DCO context

source /opt/envtpl/bin/activate
exec envtpl \$*
EOF

chmod +x /usr/local/bin/envtpl
