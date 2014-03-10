@echo off
color 80
title Mingw Msys Setup
set instdir=%CD%
if not exist "_install" ( 
	echo.
	echo.install dir not found 
	echo.
	goto :EOF
)
set download_dir=_install\download
set tools_dir=_install\tools

::--------------------------------------------------mingw-get
set mingw-get_url=http://sourceforge.net/projects/mingw/files/Installer/mingw-get/mingw-get-0.6.2-beta-20131004-1/mingw-get-0.6.2-mingw32-beta-20131004-1-bin.zip/download
set mingw-get_file=mingw-get-0.6.2-mingw32-beta-20131004-1-bin.zip
if not exist "%download_dir%\%mingw-get_file%" (
    echo.--------------------download mingw-get
    %tools_dir%\curl.exe  -L %mingw-get_url% -o %download_dir%\%mingw-get_file%
)
if not exist "%instdir%\bin\mingw-get.exe" (
    echo.--------------------extract mingw-get
    %tools_dir%\7za.exe -y x %download_dir%\%mingw-get_file% -o%instdir%
)

::--------------------------------------------------msys
if not exist "%instdir%\msys\1.0\msys.bat" (
    %instdir%\bin\mingw-get.exe install msys-base msys-coreutils msys-wget msys-zip msys-unzip
)

::--------------------------------------------------Create all directory (? will export ffmpeg to here)
if not exist %instdir%\export32 (
    echo.--------------------create directory for export32
    mkdir %instdir%\export32
)
if not exist %instdir%\export64 (
    echo.--------------------create directory for export64
    mkdir %instdir%\export64
)

if not exist %instdir%\opt\bin (
    echo.--------------------create directory opt
    mkdir %instdir%\opt
    mkdir %instdir%\opt\bin
    mkdir %instdir%\opt\include
    mkdir %instdir%\opt\lib
    mkdir %instdir%\opt\lib\pkgconfig
    mkdir %instdir%\opt\share
)
if not exist %instdir%\build32 (
    echo.--------------------create directory build32
    mkdir %instdir%\build32
)
if not exist %instdir%\mingw32 (
    echo.--------------------create directory mingw32
    mkdir %instdir%\mingw32
)
if not exist %instdir%\global32\bin (
    echo.--------------------create directory global32
    mkdir %instdir%\global32
    mkdir %instdir%\global32\bin
    mkdir %instdir%\global32\etc
    mkdir %instdir%\global32\include
    mkdir %instdir%\global32\lib
	mkdir %instdir%\global32\lib\pkgconfig
	mkdir %instdir%\global32\share
)
if not exist %instdir%\local32\bin (
    echo.--------------------create directory local32
    mkdir %instdir%\local32
    mkdir %instdir%\local32\bin
    mkdir %instdir%\local32\etc
    mkdir %instdir%\local32\include
    mkdir %instdir%\local32\lib
    mkdir %instdir%\local32\lib\pkgconfig
    mkdir %instdir%\local32\share
)
if not exist %instdir%\build64 (
    echo.--------------------create directory build64
    mkdir %instdir%\build64
)
if not exist %instdir%\mingw64 (
    echo.--------------------create directory mingw64
    mkdir %instdir%\mingw64
)
if not exist %instdir%\global64\bin (
    echo.--------------------create directory global64
	mkdir %instdir%\global64
	mkdir %instdir%\global64\bin
	mkdir %instdir%\global64\etc
	mkdir %instdir%\global64\include
	mkdir %instdir%\global64\lib
	mkdir %instdir%\global64\lib\pkgconfig
	mkdir %instdir%\global64\share
)
if not exist %instdir%\local64\bin (
    echo.--------------------create directory local64
    mkdir %instdir%\local64
    mkdir %instdir%\local64\bin
    mkdir %instdir%\local64\etc
    mkdir %instdir%\local64\include
    mkdir %instdir%\local64\lib
    mkdir %instdir%\local64\lib\pkgconfig
    mkdir %instdir%\local64\share
)

::--------------------------------------------------7za
if not exist "%instdir%\opt\bin\7za.exe" (
    copy %tools_dir%\7za.exe "%instdir%\opt\bin\
)

::--------------------------------------------------mingw-dtk
set mingw-dtk_url=http://blog.pixelcrusher.de/downloads/media-autobuild_suite/mingw-dtk_jb.zip
set mingw-dtk_file=mingw-dtk_jb.zip
if not exist "%download_dir%\%mingw-dtk_file%" (
    echo.--------------------download mingw-dtk
    %tools_dir%\curl.exe  -L %mingw-dtk_url% -o %download_dir%\%mingw-dtk_file%
)
if not exist "%instdir%\bin\msgmerge.exe" (
    %tools_dir%\7za.exe -y x %download_dir%\%mingw-dtk_file% -o%instdir%\var\lib\mingw-get\data
    %instdir%\bin\mingw-get install mingw-developer-toolkit pkginfo
    %instdir%\bin\mingw-get upgrade msys-core-bin=1.0.17-1
)

::--------------------------------------------------msys-auto-tools
set auto_ins=0
if exist "%instdir%\msys\1.0\share\aclocal\pkg.m4" ( set auto_ins=1 )
::::autoconf
if not exist "%download_dir%\autoconf-2.68-1-msys-1.0.17-bin.tar"    (
    echo.--------------------download msys-autoconf
    %tools_dir%\curl.exe -o %download_dir%\autoconf-2.68-1-msys-1.0.17-bin.tar.lzma  -L  http://sourceforge.net/projects/mingw/files/MSYS/msysdev/autoconf/autoconf-2.68-1/autoconf-2.68-1-msys-1.0.17-bin.tar.lzma/download
    %instdir%\msys\1.0\bin\lzma -d %download_dir%\autoconf-2.68-1-msys-1.0.17-bin.tar.lzma
)
if %auto_ins%==0 (
    echo.--------------------install msys-autoconf
    %instdir%\msys\1.0\bin\tar -C msys/1.0 -xf %download_dir%\autoconf-2.68-1-msys-1.0.17-bin.tar
)
::::automake
if not exist "%download_dir%\automake-1.11.1-1-msys-1.0.13-bin.tar"  ( 
    echo.--------------------download msys-automake
    %tools_dir%\curl.exe -o %download_dir%\automake-1.11.1-1-msys-1.0.13-bin.tar.lzma  -L http://sourceforge.net/projects/mingw/files/MSYS/msysdev/automake/automake-1.11.1-1/automake-1.11.1-1-msys-1.0.13-bin.tar.lzma/download 
    %instdir%\msys\1.0\bin\lzma -d %download_dir%\automake-1.11.1-1-msys-1.0.13-bin.tar.lzma
)
if %auto_ins%==0 (
    echo.--------------------install msys-automake
    %instdir%\msys\1.0\bin\tar -C msys/1.0 -xf %download_dir%\automake-1.11.1-1-msys-1.0.13-bin.tar
)
::::libtool
if not exist "%download_dir%\libtool-2.4-1-msys-1.0.15-bin.tar"      (
    echo.--------------------download msys-libtool
    %tools_dir%\curl.exe -o %download_dir%\libtool-2.4-1-msys-1.0.15-bin.tar.lzma  -L http://sourceforge.net/projects/mingw/files/MSYS/msysdev/libtool/libtool-2.4-1/libtool-2.4-1-msys-1.0.15-bin.tar.lzma/download
    %instdir%\msys\1.0\bin\lzma -d %download_dir%\libtool-2.4-1-msys-1.0.15-bin.tar.lzma
)
if %auto_ins%==0 (
    echo.--------------------install msys-libtool
    %instdir%\msys\1.0\bin\tar -C msys/1.0 -xf %download_dir%\libtool-2.4-1-msys-1.0.15-bin.tar
)
::::libcrypt
if not exist "%download_dir%\libcrypt-1.1_1-2-msys-1.0.11-dll-0.tar" (
    echo.--------------------download msys-libcrypt
    %tools_dir%\curl.exe -o %download_dir%\libcrypt-1.1_1-2-msys-1.0.11-dll-0.tar.lzma  -L http://prdownloads.sourceforge.net/mingw/libcrypt-1.1_1-2-msys-1.0.11-dll-0.tar.lzma
    %instdir%\msys\1.0\bin\lzma -d %download_dir%\libcrypt-1.1_1-2-msys-1.0.11-dll-0.tar.lzma
)
if %auto_ins%==0 (
    echo.--------------------install msys-libcrypt
    %instdir%\msys\1.0\bin\tar -C msys/1.0 -xf %download_dir%\libcrypt-1.1_1-2-msys-1.0.11-dll-0.tar
)
::::perl
if not exist "%download_dir%\perl-5.8.8-1-msys-1.0.17-bin.tar"       (
    echo.--------------------download msys-perl
    %tools_dir%\curl.exe -o %download_dir%\perl-5.8.8-1-msys-1.0.17-bin.tar.lzma  -L http://sourceforge.net/projects/mingw/files/MSYS/Extension/perl/perl-5.8.8-1/perl-5.8.8-1-msys-1.0.17-bin.tar.lzma/download 
    %instdir%\msys\1.0\bin\lzma -d %download_dir%\perl-5.8.8-1-msys-1.0.17-bin.tar.lzma
)
if %auto_ins%==0 (
    echo.--------------------install msys-perl
    %instdir%\msys\1.0\bin\tar -C msys/1.0 -xf %download_dir%\perl-5.8.8-1-msys-1.0.17-bin.tar
)
::::m4
if not exist "%download_dir%\m4-1.4.14-1-msys-1.0.13-bin.tar"        (
    echo.--------------------download msys-m4
    %tools_dir%\curl.exe -o %download_dir%\m4-1.4.14-1-msys-1.0.13-bin.tar.lzma  -L http://sourceforge.net/projects/mingw/files/MSYS/Extension/m4/m4-1.4.14-1/m4-1.4.14-1-msys-1.0.13-bin.tar.lzma/download 
    %instdir%\msys\1.0\bin\lzma -d %download_dir%\m4-1.4.14-1-msys-1.0.13-bin.tar.lzma
)
if %auto_ins%==0 (
    echo.--------------------install msys-m4
    %instdir%\msys\1.0\bin\tar -C msys/1.0 -xf %download_dir%\m4-1.4.14-1-msys-1.0.13-bin.tar
)
::::glib
if not exist "%download_dir%\glib_2.28.8-1_win32.zip"                (
    echo.--------------------download msys-glib
    %tools_dir%\curl.exe -o %download_dir%\glib_2.28.8-1_win32.zip  -L http://ftp.acc.umu.se/pub/GNOME/binaries/win32/glib/2.28/glib_2.28.8-1_win32.zip
)
if %auto_ins%==0 (
    echo.--------------------install msys-glib
    %instdir%\msys\1.0\bin\unzip -n -d %instdir%\msys\1.0 %download_dir%\glib_2.28.8-1_win32.zip
)
::::pkg-config
if not exist "%download_dir%\pkg-config_0.23-3_win32.zip"            (
    echo.--------------------download msys-pkg-config
    %tools_dir%\curl.exe -o %download_dir%\pkg-config_0.23-3_win32.zip  -L ftp://ftp.gnome.org/pub/gnome/binaries/win32/dependencies/pkg-config_0.23-3_win32.zip 
)
if %auto_ins%==0 (
    echo.--------------------install msys-pkg-config
    %instdir%\msys\1.0\bin\unzip -n -d %instdir%\msys\1.0 %download_dir%\pkg-config_0.23-3_win32.zip
)
::::gettext-runtime
if not exist "%download_dir%\gettext-runtime_0.18.1.1-2_win32.zip"   (
    echo.--------------------download msys-gettext-runtime
    %tools_dir%\curl.exe -o %download_dir%\gettext-runtime_0.18.1.1-2_win32.zip  -L http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies/gettext-runtime_0.18.1.1-2_win32.zip
)
if %auto_ins%==0 (
    echo.--------------------install msys-gettext-runtime
    %instdir%\msys\1.0\bin\unzip -n -d %instdir%\msys\1.0 %download_dir%\gettext-runtime_0.18.1.1-2_win32.zip
)
::::pkg-config-dev
if not exist "%download_dir%\pkg-config-dev_0.23-3_win32.zip"        (
    echo.--------------------download msys-pkg-config-dev
    %tools_dir%\curl.exe -o %download_dir%\pkg-config-dev_0.23-3_win32.zip  -L ftp://ftp.gnome.org/pub/gnome/binaries/win32/dependencies/pkg-config-dev_0.23-3_win32.zip 
)
if %auto_ins%==0 (
    echo.--------------------install msys-pkg-config-dev
    %instdir%\msys\1.0\bin\unzip -n -d %instdir%\msys\1.0 %download_dir%\pkg-config-dev_0.23-3_win32.zip
)
::--------------------------------------------------mingw32
if not exist "%download_dir%\i686-4.8.2-release-win32-sjlj-rt_v3-rev2.7z"        (
    echo.--------------------download mingw32
    %instdir%\msys\1.0\bin\wget.exe -O %download_dir%\i686-4.8.2-release-win32-sjlj-rt_v3-rev2.7z -c --no-check-certificate "http://downloads.sourceforge.net/project/mingw-w64/Toolchains targetting Win32/Personal Builds/mingw-builds/4.8.2/threads-win32/sjlj/i686-4.8.2-release-win32-sjlj-rt_v3-rev2.7z"
)
if not exist "%instdir%\mingw32\bin\cc.exe"        (
    echo.--------------------install mingw32
    %tools_dir%\7za.exe -y x %download_dir%\i686-4.8.2-release-win32-sjlj-rt_v3-rev2.7z -o%instdir%
    copy /Y %instdir%\mingw32\bin\gcc.exe %instdir%\mingw32\bin\cc.exe
	FOR /R "%instdir%\mingw32" %%C IN (*.dll.a) DO (
		%instdir%\msys\1.0\bin\mv  %%C %%C.dyn
	)
	if not exist "%instdir%\mingw32\bin\cc.exe" (
    	echo.
    	echo.download from compiler mingw32 fail...
    	echo.try again or fix download
    	echo.
    	goto :EOF
	)
)
::--------------------------------------------------mingw64
if not exist "%download_dir%\x86_64-4.8.2-release-win32-sjlj-rt_v3-rev2.7z"        (
    echo.--------------------download mingw64
    %instdir%\msys\1.0\bin\wget.exe -O %download_dir%\x86_64-4.8.2-release-win32-sjlj-rt_v3-rev2.7z -c --no-check-certificate "http://downloads.sourceforge.net/project/mingw-w64/Toolchains targetting Win64/Personal Builds/mingw-builds/4.8.2/threads-win32/sjlj/x86_64-4.8.2-release-win32-sjlj-rt_v3-rev2.7z"
)
if not exist "%instdir%\mingw64\bin\cc.exe"        (
    echo.--------------------install mingw64
    %tools_dir%\7za.exe -y x %download_dir%\x86_64-4.8.2-release-win32-sjlj-rt_v3-rev2.7z -o%instdir%
    copy /Y %instdir%\mingw64\bin\gcc.exe %instdir%\mingw64\bin\cc.exe
    FOR /R "%instdir%\mingw64" %%C IN (*.dll.a) DO (
        %instdir%\msys\1.0\bin\mv  %%C %%C.dyn
    )
    if not exist "%instdir%\mingw64\bin\cc.exe" (
        echo.
        echo.download from compiler mingw64 fail...
        echo.try again or fix download
        echo.
        goto :EOF
    )
)
::--------------------------------------------------tools
::::git
if not exist "%download_dir%\PortableGit-1.8.3-preview20130601.7z"        (
    echo.--------------------download git
    %instdir%\msys\1.0\bin\wget.exe -O %download_dir%\PortableGit-1.8.3-preview20130601.7z -c  "http://msysgit.googlecode.com/files/PortableGit-1.8.3-preview20130601.7z"
)
if not exist "%instdir%\opt\bin\git.exe"    (
    echo.--------------------install git
    %tools_dir%\7za.exe -y x %download_dir%\PortableGit-1.8.3-preview20130601.7z -o%instdir%\opt
    del "%instdir%\opt\git-bash.bat"
    del "%instdir%\opt\git-cmd.bat"
    del "%instdir%\opt\ReleaseNotes.rtf"
    del "%instdir%\opt\Git Bash.vbs"
    del "%instdir%\opt\README.portable"
)
::::svn
if not exist "%download_dir%\svn-win32-1.8.3.zip"        (
    echo.--------------------download svn
    %instdir%\msys\1.0\bin\wget.exe -O %download_dir%\svn-win32-1.8.3.zip -c  "http://downloads.sourceforge.net/project/win32svn/1.8.3/apache22/svn-win32-1.8.3.zip"
)
if not exist "%instdir%\opt\bin\svn.exe"    (
    echo.--------------------install svn
    %instdir%\msys\1.0\bin\unzip -n -d %instdir%\opt %download_dir%\svn-win32-1.8.3.zip
    cd %instdir%\opt
    %instdir%\msys\1.0\bin\cp -va svn-win32-1.8.3/* .
    %instdir%\msys\1.0\bin\rm -r svn-win32-1.8.3
    %instdir%\msys\1.0\bin\mv README.txt doc\svn-win32-1.8.3
    cd ..
)
::::cmake
if not exist "%download_dir%\cmake-2.8.11.1-win32-x86.zip"        (
    echo.--------------------download cmake
    %instdir%\msys\1.0\bin\wget.exe -O %download_dir%\cmake-2.8.11.1-win32-x86.zip -c  "http://www.cmake.org/files/v2.8/cmake-2.8.11.1-win32-x86.zip"
)
if not exist "%instdir%\opt\bin\cmake.exe"    (
    echo.--------------------install cmake
    %instdir%\msys\1.0\bin\unzip -n -d %instdir%\opt %download_dir%\cmake-2.8.11.1-win32-x86.zip
    cd %instdir%\opt
	%instdir%\msys\1.0\bin\cp -va cmake-2.8.11.1-win32-x86/* .
	%instdir%\msys\1.0\bin\rm -r cmake-2.8.11.1-win32-x86
    cd ..
)
::::hg
if not exist "%download_dir%\tortoisehg-2.4.1-hg-2.2.2-x86.msi"        (
    echo.--------------------download hg
    %instdir%\msys\1.0\bin\wget.exe -O %download_dir%\tortoisehg-2.4.1-hg-2.2.2-x86.msi --no-check-certificate -c "https://bitbucket.org/tortoisehg/thg/downloads/tortoisehg-2.4.1-hg-2.2.2-x86.msi"
)
if not exist "%instdir%\opt\TortoiseHg\hg.exe"    (
    echo.--------------------install hg
    msiexec /a %download_dir%\tortoisehg-2.4.1-hg-2.2.2-x86.msi /qb TARGETDIR=%instdir%\opt\hg-temp
    cd %instdir%\opt
	%instdir%\msys\1.0\bin\cp -va %instdir%\opt\hg-temp\PFiles\TortoiseHg %instdir%\opt
	%instdir%\msys\1.0\bin\rm -r -f %instdir%\opt\hg-temp
    cd ..
)
::::doxygen32
if not exist "%download_dir%\doxygen-1.8.5.windows.bin.zip"        (
    echo.--------------------download doxygen32
    %instdir%\msys\1.0\bin\wget.exe -O %download_dir%\doxygen-1.8.5.windows.bin.zip "http://ftp.stack.nl/pub/users/dimitri/doxygen-1.8.5.windows.bin.zip"
)
if not exist "%instdir%\mingw32\bin\doxygen.exe"    (
    echo.--------------------install doxygen32
    %instdir%\msys\1.0\bin\unzip -n -d %instdir%\mingw32\bin %download_dir%\doxygen-1.8.5.windows.bin.zip
)
::::doxygen64
if not exist "%download_dir%\doxygen-1.8.5.windows.x64.bin.zip"        (
    echo.--------------------download doxygen64
    %instdir%\msys\1.0\bin\wget.exe -O %download_dir%\doxygen-1.8.5.windows.x64.bin.zip "http://ftp.stack.nl/pub/users/dimitri/doxygen-1.8.5.windows.x64.bin.zip"
)
if not exist "%instdir%\mingw64\bin\doxygen.exe"    (
    echo.--------------------install doxygen64
    %instdir%\msys\1.0\bin\unzip -n -d %instdir%\mingw64\bin %download_dir%\doxygen-1.8.5.windows.x64.bin.zip
)
::::yasm32
if not exist "%download_dir%\yasm-1.2.0-win32.exe"        (
    echo.--------------------download yasm32
    %instdir%\msys\1.0\bin\wget.exe -O %download_dir%\yasm-1.2.0-win32.exe "http://www.tortall.net/projects/yasm/releases/yasm-1.2.0-win32.exe"
)
if not exist "%instdir%\mingw32\bin\yasm.exe"    (
    echo.--------------------install yasm32
    copy %download_dir%\yasm-1.2.0-win32.exe %instdir%\mingw32\bin\yasm.exe
)
::::yasm64
if not exist "%download_dir%\yasm-1.2.0-win64.exe"        (
    echo.--------------------download yasm64
    %instdir%\msys\1.0\bin\wget.exe -O %download_dir%\yasm-1.2.0-win64.exe "http://www.tortall.net/projects/yasm/releases/yasm-1.2.0-win32.exe"
)
if not exist "%instdir%\mingw64\bin\yasm.exe"    (
    echo.--------------------install yasm64
    copy %download_dir%\yasm-1.2.0-win64.exe %instdir%\mingw64\bin\yasm.exe
)
::::minity
if not exist "%download_dir%\mintty-1.1.3-msys.zip"        (
    echo.--------------------download minity
    %instdir%\msys\1.0\bin\wget.exe -O %download_dir%\mintty-1.1.3-msys.zip http://blog.pixelcrusher.de/downloads/media-autobuild_suite/mintty-1.1.3-msys.zip
)
if not exist "%instdir%\msys\1.0\bin\mintty.exe"    (
    echo.--------------------install minity
    %instdir%\msys\1.0\bin\unzip -n -d %instdir%\msys\1.0\bin %download_dir%\mintty-1.1.3-msys.zip
)
::--------------------------------------------------configs
::::profile32
if not exist %instdir%\global32\etc\profile.local (
	echo.--------------------install profile32
	echo.#>>%instdir%\global32\etc\profile.local
	echo.# /global32/etc/profile.local>>%instdir%\global32\etc\profile.local
	echo.#>>%instdir%\global32\etc\profile.local
	echo.>>%instdir%\global32\etc\profile.local
	echo.alias dir='ls -la --color=auto'>>%instdir%\global32\etc\profile.local
	echo.alias ls='ls --color=auto'>>%instdir%\global32\etc\profile.local
	echo.>>%instdir%\global32\etc\profile.local
    echo.PKG_CONFIG="/global32/bin/pkg-config.sh">>%instdir%\global32\etc\profile.local
	echo.PKG_CONFIG_PATH="/local32/lib/pkgconfig">>%instdir%\global32\etc\profile.local
	echo.CPPFLAGS="-I/global32/include -I/local32/include">>%instdir%\global32\etc\profile.local
	echo.CFLAGS="-I/global32/include -I/local32/include -mms-bitfields -mthreads -mtune=pentium3">>%instdir%\global32\etc\profile.local
	echo.CXXFLAGS="-I/global32/include -I/local32/include -mms-bitfields -mthreads -mtune=pentium3">>%instdir%\global32\etc\profile.local
	echo.LDFLAGS="-L/global32/lib -L/local32/lib -mthreads">>%instdir%\global32\etc\profile.local
	echo.export PKG_CONFIG PKG_CONFIG_PATH CPPFLAGS CFLAGS CXXFLAGS LDFLAGS>>%instdir%\global32\etc\profile.local
	echo.>>%instdir%\global32\etc\profile.local
	echo.PATH=".:/global32/bin:/local32/bin:/mingw32/bin:/mingw/bin:/bin:/opt/bin:/opt/TortoiseHg">>%instdir%\global32\etc\profile.local
	echo.PS1='\[\033[32m\]\u@\h \[\033[33m\w\033[0m\]$ '>>%instdir%\global32\etc\profile.local
	echo.export PATH PS1>>%instdir%\global32\etc\profile.local
	echo.>>%instdir%\global32\etc\profile.local
	echo.# package build directory>>%instdir%\global32\etc\profile.local
	echo.BUILDDIR=/build32>>%instdir%\global32\etc\profile.local
	echo.# package installation prefix>>%instdir%\global32\etc\profile.local
	echo.GLOBALDIR=/global32>>%instdir%\global32\etc\profile.local
	echo.LOCALDIR=/local32>>%instdir%\global32\etc\profile.local
    echo.EXPORTDIR=/export32>>%instdir%\global32\etc\profile.local
	echo.export BUILDDIR GLOBALDIR LOCALDIR>>%instdir%\global32\etc\profile.local
)
::::profile64
if not exist %instdir%\global64\etc\profile.local (
    echo.--------------------install profile64
    echo.#>>%instdir%\global64\etc\profile.local
    echo.# /global64/etc/profile.local>>%instdir%\global64\etc\profile.local
    echo.#>>%instdir%\global64\etc\profile.local
    echo.>>%instdir%\global64\etc\profile.local
    echo.alias dir='ls -la --color=auto'>>%instdir%\global64\etc\profile.local
    echo.alias ls='ls --color=auto'>>%instdir%\global64\etc\profile.local
    echo.>>%instdir%\global64\etc\profile.local
    echo.PKG_CONFIG="/global64/bin/pkg-config.sh">>%instdir%\global64\etc\profile.local
    echo.PKG_CONFIG_PATH="/local64/lib/pkgconfig">>%instdir%\global64\etc\profile.local
    echo.CPPFLAGS="-I/global64/include -I/local64/include">>%instdir%\global64\etc\profile.local
    echo.CFLAGS="-I/global64/include -I/local64/include -mms-bitfields -mthreads">>%instdir%\global64\etc\profile.local
    echo.CXXFLAGS="-I/global64/include -I/local64/include -mms-bitfields -mthreads">>%instdir%\global64\etc\profile.local
    echo.LDFLAGS="-L/global64/lib -L/local64/lib">>%instdir%\global64\etc\profile.local
    echo.export PKG_CONFIG PKG_CONFIG_PATH CPPFLAGS CFLAGS CXXFLAGS LDFLAGS>>%instdir%\global64\etc\profile.local
    echo.>>%instdir%\global64\etc\profile.local
    echo.PATH=".:/global64/bin:/local64/bin:/mingw64/bin:/mingw/bin:/bin:/opt/bin:/opt/TortoiseHg">>%instdir%\global64\etc\profile.local
    echo.PS1='\[\033[32m\]\u@\h \[\033[33m\w\033[0m\]$ '>>%instdir%\global64\etc\profile.local
    echo.export PATH PS1>>%instdir%\global64\etc\profile.local
    echo.>>%instdir%\global64\etc\profile.local
    echo.# package build directory>>%instdir%\global64\etc\profile.local
    echo.BUILDDIR=/build64>>%instdir%\global64\etc\profile.local
    echo.# package installation prefix>>%instdir%\global64\etc\profile.local
    echo.GLOBALDIR=/global64>>%instdir%\global64\etc\profile.local
    echo.LOCALDIR=/local64>>%instdir%\global64\etc\profile.local
    echo.EXPORTDIR=/export64>>%instdir%\global64\etc\profile.local
    echo.export BUILDDIR GLOBALDIR LOCALDIR>>%instdir%\global64\etc\profile.local
)
::::fstab
if not exist %instdir%\msys\1.0\etc\fstab.cfg (
    echo.--------------------install fstab
    echo %instdir%             /mingw>>%instdir%\msys\1.0\etc\fstab.cfg
	echo %instdir%\opt         /opt>>%instdir%\msys\1.0\etc\fstab.cfg
	echo %instdir%\global32    /global32>>%instdir%\msys\1.0\etc\fstab.cfg
	echo %instdir%\local32     /local32>>%instdir%\msys\1.0\etc\fstab.cfg
	echo %instdir%\build32     /build32>>%instdir%\msys\1.0\etc\fstab.cfg
	echo %instdir%\mingw32     /mingw32>>%instdir%\msys\1.0\etc\fstab.cfg
	echo %instdir%\global64    /global64>>%instdir%\msys\1.0\etc\fstab.cfg
	echo %instdir%\local64     /local64>>%instdir%\msys\1.0\etc\fstab.cfg
	echo %instdir%\build64     /build64>>%instdir%\msys\1.0\etc\fstab.cfg
    echo %instdir%\export64    /export64>>%instdir%\msys\1.0\etc\fstab.cfg
    echo %instdir%\export32    /export32>>%instdir%\msys\1.0\etc\fstab.cfg
	echo %instdir%\mingw64     /mingw64>>%instdir%\msys\1.0\etc\fstab.cfg
    copy /Y %instdir%\msys\1.0\etc\fstab.cfg %instdir%\msys\1.0\etc\fstab
)
::::profile
if not exist %instdir%\msys\1.0\etc\profile_cfg.sh (
    echo.--------------------install profile
    echo.grep -q -e '/global32/etc/profile.local' /etc/profile ^|^| sed -i '/cd "$HOME"/ a\if [[ $SYSBITS -eq 32 ]]; then  \>>%instdir%\msys\1.0\etc\profile_cfg.sh
    echo.    if [ -f /global32/etc/profile.local ]; then \>>%instdir%\msys\1.0\etc\profile_cfg.sh
    echo.           source /global32/etc/profile.local \>>%instdir%\msys\1.0\etc\profile_cfg.sh
    echo.    fi \>>%instdir%\msys\1.0\etc\profile_cfg.sh
    echo.else \>>%instdir%\msys\1.0\etc\profile_cfg.sh
    echo.    if [ -f /global64/etc/profile.local ]; then \>>%instdir%\msys\1.0\etc\profile_cfg.sh
    echo.           source /global64/etc/profile.local \>>%instdir%\msys\1.0\etc\profile_cfg.sh
    echo.    fi \>>%instdir%\msys\1.0\etc\profile_cfg.sh
    echo.fi \>>%instdir%\msys\1.0\etc\profile_cfg.sh
    echo.' /etc/profile>>%instdir%\msys\1.0\etc\profile_cfg.sh
    %instdir%\msys\1.0\bin\sh -l /etc/profile_cfg.sh
)
::::mintty seetings, color, transparency, etc.
for /f %%i in ('dir %instdir%\msys\1.0\home /B') do ( 
    set userFolder=%%i
    if not exist %instdir%\msys\1.0\home\%userFolder%\.minttyrc (
        echo.--------------------install mintty settings in /home/%userFolder%
    	echo.BoldAsFont=no>>%instdir%\msys\1.0\home\%userFolder%\.minttyrc
    	echo.BackgroundColour=57,57,57>>%instdir%\msys\1.0\home\%userFolder%\.minttyrc
    	echo.ForegroundColour=221,221,221>>%instdir%\msys\1.0\home\%userFolder%\.minttyrc
    	echo.Transparency=medium>>%instdir%\msys\1.0\home\%userFolder%\.minttyrc
    	echo.FontHeight=^9>>%instdir%\msys\1.0\home\%userFolder%\.minttyrc
    	echo.FontSmoothing=full>>%instdir%\msys\1.0\home\%userFolder%\.minttyrc
    	echo.AllowBlinking=yes>>%instdir%\msys\1.0\home\%userFolder%\.minttyrc
    	echo.Font=DejaVu Sans Mono>>%instdir%\msys\1.0\home\%userFolder%\.minttyrc
    	echo.Columns=90>>%instdir%\msys\1.0\home\%userFolder%\.minttyrc
    	echo.Rows=30>>%instdir%\msys\1.0\home\%userFolder%\.minttyrc
    	echo.Locale=de_DE>>%instdir%\msys\1.0\home\%userFolder%\.minttyrc
    	echo.Charset=ISO-8859-1>>%instdir%\msys\1.0\home\%userFolder%\.minttyrc
    	echo.Term=xterm-256color>>%instdir%\msys\1.0\home\%userFolder%\.minttyrc
    	echo.CursorType=block>>%instdir%\msys\1.0\home\%userFolder%\.minttyrc
    	echo.Black=38,39,41>>%instdir%\msys\1.0\home\%userFolder%\.minttyrc
    	echo.Red=249,38,113>>%instdir%\msys\1.0\home\%userFolder%\.minttyrc
    	echo.Green=166,226,46>>%instdir%\msys\1.0\home\%userFolder%\.minttyrc
    	echo.Yellow=253,151,31>>%instdir%\msys\1.0\home\%userFolder%\.minttyrc
    	echo.Blue=102,217,239>>%instdir%\msys\1.0\home\%userFolder%\.minttyrc
    	echo.Magenta=158,111,254>>%instdir%\msys\1.0\home\%userFolder%\.minttyrc
    	echo.Cyan=94,113,117>>%instdir%\msys\1.0\home\%userFolder%\.minttyrc
    	echo.White=248,248,242>>%instdir%\msys\1.0\home\%userFolder%\.minttyrc
    	echo.BoldBlack=85,68,68>>%instdir%\msys\1.0\home\%userFolder%\.minttyrc
    	echo.BoldRed=249,38,113>>%instdir%\msys\1.0\home\%userFolder%\.minttyrc
    	echo.BoldGreen=166,226,46>>%instdir%\msys\1.0\home\%userFolder%\.minttyrc
    	echo.BoldYellow=253,151,31>>%instdir%\msys\1.0\home\%userFolder%\.minttyrc
    	echo.BoldBlue=102,217,239>>%instdir%\msys\1.0\home\%userFolder%\.minttyrc
    	echo.BoldMagenta=158,111,254>>%instdir%\msys\1.0\home\%userFolder%\.minttyrc
    	echo.BoldCyan=163,186,191>>%instdir%\msys\1.0\home\%userFolder%\.minttyrc
    	echo.BoldWhite=248,248,242>>%instdir%\msys\1.0\home\%userFolder%\.minttyrc
    )
)

::::mintty32
if not exist %instdir%\mintty32.bat (
	echo set SYSBITS=32>%instdir%\mintty32.bat
    echo start %instdir%\msys\1.0\bin\mintty /bin/bash -l >>%instdir%\mintty32.bat
)
::::mintty64
if not exist %instdir%\mintty64.bat (
	echo set SYSBITS=64>%instdir%\mintty64.bat
    echo start %instdir%\msys\1.0\bin\mintty /bin/bash -l >>%instdir%\mintty64.bat
)

echo.
echo All done , Window close in 5s
echo.
ping 127.0.0.0 -n 5 >nul
echo.
goto :EOF
