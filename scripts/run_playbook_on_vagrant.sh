#!/bin/sh

set -ex
CURRENT=$(cd $(dirname $0) && pwd)

ansible-playbook -u vagrant --private-key=~/.vagrant.d/insecure_private_key -i ./hosts ./odango_vagrant.yml -vvv

