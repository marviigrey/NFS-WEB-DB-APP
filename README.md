In this project we will be working on a 3-tier application with an 
NFS server,a DB server and 3 web servers.
In this architecture, we will configure our nfs server with a 3
EBS volumes attached to the server,creating a volume group to 
join all attached volumes to be one. Out of the volume group created
we pull out logical volumes of type xfs.

1.CONFIGURING NFS SERVER,CREATING PARTITIONS,PVs & VGs:
i). Launch an EC2 RHEL-8 instance:
   - attach 3 EBS volumes to the ec2 instance and ssh into the 
server to confirm volumes.
   - For each volume,create a partition using gdisk or fdisk.
   - install lvm2:
      sudo yum install lvm2 -y
      #confirm installation using "sudo pvs" or "sudo vgs"
   - After installing,we create PVs,VGs, and LVs.
ii). 
