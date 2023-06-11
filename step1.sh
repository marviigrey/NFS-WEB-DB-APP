sudo fdisk /dev/xvdf
sudo fdisk /dev/xvdg
sudo fdisk /dev/xvdh
lsblk
sudo pvcreate /dev/xvdf1 /dev/xvdg1 /dev/xvdh1
sudo vgcreate nfs /dev/xvdf1 /dev/xvdg1 /dev/xvdh1
sudo vgs
sudo lvcreate -n lv-opt -L 10G nfs
sudo lvcreate -n lv-apps -L 10G nfs
sudo lvcreate -n lv-logs -L 10G nfs
sudo lvcreate -n lv-logs -L 9.90G nfs
sudo mkdir /mnt/apps
sudo mkdir /mnt/logs
sudo mkdir /mnt/opt
sudo mkfs -t xfs /dev/nfs/lv-opt
sudo mkfs -t xfs /dev/nfs/lv-apps
sudo mkfs -t xfs /dev/nfs/lv-logs
sudo mount /dev/nfs/lv-apps /mnt/apps
sudo mount /dev/nfs/lv-logs /mnt/logs
sudo mount /dev/nfs/lv-opt /mnt/opt
sudo yum -y update
sudo yum install nfs-utils -y
sudo systemctl start nfs-server.service
sudo systemctl enable nfs-server.service
sudo systemctl status nfs-server.service
sudo chown -R nobody: /mnt/apps
sudo chown -R nobody: /mnt/logs
sudo chown -R nobody: /mnt/opt

sudo chmod -R 777 /mnt/apps
sudo chmod -R 777 /mnt/logs
sudo chmod -R 777 /mnt/opt

sudo systemctl restart nfs-server.service
sudo vi /etc/exports

/mnt/apps <Subnet-CIDR>(rw,sync,no_all_squash,no_root_squash)
/mnt/logs <Subnet-CIDR>(rw,sync,no_all_squash,no_root_squash)
/mnt/opt <Subnet-CIDR>(rw,sync,no_all_squash,no_root_squash)
