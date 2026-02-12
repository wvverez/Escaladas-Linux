# 🐧 Escaladas en Linux

<p align="center">
  <img src="https://img.shields.io/badge/Version-1.2.0-green?style=for-the-badge">
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Creador-Wvverez & JVJIXFMCQ=-cyan?style=flat-square">
  <img src="https://img.shields.io/badge/MADE%20IN-SPAIN-red?colorA=%23aa151b&colorB=%23f1bf00&style=flat-square">
  <img src="https://img.shields.io/badge/Written%20In-Bash-cyan?style=flat-square">
</p>

- [🌟 Binscrack](#Binscrack)
  - [Funcionamiento](#Funcionamiento-Binscrack)
  - [Requerimientos](#Requerimientos-Binscrack)

- [🪬Klesh](#Klesh)
  - [Funcionamiento](#Funcionamiento-Klesh)
  - [Requerimientos](#Requerimientos-Klesh)

- [♐️ SUID GTFO](#SUID-GTFO)
  - [Funcionamiento](#Funcionamiento-Suid-Gtfo)
  - [Requerimientos](#Requerimientos-Suid-Gtfo)

- [🛡️SUDOERS](#Sudoers-GTFO)
  - [Funcionamientos](#Funcionamiento-Sudoers-Gtfo)
  - [Requerimientos](#Requerimientos-Sudoers-Gtfo)

# Binscrack 

`Binscrack` es un sencillo script en bash que permite buscar binarios registrados en la plataforma GTFObins y poder buscar, copiar o ejecutar como se puede abusar de estos binarios. Algunos de los parámetros que puede filtrar este script para abusar de los binarios son: 

- `Sudoers`
- `SUID`
- `File-Read`
- `File-Write`
- `Capabilities`
- `Library Load`
- `Reverse shell`
- `Upload`
- `Download`
- `Command`

## Funcionamiento Binscrack

![ezgif-6fa8bb305a905f04](https://github.com/user-attachments/assets/3d620564-fc22-4e7c-94ec-56755140d31a)

Este script contiene algunos sencillos parámetros para la búsqueda y movimiento.

`$ o Cntrl + C` : Abandonar el script.

`&` : Para mostrar las formas de abusar de el binario seleccionado

## Requerimientos Binscrack

Este script requiere de tener instaladas algunas dependencias para su instalación, al igual que necesita de acceso a `internet` para permitir la conexión con la API de GTFObins.

Herramientas necesarias:

- `ping`
- `curl`
- `jq`
- `tput`

En caso de no tener estas dependencias instaladas podrás instalarlas a partir de este comando:

<pre>
  <code>
    sudo apt update && sudo apt install curl jq iputils-ping ncurses
  </code>
</pre>

Una vez instaladas las dependencias necesarias podrás ejecutar el script. Muchas de estas herramientas vienen preinstaladas en múltiples distribuciones.

# Klesh

Klesh es un sencillo script en bash que permite enumerar permisos sudoers, SUID, capabilities, una vez ganas acceso al sistema, Enumerar versiones de Kernel vulnerables, Si tiene enlazado al /dev/null el bash history, Analisis de spoofing en el sistema, Analisis de logs en el sistema.


## Funcionamiento Klesh

<img width="1012" height="594" alt="image" src="https://github.com/user-attachments/assets/e9fdf32f-c36e-48c2-b590-36c25036a947" />

-p : Análisis de acceso al bash history

-a : Analisis de capabilities, Sudoers, SUID

-s: Analisis de spoofing en el sistema.

--log: Analisis de logs en el sistema.

--kernel: Analisis de versión de Kernel 

## Requerimientos Klesh

- wc
- head y tail
- cut
- readlink
- uname
- arp
- tcpdump
- getcap
- timeout

Para instalar estas dependencias en sistemas (Debian/Ubuntu).

<pre>
  <code>
    sudo apt update && sudo apt install net-tools tcpdump libcap2-bin
  </code>
</pre>

# SUID GTFO

Suid GTFO es un sencillo script en bash algo diferente a los anteriores ya que no proporciona por terminal los outputs si no que genera enlaces a la página oficial de GTFObins. Para poder abusar de estos binarios.

## Funcionamiento Suid Gtfo

<img width="862" height="630" alt="image" src="https://github.com/user-attachments/assets/faf74f2d-c042-4722-9fe7-16be23fcc06e" />

## Requerimientos Suid Gtfo

- curl

Para instalar las dependencias en sistemas (Debian/Ubuntu).

<pre>
<code>
  sudo apt update && sudo apt install curl
</code>
</pre>

# Sudoers GTFO

Sudoers GTFO es un sencillo script en bash que nos proporciona los enlaces pero basandose en los permisos sudoers encontrados. Una versión como Suid GTFO pero en permisos sudoers.

## Funcionamiento Sudoers Gtfo

<img width="888" height="581" alt="image" src="https://github.com/user-attachments/assets/717f72d2-1a29-4b45-9bdd-c361f7394239" />

## Requerimientos Sudoers Gtfo

- curl

Para instalar las dependencias en sistemas (Debian/Ubuntu).

<pre>
<code>
  sudo apt update && sudo apt install curl
</code>
</pre>


> [!WARNING]
> Estas herramientas deben usarse solo para fines éticos, legales y responsables. El usuario es responsable del uso que haga de la herramienta. Los creadores no se hace responsable por un uso indebido o no autorizado.


## 🤜 MEJORAS Y CONTRIBUCIONES

Este proyecto se encuentra en constante evolución, por lo que se aceptan propuestas de mejora y contribuciones de la comunidad. 
Si desea sugerir una mejora, reportar un problema o proponer nuevas funcionalidades, puede hacerlo abriendo un "issue" o "pullrequest" 

Agredecemos su interés y colaboración para el mantenimiento y mejora continua de este repositorio. 
