Papori
======

Installation
============

Install Dart Editor
-------------------

To install Dart Editor, follow instruction at http://www.dartlang.org/docs/editor/getting-started/.

Important : For Ubuntu 64 bits users, open Terminal and execute the following lines :

	wget https://launchpad.net/~jcollins/+archive/jaminppa/+build/1482994/+files/getlibs_2.06-0ubuntu1%7Eppa2_all.deb 
	sudo dpkg -i getlibs_2.06-0ubuntu1~ppa2_all.deb 
	sudo getlibs -p libgconf2-4 
	LD_LIBRARY_PATH=/usr/lib32 
	sudo ldconfig
	

In some cases, you might need to follow additionnal steps (to be tested on a freshly installed Ubuntu) :

- installing ia32/i386 libs
> 	sudo apt-get install ia32-libs
	
- following instructions at http://code.google.com/p/dart/wiki/PreparingYourMachine#Linux.

Directories structure
------------------------------------------------
In the same folder put :

- dart : the workspace directory
	- papori : the papori project
- dart-editor : the dart editor directory
	- ...

Retrieve from git
------------------------------------------------

Open a terminal, and change the current directory to the workspace directory, "dart". Then retrieve it from Github :
> 	git clone https://github.com/Sfeir/papori


Configure your environnement
------------------------------------------------

Set the DART_SDK variable to the dart SDK path (add a line to ~/.pam_environment) :
> 	DART_SDK=~/dart-editor/dart-sdk

Then change the current directory, to the project folder : 
> 	cd ~/dart/papori
And retrieve external packages, using the package manager : 
> 	$DART_SDK/bin/pub install --sdkdir=$DART_SDK

In the dart Editor, set the packages directory : "Tools" > "Preferences" > "Editor" and in "Package directory" browse to ~/dart/papori/packages/

Run the application
------------------------------------------------

First, run the server : right click on PaporiServerRunner.dart file, and select "Run". 
Then open dartium : right click on Papori.html file, and select "Run". Change the url to http://localhost:8080.

Development Tools
=================

Use pub : the Dart Package Manager
------------------------------------------------
Open a terminal, and change the current directory to the papori project directory, ~/dart/papori.
> 	$DART_SDK/bin/pub install --sdkdir=$DART_SDK/dart-sdk/ is in your environnement path

Generate Dart code from Template
------------------------------------------------
Pre-requises :

- having SVN installed
- having dart SDK installed (we assume next that {dart-sdk} folder is where it is installed)

Preparation :

1. Run <code>svn checkout http://dart.googlecode.com/svn/branches/bleeding_edge/dart/utils</code> in the {dart-sdk}/lib folder
2. Make sure that $DART_SDK/bin is in your environnement path
	For Ubuntu user, goto ~/.pam_environment (hidden file) and add the following lines at the end of the file : <code>PATH="$DART_SDK/bin:$PATH"</code>
3. Make sure that $DART_SDK/lib/utils/template is in your environnement path
	For Ubuntu user, goto ~/.pam_environment (hidden file) and add the following lines at the end of the file : <code>PATH="$DART_SDK/lib/utils/template:$PATH"</code>

Compilation :

1. Create a template file with .tmpl extension (i.e. myTemplate.tmpl)
2. With a terminal, go to the folder where the template file is
3. Run the following command : <code>template myTemplate.tmpl</code>
4. The dart file will be generated in the same folder.

Useful link :
* http://blog.sethladd.com/2012/03/first-look-at-darts-html-template.html
* http://blog.sethladd.com/2012/03/dart-templates-now-allow-nesting.html
* http://japhr.blogspot.fr/2012/03/dart-templates-bleeding-edge.html


Useful links :
------------------------------------------------

- Dart API Reference : http://api.dartlang.org/
- A Tour of the Dart Language : http://www.dartlang.org/docs/language-tour/
- Unit testing : http://api.dartlang.org/unittest.html
- Using Dart with JSON Web Services : http://www.dartlang.org/articles/json-web-service/

