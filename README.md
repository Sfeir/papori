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

Set the DART_SDK variable to the dart SDK path :
> 	DART_SDK=~/dart-editor/dart-sdk

In the dart Editor, set the package directory : "Tools" > "Preferences" > "Editor" and in "Package directory" browse to ~/dart/papori/packages

Run the application
------------------------------------------------

Right click on PaporiServerRunner.dart file, and select "Run". Open dartium on http://localhost:8080.

Development Tools
=================

Generate Dart code from Template
------------------------------------------------
Pre-requises :

- having SVN installed
- having dart SDK installed (we assume next that {dart-sdk} folder is where it is installed)

Preparation :

1. Run <code>svn checkout http://dart.googlecode.com/svn/branches/bleeding_edge/dart/utils</code> in the {dart-sdk}/lib folder
2. Make sure that {dart-sdk}/bin is in your environnement path
	For Ubuntu user, goto ~/Home/.profile (hidden file) end add the following lines at the end of the file : <code>PATH="$PATH:$HOME/Work/tools/dart-editor/dart-sdk/bin"</code>
3. Make sure that {dart-sdk}/lib/utils/template is in your environnement path
	For Ubuntu user, goto ~/Home/.profile (hidden file) end add the following lines at the end of the file : <code>PATH="$PATH:$HOME/Work/tools/dart-editor/dart-sdk/lib/utils/template"</code>

Compilation :

1. Create a template file with .tmpl extension (i.e. myTemplate.tmpl)
2. With a terminal, go to the folder where the template file is
3. Run the following command : <code>template myTemplate.tmpl</code>
4. The dart file will be generated in the same folder.

Useful link :
* http://blog.sethladd.com/2012/03/first-look-at-darts-html-template.html
* http://blog.sethladd.com/2012/03/dart-templates-now-allow-nesting.html
* http://japhr.blogspot.fr/2012/03/dart-templates-bleeding-edge.html


Use pub : the Dart Package Manager
------------------------------------------------
Open a terminal, and change the current directory to the papory project directory, "dart/papori".
> 	$DART_SDK/bin/pub install is in your environnement path


Useful links :
------------------------------------------------

- Dart API Reference : http://api.dartlang.org/
- A Tour of the Dart Language : http://www.dartlang.org/docs/language-tour/
- Unit testing : http://api.dartlang.org/unittest.html
- Using Dart with JSON Web Services : http://www.dartlang.org/articles/json-web-service/

