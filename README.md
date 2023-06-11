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
ii). we create mount points for our  directories on the /mnt directory.
iii) Mount the logical volumes on the mount points
iv) install nfs client.
v). Export the mounts for webservers’ subnet cidr to connect as clients. For simplicity, you will install your all three Web Servers inside the same subnet, but in production set up you would probably want to separate each tier inside its own subnet for higher level of security.
vi). Ensure permissions needed to read,write and execute on our nfs files are allowed.
vi) lastly we Configure access to NFS for clients within the same subnet.
NOTE ensure port TCP111,UDP111 and UDP2049 are all open on EC2-sg for our nfs-server.
