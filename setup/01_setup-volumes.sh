# List all block devices, /dev/nvme0n1 is the root volume, /dev/nvme1n1 is the EBS volume
lsblk

# If filesystem is not made yet, make filesystem within a EBS storage, ext4 is the most common filesystem
sudo mkfs -t ext4 /dev/nvme1n1

# Create a directory for the EBS volume within the root volume
cd / | sudo mkdir /storage

# Mount the EBS volume to the directory
sudo mount /dev/nvme1n1 /storage

# Check if the EBS volume is mounted
df -h

# Make the EBS volume mounted automatically after reboot
sudo vim /etc/fstab # or sudo nano /etc/fstab, then add this line to the end of the file: /dev/nvme1n1 /storage ext4 defaults,nofail 0 2