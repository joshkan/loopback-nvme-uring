# bash loopback.sh <file-path>
# this file will be used as backend for emulated nvme device
dev=$1

# load the required modules first
sudo modprobe nvmet
sudo modprobe nvme-fabrics
sudo modprobe nvme-loop

cd /sys/kernel/config/nvmet/subsystems
sudo mkdir nvme-test-target
cd nvme-test-target/
sudo echo 1 > attr_allow_any_host

sudo mkdir namespaces/1
cd namespaces/1
echo -n ${dev} > device_path
echo 1 > enable

sudo mkdir /sys/kernel/config/nvmet/ports/1
cd /sys/kernel/config/nvmet/ports/1

echo 127.0.0.1 > addr_traddr
echo loop > addr_trtype

sudo ln -s /sys/kernel/config/nvmet/subsystems/nvme-test-target/ /sys/kernel/config/nvmet/ports/1/subsystems/nvme-test-target
