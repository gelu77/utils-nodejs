#!/bin/sh
#Created by colin on 6/10/14

cd ~
mkdir gm_sources

#support png
sudo yum install libpng-devel libpng
sudo ldconfig /usr/local/lib

#support jpg
cd ~/gm_sources
wget http://www.ece.uvic.ca/~frodo/jasper/software/jasper-1.900.1.zip
unzip jasper-1.900.1.zip
cd jasper-1.900.1 && ./configure
make && sudo make install

cd ~/gm_sources
wget  http://www.ijg.org/files/jpegsrc.v9a.tar.gz
tar -xzvf jpegsrc.v9a.tar.gz
cd jpeg-9a && ./configure
make && sudo make install

#GraphicsMagick
cd ~/gm_sources
wget http://downloads.sourceforge.net/project/graphicsmagick/graphicsmagick/1.3.19/GraphicsMagick-1.3.19.tar.bz2
tar -xjvf GraphicsMagick-1.3.19.tar.bz2
cd GraphicsMagick-1.3.19 && ./configure
make && sudo make install
