mingw-ffmpeg
============

mingw32 &amp; mingw64 env setup and  build the latest ffmpeg use mingw

How to
--------
- clone or download form github https://github.com/thinkanyforever/mingw-ffmpeg
- run install\_msys\_mingw.bat to setup mingw+msys,then you will get mintty32.bat or mitty64.bat
- run mintty32.bat or mitty64.bat
- cd /mingw
- gen --install=1
- see your local32/local64 & global32/global64 directory
- you will get ffmpeg .dll library, if you need .a then look at \_install/script/video\_git_ffmpeg

Default ffmpeg config
--------
- --enable-postproc
- --enable-w32threads
- --enable-runtime-cpudetect
- --enable-memalign-hack
- --disable-static
- --enable-shared
- --enable-avfilter
- --enable-bzlib
- --enable-zlib
- --enable-librtmp
- --enable-gnutls
- --enable-avisynth
- --enable-frei0r
- --enable-filter=frei0r
- --enable-libbluray
- --enable-libcaca
- --enable-libopenjpeg
- --enable-fontconfig
- --enable-libfreetype
- --enable-libass
- --enable-libgsm
- --enable-libmodplug
- --enable-libmp3lame
- --enable-libopencore-amrnb
- --enable-libopencore-amrwb
- --enable-libvo-amrwbenc
- --enable-libschroedinger
- --enable-libsoxr
- --enable-libtwolame
- --enable-libutvideo
- --enable-libspeex
- --enable-libtheora
- --enable-libvorbis
- --enable-libvo-aacenc
- --enable-libopus
- --enable-libvidstab
- --enable-libvpx
- --enable-libxavs
- --enable-libx264
- --enable-libxvid
- --enable-libzvbi

More
-------- 
- open file gen to see how to use step by step
- create new script in _install/script directory
- test on win7 x64 only

References & Thanks to
--------
- https://github.com/rdp/ffmpeg-windows-build-helpers
- https://github.com/nu774/fdkaac_autobuild
- https://github.com/jb-alvarado/media-autobuild_suite

? Questing
-------- 
- 86287344@qq.com
