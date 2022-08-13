# create backend file
dd if=/dev/zero of=/tmp/nvme-backend bs=1M count=1000 oflag=direct

# use backend file for emulated nvme

bash loopback.sh /tmp/nvme-backend

#discover and connect
nvme discover -t loop -q hostnqn
nvme connect -t loop -n  nvme-test-target -q hostnqn

