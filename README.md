Papori
======

Install Dart Editor
------------------------------------------------

To install Dart Editor, follow instruction at http://www.dartlang.org/docs/editor/getting-started/.

Important : For Ubuntu 64 bits users, open Terminal and execute the following lines :

	wget https://launchpad.net/~jcollins/+archive/jaminppa/+build/1482994/+files/getlibs_2.06-0ubuntu1%7Eppa2_all.deb 
	sudo dpkg -i getlibs_2.06-0ubuntu1~ppa2_all.deb 
	sudo getlibs -p libgconf2-4 
	LD_LIBRARY_PATH=/usr/lib32 
	sudo ldconfig
	

In some cases, you might need to follow additionnal steps (to be tested on a freshly installed Ubuntu) :

- installing ia32/i386 libs

	sudo apt-get install ia32-libs
- following instructions at http://code.google.com/p/dart/wiki/PreparingYourMachine#Linux.
