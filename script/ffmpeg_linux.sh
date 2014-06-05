#!/bin/sh

sudo yum install autoconf automake gcc gcc-c++ git libtool make nasm pkgconfig zlib-devel

#Yasm
cd ~/ffmpeg_sources
curl -O http://www.tortall.net/projects/yasm/releases/yasm-1.2.0.tar.gz
tar xzvf yasm-1.2.0.tar.gz
cd yasm-1.2.0
./configure --prefix="$HOME/ffmpeg_build" --bindir="$HOME/bin"
make
make install
make distclean
export "PATH=$PATH:$HOME/bin"


#libx264
cd ~/ffmpeg_sources
git clone --depth 1 git://git.videolan.org/x264
cd x264
./configure --prefix="$HOME/ffmpeg_build" --bindir="$HOME/bin" --enable-static
make
make install
make distclean

#libfaac -- TODO


#libmp3lame
cd ~/ffmpeg_sources
curl -L -O http://downloads.sourceforge.net/project/lame/lame/3.99/lame-3.99.5.tar.gz
tar xzvf lame-3.99.5.tar.gz
cd lame-3.99.5
#./configure --prefix="$HOME/ffmpeg_build" --bindir="$HOME/bin" --disable-shared --enable-nasm
#MUST not disable shared to make sox happy
./configure --prefix="$HOME/ffmpeg_build" --bindir="$HOME/bin" --enable-nasm
make
make install
make distclean

#libvpx
cd ~/ffmpeg_sources
git clone --depth 1 https://chromium.googlesource.com/webm/libvpx.git
cd libvpx
./configure --prefix="$HOME/ffmpeg_build" --disable-examples
make
make install
make clean


#libfaad2
cd ~/ffmpeg_sources
export TMPDIR=~/tmp
#http://sourceforge.net/projects/faac/files/faad2-src/faad2-2.7/faad2-2.7.tar.bz2
wget http://downloads.sourceforge.net/project/faac/faad2-src/faad2-2.7/faad2-2.7.tar.bz2
tar xjvf faad2-2.7.tar.bz2
cd faad2-2.7
autoreconf -vif
./configure --with-mp4v2 --prefix="$HOME/ffmpeg_build"
make
make install

#libfaac http://www.linuxfromscratch.org/blfs/view/svn/multimedia/faac.html
#http://stackoverflow.com/questions/4320226/installing-faac-on-linux-getting-errors
#http://blog.showmedo.com/news/compiling-faad-libfaad-on-redhat/
#http://sourceforge.net/projects/faac/files/faac-src/faac-1.28/faac-1.28.tar.bz2/download
wget http://downloads.sourceforge.net/project/faac/faac-src/faac-1.28/faac-1.28.tar.bz2
wget http://www.linuxfromscratch.org/patches/blfs/svn/faac-1.28-glibc_fixes-1.patch
tar xjvf faac-1.28.tar.bz2
cd faac-1.28
#autoreconf -vif
./configure --prefix="$HOME/ffmpeg_build" --disable-static
make
make install

#mad
#http://techblog.netwater.com/?p=4
#libmad
#http://www.linuxfromscratch.org/blfs/view/cvs/multimedia/libmad.html
#http://stackoverflow.com/questions/14015747/gccs-fforce-mem-option
#http://www.linuxquestions.org/questions/linux-software-2/getting-make-***-%5Ball%5D-error-2-during-make-command-for-libmad-0-15-1b-743580/
http://downloads.sourceforge.net/project/mad/libmad/0.15.1b/libmad-0.15.1b.tar.gz
./configure --prefix="$HOME/ffmpeg_build"

#libid3tag
http://downloads.sourceforge.net/project/mad/libid3tag/0.15.1b/libid3tag-0.15.1b.tar.gz

#madplay
http://downloads.sourceforge.net/project/mad/madplay/0.15.2b/madplay-0.15.2b.tar.gz
./configure CPPFLAGS="-I$HOME/ffmpeg_build/include" LDFLAGS="-L$HOME/ffmpeg_build/lib" --prefix="$HOME/ffmpeg_build" --bindir="$HOME/bin"

#sox
autoreconf -i
#./configure --prefix="$HOME/ffmpeg_build"
#http://marc.info/?l=sox-devel&m=135044064131441&w=2
./configure CPPFLAGS="-I$HOME/ffmpeg_build/include" LDFLAGS="-L$HOME/ffmpeg_build/lib" --prefix="$HOME/ffmpeg_build" --bindir="$HOME/bin" --enable-dl-lame

#ffmpeg
cd ~/ffmpeg_sources
#git clone --depth 1 git://source.ffmpeg.org/ffmpeg
wget http://ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2
tar xjvf ffmpeg-snapshot.tar.bz2
cd ffmpeg
PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig"
export PKG_CONFIG_PATH
#./configure --prefix="$HOME/ffmpeg_build" --extra-cflags="-I$HOME/ffmpeg_build/include" --extra-ldflags="-L$HOME/ffmpeg_build/lib" --bindir="$HOME/bin" --extra-libs=-ldl --enable-gpl --enable-nonfree --enable-libfaac --enable-libmp3lame --enable-libvpx --enable-libx264
./configure --prefix="$HOME/ffmpeg_build" --extra-cflags="-I$HOME/ffmpeg_build/include" --extra-ldflags="-L$HOME/ffmpeg_build/lib" --bindir="$HOME/bin" --extra-libs=-ldl --enable-static --disable-shared --disable-ffserver --disable-doc --enable-gpl --enable-nonfree --enable-libfaac --enable-libmp3lame --enable-libvpx --enable-libx264
#--prefix=/root/ffmpeg-static/64bit --extra-cflags='-I/root/ffmpeg-static/64bit/include -static' --extra-ldflags='-L/root/ffmpeg-static/64bit/lib -static' --extra-libs='-lxml2 -lexpat -lfreetype' --enable-static --disable-shared --disable-ffserver --disable-doc --enable-bzlib --enable-zlib --enable-postproc --enable-runtime-cpudetect --enable-libx264 --enable-gpl --enable-libtheora --enable-libvorbis --enable-libmp3lame --enable-gray --enable-libass --enable-libfreetype --enable-libopenjpeg --enable-libspeex --enable-libvo-aacenc --enable-libvo-amrwbenc --enable-version3 --enable-libvpx
make

make install
make distclean
hash -r
. ~/.bash_profile
