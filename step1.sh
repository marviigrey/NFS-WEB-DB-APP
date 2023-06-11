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

