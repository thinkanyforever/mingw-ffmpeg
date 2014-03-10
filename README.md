mingw-ffmpeg
============

mingw32 &amp; mingw64 env setup and  build the latest ffmpeg use mingw

How to
--------
- clone or download form github https://github.com/thinkanyforever/mingw-ffmpeg
- run install_msys_mingw.bat to setup mingw+msys,then you will get mintty32.bat or mitty64.bat
- run mintty32.bat or mitty64.bat
- cd /mingw
- gen --install=1
- see your local32/local64 & global32/global64 directory
- you will get ffmpeg .dll library, if you need .a then look at _install/script/video_git_ffmpeg
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
