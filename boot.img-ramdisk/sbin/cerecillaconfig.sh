#!/system/bin/sh

    #######################################
    ##  Script realizado por Scorpyo82   ##
    ##   Para la aplicación de ajustes   ##
    ##       del Kernel Cerecilla        ##
    #######################################

##   Script de comprobación y configuración del Kernel Cerecilla
#    Este script se encarga de comprobar los ajustes establecidos por el
#    usuario realizados con la aplicación "ajustes especiales GC" 
#    desarrollada por Miguel Ponce Torres
#
#    Copyright (C) <2014> <Miguel Ponce Torres>
#
#    Este Script y sus métodos están protegidos bajo licencia GNU GPL
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#
#    Este script está diseñado para que funcione bajo sistemas
#    rooteados y con busybox instalado adecuadamente.


## VARIABLES:
VERSION="1.0"
LOG="/system/cerecillaconfig_v$VERSION.log"
PATH_CONFIG="/system/cerecillaconfig.ini"
DATA_NAND="/dev/block/stl11"
SD_CACHE="/sys/devices/virtual/bdi/179:0/read_ahead_kb"

/sbin/busybox mount -o remount,rw /system
/sbin/busybox mount -o remount,rw /

date > $LOG

## FUNCIONES:

function LOAD_CONFIG(){
## Función que comprueba si existe el archivo /cerecillaconfig.ini
	
	echo "Buscando archivo de configuración para el kernel..." | tee -a $LOG
	if [ ! -e $PATH_CONFIG ]
	then
		echo "¡El archivo $PATH_CONFIG no existe!" | tee -a $LOG
		return 2
	else
		source $PATH_CONFIG
		echo "Archivo de configuración del kernel encontrado" | tee -a $LOG
		return 0
	fi
}


function FIX_CONFIG(){
## Función para corregir los valores de cerecillaconfig.ini

	## Comprobando si el primer argumento se encuentra dentro de la lista de configuración:
	grep "$1" $PATH_CONFIG 1> /dev/null

	if [ $? == "0" ]
	then
		## Se cambia el contenido de la línea por el nuevo valor:
		echo "Estableciendo el parámetro $1 a $2...." | tee -a $LOG
		sed "/$1/c\\$1=$2" -i $PATH_CONFIG
	else
		## Si antes no se encontró nada, se añade esta opción al fichero
		echo "Añadiendo la nueva opción al archivo de configuración:" | tee -a $LOG
		echo "$1=$2" | tee -a $LOG
		echo "$1=$2" >> $PATH_CONFIG
	fi
}

function CALC_SDEXT2_TO_DATA(){
## Función para saber si hay espacio en /data (original) para pasar el contenido de la partición extendida en la SD

	# Obtenemos el espacio total del que se podría disponer en /data (original) en kb
	echo "Calculanddo el tamaño total de la partición /data (original)..." | tee -a $LOG
	TOTAL_SIZE_DATA=$(busybox df 2> /dev/null | grep "$DATA_NAND" | awk '{ print $2 }')
	if [ "$TOTAL_SIZE_DATA" == "" ]
	then
		echo "No se pudo calcular el tamaño total de la partición /data (original)" | tee -a $LOG
		return 2
	else
		echo "Hecho." | tee -a $LOG
	fi

	# Obtenemos el tamaño en Kb de los datos escritos en /data/ que está en la SD:
	SIZE_DATA_EXT=$(busybox du -s /sd-ext 2> /dev/null | awk '{ print $1}')
	echo "Calculando el tamaño de datos guardados en la 2ª partición de la tarjeta" | tee -a $LOG
	if [ "$SIZE_DATA_EXT" == "" ]
	then
		echo "No se pudo calcular el tamaño de datos guardados en la 2ª partición de la tarjeta" | tee -a $LOG
		return 2
	else
		echo "Hecho." | tee -a $LOG
	fi

	# Calculamos si el espacio que quedaría hay en /data (original) es mayor que la que se va a escribir
	CALC_SIZE=`expr $TOTAL_SIZE_DATA - $SIZE_DATA_EXT`
	echo "Calculando el espacio tras el volcado de datos" | tee -a $LOG
	if [ "$CALC_SIZE" == "" ]
	then
		echo "No se pudo calcular el espacio tras el volcado de datos" | tee -a $LOG
		return 2
	else

		if [ $TOTAL_SIZE_DATA -gt $SIZE_DATA_EXT ]
		then

			echo "Hay espacio suficiente para mover los datos de sd-ext a /data (nand)" | tee -a $LOG
			echo "" 
			echo "Cálculos para mover los datos de sd-ext a la partición data en NAND" | tee -a $LOG
			echo "" | tee -a $LOG
			echo "Detalles:" | tee -a $LOG
			echo "Tamaño de los datos a mover es:   $SIZE_DATA_EXT Kb" | tee -a $LOG
			echo "El espacio actual en NAND es: $TOTAL_SIZE_DATA Kb" | tee -a $LOG
			echo ""
			return 0

		else

			echo "No hay espacio suficiente para mover los datos de sd-ext a /data (nand)" | tee -a $LOG
			echo "" 
			echo "Cálculos para mover los datos de sd-ext a la partición data en NAND" | tee -a $LOG
			echo "" | tee -a $LOG
			echo "Detalles:" | tee -a $LOG
			echo "Tamaño de los datos a mover es:   $SIZE_DATA_EXT Kb" | tee -a $LOG
			echo "El espacio actual en NAND es: $TOTAL_SIZE_DATA Kb" | tee -a $LOG
			echo "Tamaño restante en NAND tras la operación: $CALC_SIZE Kb" | tee -a $LOG
			echo ""
			return 1
		fi
	fi
}

function FORMAT_SDEXT2(){
## Función que elimina todo el contenido de la segunda partición de la tarjeta SD
	
	echo "" | tee -a $LOG
	echo "Se ha solicitado el borrado de todo el contenido de la 2ª partición de la tarjeta SD..." | tee -a $LOG
	echo "Procediendo con el borrado del contenido de la 2ª partición de la SD..." | tee -a $LOG
	# Se crea una carpeta temporal para albergar la partición data y luego se borra todo su contenido
	echo "Creando carpeta /sd-ext" | tee -a $LOG
	mkdir /sd-ext
	echo "Montando segunda partición en /sd-ext" | tee -a $LOG
	sleep 6
	/sbin/busybox mount -o nosuid,nodev,noatime,nodiratime /dev/block/mmcblk0p2 /sd-ext
	echo "Eliminando todo el contenido..." | tee -a $LOG
	rm -rf /sd-ext/*
	echo "Desmontando la partición..." | tee -a $LOG
	/sbin/busybox umount /sd-ext
	rm -rf /sd-ext
	echo "¡Hecho!" | tee -a $LOG
	
	## Se llama a la función FIX_CONFIG para corregir el valor de format_ext
	FIX_CONFIG format_sdext2 false

	## Establecer el tamaño de cache de la SD

	if [ -e $SD_CACHE ]
	then
		echo "2048" > $SD_CACHE
	fi
}

function FORMAT_DATA_NAND(){
## Función que elimina todo el contenido de /data original
	
	echo "" | tee -a $LOG
	echo "Se ha solicitado el borrado de todo el contenido de la partición de NAND que contenía /data originalmente..." | tee -a $LOG
	# Se crea una carpeta temporal para albergar la partición data y luego se borra todo su contenido
	echo "Creando la carpeta /data-nand" | tee -a $LOG
	mkdir /data-nand
	echo "Montando /data original en /data-nand" | tee -a $LOG
	/sbin/busybox mount -t rfs $DATA_NAND /data-nand
	echo "Eliminando todo el contenido de la partición /data (NAND)" | tee -a $LOG
	rm -rf /data-nand/*
	echo "Desmontando /data original de /data-nand" | tee -a $LOG
	/sbin/busybox umount /data-nand
	echo "Eliminando carpeta /data-nand" | tee -a $LOG
	rm -rf /data-nand
	echo "¡Hecho!" | tee -a $LOG

	FIX_CONFIG format_datanand false
}

function DATA_TO_SDEXT2(){
## Función que monta la partición externa en /data

	echo "" | tee -a $LOG
	echo "Preparándose para montar la segunda partición de la tarjeta como /data" | tee -a $LOG
	echo "Escaneando la partición de la tarjeta en busca de errores..." | tee -a $LOG
	echo "" | tee -a $LOG
	echo "Datos del Scan:" | tee -a $LOG
	echo "" | tee -a $LOG
	/sbin/e2fsck -f -p -t -t -v /dev/block/mmcblk0p2 | tee -a $LOG
	echo "Terminado" | tee -a $LOG
	echo "" | tee -a $LOG
	echo "Montando partición de la tarjeta como /data/" | tee -a $LOG
	/sbin/busybox mount -o nosuid,nodev,noatime,nodiratime,barrier=0,data=writeback /dev/block/mmcblk0p2 /data
	echo "¡Hecho!" | tee -a $LOG
	echo "" | tee -a $LOG

	# Comprobamos si es la primera vez que sd-ext está siendo montada como /data y si /data nand a estado montada nativamente
	# para mover los datos de NAND a SDEXT2 si esas dos coincidencias se cumplen al mismo tiempo.
	if [ "$last_type_mount_datanand" == "native" ] && [ "$last_type_mount_sdext2" == "native" ]
	then
		## Montamos NAND temporalmente en /data-nand para pasar todo el contenido a /data
		# Se crea una carpeta temporal para albergar la partición NAND y luego se copia todo su contenido hacia /data preservando permisos
		mkdir /data-nand
		/sbin/busybox mount -t rfs -o nosuid,nodev,check=no /dev/block/stl11 /data-nand
		cp -Rpf /data-nand/* /data/
		sync
		/sbin/busybox umount /data-nand
	fi

	# Además, corregimos el valor de "last_type_mount_sdext2" para darle el valor de "data" (dejamos el valor "last_type_mount_datanand" sin modificar)
	FIX_CONFIG last_type_mount_sdext2 data

	# También dejamos constancia de donde se encuentra ahora la carpeta /data:
	FIX_CONFIG last_path_data sdext2
}

function DATA_TO_NAND(){
## Función que monta la partición NAND en /data (Esto es su forma nativa)

	echo "" | tee -a $LOG
	echo "Preparándose para montar la partición NAND como /data" | tee -a $LOG
	echo "Montando partición NAND $DATA_NAND como /data/" | tee -a $LOG
	/sbin/busybox mount -t rfs -o nosuid,nodev,check=no /dev/block/stl11 /data
	echo "¡Hecho!" | tee -a $LOG

	# Comprobamos si la ruta de la partición /data apunta hacia sdext2 y si sdext2 a estado montada en /data la última vez,
	# para mover los datos de SDEXT2 a NAND si esas dos coincidencias se cumplen al mismo tiempo.
	if [ "$last_path_data" == "sdext2" ] && [ "$last_type_mount_sdext2" == "data" ]
	then
		## Montamos la 2ª partición de la tarjeta temporalmente en /sd-ext para pasar todo el contenido a /data
		# Se crea una carpeta temporal para albergar la partición sd-ext y luego se copia todo su contenido hacia /data preservando permisos
		echo "Anteriormente la partción data ha estado montada en la 2º partición, así que se montará en /sd-ext para copiar todos los datos...."  | tee -a $LOG
		echo "Creando carpeta /sd-ext"  | tee -a $LOG
		mkdir /sd-ext
		echo "Montando 2ª partición de la SD en /sd-ext"  | tee -a $LOG
		/sbin/busybox mount -o nosuid,nodev,noatime,nodiratime,barrier=0,data=writeback /dev/block/mmcblk0p2 /sd-ext

		# Calculamos si es posible pasar los datos:
		CALC_SDEXT2_TO_DATA
		if [ "$?" == "0" ]
		then
			# Formateamos data_nand
			FORMAT_DATA_NAND
			cp -Rpf /sd-ext/* /data
			sync
			/sbin/busybox umount /sd-ext
			# Además, corregimos el valor de "last_path_data nand" para darle el valor de "nand" y el de "last_type_mount_datanand" a "native"
			FIX_CONFIG last_path_data nand
			FIX_CONFIG last_type_mount_datanand native
		
		else
			echo "No se ha podido mover los datos ni efectuar cambios." | tee -a $LOG
			echo "¿Hay suficiente espacio en el teléfono?" | tee -a $LOG
			echo "Se montará data en el mismo lugar que en el último reinicio" | tee -a $LOG
			/sbin/busybox umount /data
			DATA_TO_SDEXT2
		fi
	fi
}


function MOUNT_DALVIK2NAND(){
## Función que monta la partición /data original en /data/dalvik-cache

	echo "Montando partición interna del teléfono como /data/dalvik-cache" | tee -a $LOG
	/sbin/busybox mount -t rfs -o nosuid,nodev,check=no /dev/block/stl11 /data/dalvik-cache

	# Nos aseguramos de limpiar la carpeta si anteriormente la partición ha estado usándose nativamente:
	if [ "$last_type_mount_datanand" == "native" ]
	then
		rm -rf /data/dalvik-cache/*
		
		# Corregimos el valor de "last_type_mount_datanand" para poner que se está usando como dalvik
		FIX_CONFIG last_type_mount_datanand dalvik
	fi
}

## OPERACIONES

## Comprobamos si el archivo de configuración existe
LOAD_CONFIG
if [ "$?" == "0" ]
then
	# Comprobamos si "data_to_ext2" está habilidatdo dentro del archivo de configuración
	if [ "$data_to_sdext2" == "true" ]
	then

		# Comprobamos si "format_sdext2" está habilitado dentro del archivo de configuración
		# O si la partición externa se estuvo usando de forma nativa, pues entonces habría que borrarla
		if [ "$format_sdext2" == "true" ] || [ $last_type_mount_sdext2=native ]
		then

			# Esto significa que la partición externa se debe formatear por dos razones, la 1ª porque el usuario lo pida, la 2ª porque
			# la partición puede estar sucia al haber estado montada nativamente.
			FORMAT_SDEXT2

		fi
			
		DATA_TO_SDEXT2 # Función para montar al fin /data en la segunda partición externa de la SD
			
		# Comprobamos además, si hay que montar dalvik-cache en la partición nand
		if [ "$dalvik2nand" == "true" ]
		then
			# Comprobamos si hay que limpiar la partición NAND o si ha estado sucia por estar montada nativamente
			if [ "$format_data_nand" == "true" ]
			then
				FORMAT_DATA_NAND
			fi

			MOUNT_DALVIK2NAND
		
		fi
	else
		# Comprobamos donde estuvo montada la partición data por última vez....
		if [ "$last_path_data" == "sdext2" ]
		then
			
			# Si estuvo montada en la 2ª partición de la tarjeta entonces hay que limpiar NAND luego
			# mover los datos y por último corregir los valores, pero eso lo controlará la función DATA_TO_NAND
			# pues es la función que averiguará si se puede llevar a cabo la operación de mover los datos
			DATA_TO_NAND
		else
			# Si anteriormente sdext2 no estuvo montada como /data se continúa montando data nativamente
			echo "" | tee -a $LOG
			echo "data_to_sdext2 está desactivado y no se han encontrado nada que haya que corregir." | tee -a $LOG
			echo "Así que la partición /data será la original de fábrica" | tee -a $LOG
			echo "Montando data en su lugar nativo..." | tee -a $LOG
			/sbin/busybox mount -t rfs -o nosuid,nodev,check=no /dev/block/stl11 /data
		fi
	fi

else

	# Si no existe se montará data como corresponde nativamente.
	echo "" | tee -a $LOG
	echo "No se encontró datos sobre la opción data_to_sdext2, así que la partición /data será la original de fábrica" | tee -a $LOG
	echo "Montando data en su lugar nativo..." | tee -a $LOG
	/sbin/busybox mount -t rfs -o nosuid,nodev,check=no $DATA_NAND /data
fi

/sbin/busybox mount -o remount,ro /system
/sbin/busybox mount -o remount,ro /

setprop cerecillaconfig.service ready

	####################### FUNCIONES NO USADAS PERO DE PROVECHO PARA FUTURAS MEJORAS #######################
	####################### --------------------------------------------------------- #######################
