#!/sbin/busybox sh

/sbin/busybox chmod 755 /sbin
/sbin/busybox chmod 755 /res/recovery.fstab
/sbin/busybox chmod 755 /sbin/recovery
/sbin/busybox chmod 755 /sbin/e2fsck
/sbin/busybox chmod 755 /sbin/fix_permissions
/sbin/busybox chmod 755 /sbin/killrecovery.sh
/sbin/busybox chmod 755 /sbin/nandroid-md5.sh
/sbin/busybox chmod 755 /sbin/parted
/sbin/busybox chmod 755 /sbin/sdparted
/sbin/busybox chmod 755 /sbin/tune2fs
/sbin/busybox chmod 755 /sbin/bmlunlock

# make some folder
/sbin/busybox mkdir /etc
/sbin/busybox mkdir /sd-ext

# symlinking some file
#/sbin/busybox ln -s /res/recovery.fstab /etc/recovery.fstab


# Unlock BML partition
/sbin/bmlunlock

# Mounting /data
/sbin/busybox mount /data
# Unmounting /data
/sbin/busybox umount /data

# symlinking recovery & busybox
/sbin/busybox ln -s /sbin/busybox /sbin/[
/sbin/busybox ln -s /sbin/busybox /sbin/[[
/sbin/busybox ln -s /sbin/busybox /sbin/ash
/sbin/busybox ln -s /sbin/busybox /sbin/awk
/sbin/busybox ln -s /sbin/busybox /sbin/basename
/sbin/busybox ln -s /sbin/busybox /sbin/bbconfig
/sbin/busybox ln -s /sbin/busybox /sbin/bunzip2
/sbin/busybox ln -s /sbin/recovery /sbin/busybox
/sbin/busybox ln -s /sbin/busybox /sbin/bzcat
/sbin/busybox ln -s /sbin/busybox /sbin/bzip2
/sbin/busybox ln -s /sbin/busybox /sbin/cal
/sbin/busybox ln -s /sbin/busybox /sbin/cat
/sbin/busybox ln -s /sbin/busybox /sbin/catv
/sbin/busybox ln -s /sbin/busybox /sbin/chattr
/sbin/busybox ln -s /sbin/busybox /sbin/chgrp
/sbin/busybox ln -s /sbin/busybox /sbin/chmod
/sbin/busybox ln -s /sbin/busybox /sbin/chown
/sbin/busybox ln -s /sbin/busybox /sbin/chroot
/sbin/busybox ln -s /sbin/busybox /sbin/cksum
/sbin/busybox ln -s /sbin/busybox /sbin/clear
/sbin/busybox ln -s /sbin/busybox /sbin/cmp
/sbin/busybox ln -s /sbin/busybox /sbin/cp
/sbin/busybox ln -s /sbin/busybox /sbin/cpio
/sbin/busybox ln -s /sbin/busybox /sbin/cut
/sbin/busybox ln -s /sbin/busybox /sbin/date
/sbin/busybox ln -s /sbin/busybox /sbin/dc
/sbin/busybox ln -s /sbin/busybox /sbin/dd
/sbin/busybox ln -s /sbin/busybox /sbin/depmod
/sbin/busybox ln -s /sbin/busybox /sbin/devmem
/sbin/busybox ln -s /sbin/busybox /sbin/df
/sbin/busybox ln -s /sbin/busybox /sbin/diff
/sbin/busybox ln -s /sbin/busybox /sbin/dirname
/sbin/busybox ln -s /sbin/busybox /sbin/dmesg
/sbin/busybox ln -s /sbin/busybox /sbin/dos2unix
/sbin/busybox ln -s /sbin/busybox /sbin/du
/sbin/busybox ln -s /sbin/recovery /sbin/dump_image
/sbin/busybox ln -s /sbin/busybox /sbin/echo
/sbin/busybox ln -s /sbin/recovery /sbin/edify
/sbin/busybox ln -s /sbin/busybox /sbin/egrep
/sbin/busybox ln -s /sbin/busybox /sbin/env
/sbin/busybox ln -s /sbin/recovery /sbin/erase_image
/sbin/busybox ln -s /sbin/busybox /sbin/expand
/sbin/busybox ln -s /sbin/busybox /sbin/expr
/sbin/busybox ln -s /sbin/busybox /sbin/false
/sbin/busybox ln -s /sbin/busybox /sbin/fdisk
/sbin/busybox ln -s /sbin/busybox /sbin/fgrep
/sbin/busybox ln -s /sbin/busybox /sbin/find
/sbin/busybox ln -s /sbin/recovery /sbin/flash_image
/sbin/busybox ln -s /sbin/busybox /sbin/fold
/sbin/busybox ln -s /sbin/busybox /sbin/free
/sbin/busybox ln -s /sbin/busybox /sbin/freeramdisk
/sbin/busybox ln -s /sbin/busybox /sbin/fuser
/sbin/busybox ln -s /sbin/busybox /sbin/getopt
/sbin/busybox ln -s /sbin/busybox /sbin/grep
/sbin/busybox ln -s /sbin/busybox /sbin/groups
/sbin/busybox ln -s /sbin/busybox /sbin/gunzip
/sbin/busybox ln -s /sbin/busybox /sbin/gzip
/sbin/busybox ln -s /sbin/busybox /sbin/head
/sbin/busybox ln -s /sbin/busybox /sbin/hexdump
/sbin/busybox ln -s /sbin/busybox /sbin/id
/sbin/busybox ln -s /sbin/busybox /sbin/insmod
/sbin/busybox ln -s /sbin/busybox /sbin/install
/sbin/busybox ln -s /sbin/busybox /sbin/kill
/sbin/busybox ln -s /sbin/busybox /sbin/killall
/sbin/busybox ln -s /sbin/busybox /sbin/killall5
/sbin/busybox ln -s /sbin/busybox /sbin/length
/sbin/busybox ln -s /sbin/busybox /sbin/less
/sbin/busybox ln -s /sbin/busybox /sbin/ln
/sbin/busybox ln -s /sbin/busybox /sbin/losetup
/sbin/busybox ln -s /sbin/busybox /sbin/ls
/sbin/busybox ln -s /sbin/busybox /sbin/lsattr
/sbin/busybox ln -s /sbin/busybox /sbin/lsmod
/sbin/busybox ln -s /sbin/busybox /sbin/lspci
/sbin/busybox ln -s /sbin/busybox /sbin/lsusb
/sbin/busybox ln -s /sbin/busybox /sbin/lzcat
/sbin/busybox ln -s /sbin/busybox /sbin/lzop
/sbin/busybox ln -s /sbin/busybox /sbin/lzopcat
/sbin/busybox ln -s /sbin/busybox /sbin/makedevs
/sbin/busybox ln -s /sbin/busybox /sbin/md5sum
/sbin/busybox ln -s /sbin/busybox /sbin/mkdir
/sbin/busybox ln -s /sbin/busybox /sbin/mke2fs
/sbin/busybox ln -s /sbin/busybox /sbin/mkfifo
/sbin/busybox ln -s /sbin/busybox /sbin/mkfs.ext2
/sbin/busybox ln -s /sbin/busybox /sbin/mknod
/sbin/busybox ln -s /sbin/busybox /sbin/mkswap
/sbin/busybox ln -s /sbin/busybox /sbin/mktemp
/sbin/busybox ln -s /sbin/recovery /sbin/mkyaffs2image
/sbin/busybox ln -s /sbin/busybox /sbin/modinfo
/sbin/busybox ln -s /sbin/busybox /sbin/modprobe
/sbin/busybox ln -s /sbin/busybox /sbin/more
/sbin/busybox ln -s /sbin/busybox /sbin/mount
/sbin/busybox ln -s /sbin/busybox /sbin/mountpoint
/sbin/busybox ln -s /sbin/busybox /sbin/mv
/sbin/busybox ln -s /sbin/busybox /sbin/nanddump
/sbin/busybox ln -s /sbin/recovery /sbin/nandroid
/sbin/busybox ln -s /sbin/busybox /sbin/nandwrite
/sbin/busybox ln -s /sbin/busybox /sbin/nice
/sbin/busybox ln -s /sbin/busybox /sbin/nohup
/sbin/busybox ln -s /sbin/busybox /sbin/od
/sbin/busybox ln -s /sbin/busybox /sbin/patch
/sbin/busybox ln -s /sbin/busybox /sbin/pgrep
/sbin/busybox ln -s /sbin/busybox /sbin/pidof
/sbin/busybox ln -s /sbin/busybox /sbin/pkill
/sbin/busybox ln -s /sbin/busybox /sbin/printenv
/sbin/busybox ln -s /sbin/busybox /sbin/printf
/sbin/busybox ln -s /sbin/busybox /sbin/ps
/sbin/busybox ln -s /sbin/busybox /sbin/pstree
/sbin/busybox ln -s /sbin/busybox /sbin/pwd
/sbin/busybox ln -s /sbin/busybox /sbin/rdev
/sbin/busybox ln -s /sbin/busybox /sbin/readlink
/sbin/busybox ln -s /sbin/busybox /sbin/realpath
/sbin/busybox ln -s /sbin/recovery /sbin/reboot
/sbin/busybox ln -s /sbin/busybox /sbin/renice
/sbin/busybox ln -s /sbin/busybox /sbin/reset
/sbin/busybox ln -s /sbin/busybox /sbin/resize
/sbin/busybox ln -s /sbin/busybox /sbin/rev
/sbin/busybox ln -s /sbin/busybox /sbin/rm
/sbin/busybox ln -s /sbin/busybox /sbin/rmdir
/sbin/busybox ln -s /sbin/busybox /sbin/rmmod
/sbin/busybox ln -s /sbin/busybox /sbin/run-parts
/sbin/busybox ln -s /sbin/busybox /sbin/sed
/sbin/busybox ln -s /sbin/busybox /sbin/seq
/sbin/busybox ln -s /sbin/busybox /sbin/setconsole
/sbin/busybox ln -s /sbin/recovery /sbin/setprop
/sbin/busybox ln -s /sbin/busybox /sbin/setserial
/sbin/busybox ln -s /sbin/busybox /sbin/setsid
/sbin/busybox ln -s /sbin/busybox /sbin/sh
/sbin/busybox ln -s /sbin/busybox /sbin/sha1sum
/sbin/busybox ln -s /sbin/busybox /sbin/sha256sum
/sbin/busybox ln -s /sbin/busybox /sbin/sha512sum
/sbin/busybox ln -s /sbin/busybox /sbin/sleep
/sbin/busybox ln -s /sbin/busybox /sbin/sort
/sbin/busybox ln -s /sbin/busybox /sbin/split
/sbin/busybox ln -s /sbin/busybox /sbin/stat
/sbin/busybox ln -s /sbin/busybox /sbin/strings
/sbin/busybox ln -s /sbin/busybox /sbin/stty
/sbin/busybox ln -s /sbin/busybox /sbin/swapoff
/sbin/busybox ln -s /sbin/busybox /sbin/swapon
/sbin/busybox ln -s /sbin/busybox /sbin/sync
/sbin/busybox ln -s /sbin/busybox /sbin/sysctl
/sbin/busybox ln -s /sbin/busybox /sbin/tac
/sbin/busybox ln -s /sbin/busybox /sbin/tail
/sbin/busybox ln -s /sbin/busybox /sbin/tar
/sbin/busybox ln -s /sbin/busybox /sbin/tee
/sbin/busybox ln -s /sbin/busybox /sbin/test
/sbin/busybox ln -s /sbin/busybox /sbin/time
/sbin/busybox ln -s /sbin/busybox /sbin/top
/sbin/busybox ln -s /sbin/busybox /sbin/touch
/sbin/busybox ln -s /sbin/busybox /sbin/tr
/sbin/busybox ln -s /sbin/busybox /sbin/true
/sbin/busybox ln -s /sbin/busybox /sbin/tty
/sbin/busybox ln -s /sbin/busybox /sbin/umount
/sbin/busybox ln -s /sbin/busybox /sbin/uname
/sbin/busybox ln -s /sbin/busybox /sbin/unexpand
/sbin/busybox ln -s /sbin/busybox /sbin/uniq
/sbin/busybox ln -s /sbin/busybox /sbin/unix2dos
/sbin/busybox ln -s /sbin/busybox /sbin/unlzma
/sbin/busybox ln -s /sbin/busybox /sbin/unlzop
/sbin/busybox ln -s /sbin/busybox /sbin/unxz
/sbin/busybox ln -s /sbin/recovery /sbin/unyaffs
/sbin/busybox ln -s /sbin/busybox /sbin/unzip
/sbin/busybox ln -s /sbin/busybox /sbin/uptime
/sbin/busybox ln -s /sbin/busybox /sbin/usleep
/sbin/busybox ln -s /sbin/busybox /sbin/uudecode
/sbin/busybox ln -s /sbin/busybox /sbin/uuencode
/sbin/busybox ln -s /sbin/recovery /sbin/volume
/sbin/busybox ln -s /sbin/busybox /sbin/watch
/sbin/busybox ln -s /sbin/busybox /sbin/wc
/sbin/busybox ln -s /sbin/busybox /sbin/which
/sbin/busybox ln -s /sbin/busybox /sbin/whoami
/sbin/busybox ln -s /sbin/busybox /sbin/xargs
/sbin/busybox ln -s /sbin/busybox /sbin/xzcat
/sbin/busybox ln -s /sbin/busybox /sbin/yes
/sbin/busybox ln -s /sbin/busybox /sbin/zcat


#/sbin/busybox rm /cache/recovery/command
#/sbin/busybox rm /cache/update.zip
#/sbin/busybox touch /tmp/.ignorebootmessage


########### Mod Cerecilla ############

PATH_RECOVERY_OLD="/system/bin/recovery-old"
LOG="/recovery_load.log"
KEY="/cache/recovery/load-recovery-old"

date > $LOG

## Elección de la correcta tabla de particiones  ##

PATH_CONFIG="/system/cerecillaconfig.ini"
busybox mount -t rfs -o remount,rw /dev/block/stl9 /system

echo "Información durante la inicialización del recovery con el mod cerecilla..." >> $LOG

## Se comprueba si existe el archivo /cerecillaconfig.ini
	
echo "Buscando archivo de configuración para el cerecillamod.sh ..." >> $LOG
if [ -e $PATH_CONFIG ]
then

	source $PATH_CONFIG
	echo "Archivo de configuración de cerecillamod.sh encontrado" >> $LOG
		# Comprobamos si "data2ext" está habilidatdo dentro del archivo de configuración
	if [ "$last_path_data" == "sdext2" ]
	then

		echo "Utilizando el archivo de montajes fstab.recovery.expasión..." >> $LOG
		ln -s /cerecilla.mod/recovery.fstab.expansion/recovery.fstab /etc/

	else

		echo "Utilizando el archivo de montajes fstab.recovery clásico..." >> $LOG
		ln -s /cerecilla.mod/recovery.fstab.native/recovery.fstab /etc/

	fi

else

	echo "Archivo no encontrado..." >> $LOG
	echo "Utilizando el archivo de montajes fstab.recovery clásico..." >> $LOG
	ln -s /cerecilla.mod/recovery.fstab.native/recovery.fstab /etc/

fi


## Fin de decisión de tabla de particiones a utilizar ##


## Decisión de recovery a utilizar

mount -t rfs -o rw,nosuid,nodev /dev/block/stl10 /cache

echo ""
echo "Averiguando que recovery hay que utilizar...." >> $LOG


# Comprobamos si existe el arhivo "load-recovery-old" dentro de la carpeta /var/cache
echo "Buscando archivo (gatillo)...." >> $LOG
if [ -e $KEY ]
then
	rm  $KEY
	echo "Se ha dado la orden de usar el binario de recóvery antiguo..." >> $LOG
	# Se comprueba si existe el recovery viejo:
	echo "Buscando binario antiguo..." >> $LOG
	if [ -e $PATH_RECOVERY_OLD ]
	then

		echo "Binario recovery encontrado en $PATH_RECOVERY_OLD" >> $LOG
		echo "Usando recovery viejo" >> $LOG
		#nohup $PATH_RECOVERY_OLD &
		setprop load.recovery.new 0
		setprop load.recovery.old 1
	else

		echo "No se encontró el binario del viejo recovery en $PATH_RECOVERY_OLD" >> $LOG
		echo "Utilizando el recovery por defecto" >> $LOG
		#nohup /sbin/recovery &
		setprop load.recovery.old 0
		setprop load.recovery.new 1
	fi

else

	echo "No hay ordenes de cambio alguno..." >> $LOG
	echo "Utilizando el recovery por defecto" >> $LOG
	#nohup /sbin/recovery &
	setprop load.recovery.old 0
	setprop load.recovery.new 1

fi

############ Fin mod Cerecilla ############ 

setprop rev-install.ready 1 

exit 1
