# emacs-light
A config for GNU Emacs. I call this a 'light' config because I try to keep close to the emacs default controls/shortcuts. 

## features
- C/C++/Rust/Java/CommonLisp/Python IDE
- Minimalist theme, modified version of [nano-emacs](https://github.com/rougier/nano-emacs/)

## setup
If you already have emacs, then clone this repo (with submodules) to your home directory and rename to ".emacs.d". This can be dome with the following command from your home directory.
```
$ git clone --recurse-submodules https://github.com/NoamZeise/emacs-light.git .emacs.d
```
You may need to uncomment a line near the beginning of init.el that disables package check signatures, just for the first time install, If you are getting install errors when opening emacs.

## settings
You can make a custom.el file in your emacs dir to add your own settings.
There are also some settings that you can enable, if you want extra features.


You can place these in your custom.el file:
- (setq eml-use-centaur-tabs t) ;; for centaur tabs - have tabs for open files at the top of your window
- (setq eml-use-treemacs nil) ;; for treemacs - a tree of files at the side of your project
