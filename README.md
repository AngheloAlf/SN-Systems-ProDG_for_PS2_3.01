# SN-Systems-ProDG_for_PS2_3.01

This repository contains the SN toolchain for PS2, specifically the "GCC 2.95.3 (SN BUILD v1.36)" version.

The files included in this repo are:

- `PRODG3.01.exe`: The original installer for the toolchain.
  - It requires the original Sony toolchain to be installed at `C:\usr\local\sce`, but just creating empty folders with that path bypasses the check.
- `ProDG for PlayStation2`: The folder installed at `C:\Program Files (x86)\ProDG for PlayStation2`.
  - It doesn't seem to contain anything too important, but it is kept for completeness sake.
- `usr`: The actual toolchain.
  - The compiler driver is located at `./usr/local/sce/ee/gcc/bin/ee-gcc2953.exe`.
  - The backend tools are located at  `./usr/local/sce/ee/gcc/lib/gcc-lib/ee/2.95.3/`.
  - The binutils tools are located at `./usr/local/sce/ee/gcc/ee/bin/`.

## Installer info

The installer gives the following information during installation:

```plain_text
ProDG for PlayStation2 version 3.0
--------------------------------------------------------

The following software can be installed by this package:

Debugger			v1.76.14.0
Target Manager		v2.32.6.0
EE Compiler (2.95.3)	v1.36
IOP Compiler (2.95.2)	v1.02
Compiler driver		v1.2.2.11
EE Assembler		v1.9.25.758
IOP Assembler		v1.9.25.246
DVP Assembler		v1.9.25.636
Linker			v2.3.7.513
DLL Linker		v1.15.2
VSI (generic)		v1.3.1.73
VSI (PS2 specific)		v1.3.0.54
LibSN			v1.15
snarl			v1.4.9.33

Notes
----------

You will need to have the Sony development libraries already installed 
(in a \usr\local\ directory) to be able to use this software.  If you do not 
have this installed you should exit setup now and install them, then rerun
this setup.

If you have any problems with this software, or the installation, please 
contact: support@snsys.com.

Best regards,
SN Support Team
```

## Other toolchains repos

- [PS2 toolchain: GCC 2.95.2 (SN BUILD v2.73a)](https://github.com/AngheloAlf/SN-Systems-ProDG_for_PS2_2.0)
- [PS2 toolchain: GCC 2.95.3 (SN BUILD v1.36)](https://github.com/AngheloAlf/SN-Systems-ProDG_for_PS2_3.01)
