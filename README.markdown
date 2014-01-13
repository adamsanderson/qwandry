Qwandry, a questionable tool
=============================

Why spend time trying to remember where libraries, projects, and packages are 
lurking when your computer can do it faster?

    qw matrix        # opens ruby's matrix class in your editor
    qw rails         # will ask you which version of rails you want to open
    qw activerec 3.1 # will find the gem activerecord 3.1 and open it
    
You can also use Qwandry with other common languages:

    qw -r python numpy # opens python's numpy library
    qw -r perl URI     # open perl's URI library
    qw -r node express # open express if it is installed for node
    
Installation
------------
Qwandry is a standard ruby gem, on any system with ruby installed already 
simply install with:

    gem install qwandry

Usage
-----
Just type `qw` and the first few letters of what you're looking for.  By 
default Qwandry is set up for locating and editing ruby libraries.

    qw date # opens ruby's date library

Want to use Qwandry with Python, Perl, or other languages?

    qw --customize 
    
Editor Selection
----------------

Qwandry uses environment variables to launch your configured editor. The
following env variables are checked, in this order. The first value found is
used.

    QWANDRY_EDITOR
    VISUAL
    EDITOR

Setting `QWANDRY_EDITOR` allows you to specify an editor to be used with
Qwandry only.

Contact
-------
Adam Sanderson, netghost@gmail.com

Issues and Source: https://github.com/adamsanderson/qwandry
