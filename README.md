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

2. CONFIGURING DATABASE SERVER:
1). To install MySQL server and perform the required tasks, please follow the instructions below:

Step 1: Install MySQL Server

Log in to your server or virtual machine.
Update the package list:

sudo apt update

Install the MySQL server package:

sudo apt install mysql-server

Step 2: Configure MySQL Server

During the installation process, you should be prompted to set the root password for MySQL. Choose a strong password and remember it.

Once the installation is complete, run the following command to secure the MySQL installation:

sudo mysql_secure_installation

You'll be prompted to answer a series of questions. It's recommended to answer "Y" to all of them unless you have specific requirements.

Step 3: Create the Database and User

Log in to the MySQL server as the root user:

sudo mysql -u root -p

Enter the root password when prompted.

Create the database:

CREATE DATABASE tooling;

Create the user:

CREATE USER 'webaccess'@'webservers_subnet_cidr' IDENTIFIED BY 'password';

Replace 'webservers_subnet_cidr' with the actual subnet CIDR of your web servers and 'password' with a strong password for the user.

Grant permissions to the user on the database:

GRANT ALL PRIVILEGES ON tooling.* TO 'webaccess'@'webservers_subnet_cidr';

Flush the privileges to apply the changes:

FLUSH PRIVILEGES;

Exit the MySQL shell:

EXIT;

3. CONFIGURING WEBSERVER:
- we install nfs client 
- mount /var/www of our webserver to the /mnt/apps on our NFS server
- mount /var/log/httpd of our webserver to /mnt/logs on our NFS server
- Verify that NFS was mounted successfully by running df -h. Make sure that the changes will persist on Web Server after reboot.
- Install Remi’s repository, Apache and PHP
- Update the website’s configuration to connect to the database (in /var/www/html/functions.php file). Apply tooling-db.sql script to your database using this command mysql -h <databse-private-ip> -u <db-username> -p <db-pasword> < tooling-db.sql

Create in MySQL a new admin user with username: myuser and password: password:

INSERT INTO ‘users’ (‘id’, ‘username’, ‘password’, ’email’, ‘user_type’, ‘status’) VALUES
-> (1, ‘myuser’, ‘5f4dcc3b5aa765d61d8327deb882cf99’, ‘user@mail.com’, ‘admin’, ‘1’);

Open the website in your browser http://<Web-Server-Public-IP-Address-or-Public-DNS-Name>/index.php and make sure you can login into the website with myuser user.
We will also need a load balancer to help navigate or control traffic coming to our webservers. We will make use of the apache load balancer,we install it and configure it to direct traffic to the ip address of our web-servers.  
