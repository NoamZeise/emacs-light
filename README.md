# emacs-light
A config for GNU Emacs. I call this a 'light' config because I try to keep close to the emacs default controls/shortcuts, and it tries to have minimal clutter on screen.

## features
- C/C++/Rust/Java/CommonLisp/Python IDE
- Minimalist theme, uses [nano-emacs](https://github.com/rougier/nano-emacs/)
- themes support terminal or windowed, as well as with an emacs daemon

## setup
If you already have emacs, then clone this repo (with submodules) to your home directory and rename to ".emacs.d". This can be done with the following command from your home directory.
```
$ git clone --recurse-submodules https://github.com/NoamZeise/emacs-light.git .emacs.d
```
when you open emacs it should automatically load this config. The config will automatically
install all the pakcages it uses, so it will take a while to open. By default this config hides 
messages on startup, you can just comment out the `early-init.el` files lines if you want feedback
when opening emacs (this will slighty impact startup time)


You may need to uncomment a line near the beginning of init.el that disables package check signaturesif you are getting install errors.

## settings
You can make a `custom.el` file in your emacs dir (default `~/.emacs.d/`) to add your own settings.
This config uses `use-package` so you should be able to add any extra packages to your `custom.el` file.

## Additional tips

If you are doing C/C++ development, lsp will not install clangd for you (it says it does, but it doesn't work). 
So you need to install clangd and have it visible on your path for lsp to work.
