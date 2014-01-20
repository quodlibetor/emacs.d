=========
 emacs.d
=========

Getting it working
==================

Generally, just clone this repo into ``~/.emacs.d``

Python
------

Python mode needs jedi, and maybe one day I'll switch to el-get::

  $ pip install jedi

And I need to link the pyflymake.py file to bin::

  $ ln -s ~/.emacs.d/packages/flymake-python/pyflymake.py ~/.local/bin
