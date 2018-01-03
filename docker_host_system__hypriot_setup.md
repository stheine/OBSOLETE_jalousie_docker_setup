# Install

## Install Hypriot
http://blog.hypriot.com/downloads/
download, write to SD card, and boot in raspi
```
ssh pirate@<new IP>
passwd
# hypriot -> <secret password>

sudo vi /boot/user-data
# Update the 'hostname'

sudo dpkg-reconfigure tzdata

sudo apt-get update
sudo apt-get install -y nfs-common
echo '192.168.6.22:/nfs/Data /mnt/mybook_data nfs defaults 0 0' | sudo tee -a /etc/fstab
sudo mkdir /mnt/mybook_data
sudo mount -a

cat /mnt/mybook_data/linux/docker/docker_host_system__profile >> .profile

sudo update-alternatives --set editor /usr/bin/vim.tiny
```

log out and log in again to make the new profile settings active


## Allow access to the GPIO serial port

https://github.com/openv/openv/wiki/Bauanleitung-RaspberryPi
https://www.raspberrypi.org/documentation/configuration/uart.md
https://www.raspberrypi.org/documentation/configuration/config-txt/boot.md
https://spellfoundry.com/2016/05/29/configuring-gpio-serial-port-raspbian-jessie-including-pi-3/

Note: This is not properly working on Hypriot. It seems like the Hypriot kernel does not support the dtoverlays to enable the UART.

Workaround: ```rpi-update``` to update the kernel - but this is a non-Hypriot kernel then.

https://gitter.im/hypriot/talk

```
sudo vi /boot/cmdline.txt
```
> remove the references to ttyAMA0 and serial

```
sudo vi /boot/config.txt
```
> \# Enable the optional hardware interface, SPI
>
> dtparam=spi=on
>
> \# Enable UART
>
> enable_uart=1
> 
> \# Disable bluetooth
>
> dtoverlay=pi3-disable-bt
> dtoverlay=pi3-miniuart-bt
> 
> \# Allow higher USB current
>
> \# max_usb_current=1

https://www.raspberrypi.org/documentation/configuration/uart.md

```
sudo vi /etc/inittab
```
> comment out the reference to ttyAMA0

```
sudo systemctl disable hciuart
```

## Allow docker access to CIFS filesystem

https://github.com/gondor/docker-volume-netshare/blob/master/README.md

```
wget https://github.com/ContainX/docker-volume-netshare/releases/download/v0.34/docker-volume-netshare_0.34_armhf.deb
sudo dpkg -i docker-volume-netshare_0.34_armhf.deb
rm docker-volume-netshare_0.34_armhf.deb

sudo vi /etc/default/docker-volume-netshare
```
> DKV_NETSHARE_OPTS="cifs"
```
sudo systemctl enable docker-volume-netshare
sudo systemctl start docker-volume-netshare
```

## Reboot to make all the changes active

```
sudo reboot
```

## Docker related tasks
```
git config --global user.email "stheine@arcor.de"
git config --global user.name "Stefan Heine"
git config --global push.default simple

cp /mnt/mybook_data/linux/sshd_certs/pirate /home/pirate/.ssh/id_rsa
ssh -T git@github.com
# accept the host's fingerprint

ln -s /mnt/mybook_data/linux/docker /home/pirate/

cd docker
docker-compose build

./run.sh

crontab -e
```
> @reboot (sleep 30s ; cd /mnt/mybook_data/linux/docker/compose ; /usr/local/bin/docker-compose up -d )&

# Let's Encrypt

https://miki725.github.io/docker/crypto/2017/01/29/docker+nginx+letsencrypt.html
https://certbot.eff.org/#debianother-other

```
crontab -e
```
> 26 0,12 * * * /usr/local/bin/docker-compose run certbot

# Maintenance

## Docker cleanup

```
docker system prune
docker volume prune
```

# References

https://www.heise.de/developer/artikel/Ein-Container-voller-Himbeeren-Docker-auf-dem-Raspberry-Pi-2572533.html

https://www.golem.de/news/docker-auf-dem-raspberry-pi-mit-hypriot-gut-verpackt-1711-130639-3.html
