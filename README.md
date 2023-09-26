# emacs-light
A config for GNU Emacs. I call this a 'light' config because I try to keep close to the package default controls/shortcuts, and it tries to have minimal clutter on screen.

## features
- C/C++/Rust/Java/CommonLisp/Scheme(default: guile)/Racket/LaTex/Python IDE
- Minimalist theme, uses [nano-emacs](https://github.com/rougier/nano-emacs/) for header modeline, [sanityinc-tomorrow-eighties](https://github.com/purcell/color-theme-sanityinc-tomorrow) for the colour theme.
- config supports terminal or windowed, as well as using emacs as a daemon
- deferred package loading for faster load times (not deferred if using emacs as daemon)
- subtle git gutter

![screenshot of editing C++ Code](https://github.com/NoamZeise/emacs-light/blob/master/example-screenshots/autocompletion-suggestions.png?raw=true)

## setup
If you already have emacs, then clone this repo (with submodules) to your home directory and rename to ".emacs.d". This can be done with the following command from your home directory.
```
$ git clone --recurse-submodules https://github.com/NoamZeise/emacs-light.git .emacs.d
```
when you open emacs it should automatically load this config. The config will automatically
install all the pakcages it uses, so it will take a while to open. By default this config hides 
messages on startup, you can just comment out the `early-init.el` files lines if you want feedback
when opening emacs (this will slighty impact startup time).

You may need to uncomment a line near the beginning of init.el that disables package check signaturesif you are getting install errors.

## settings
You can make a `custom.el` file in your emacs dir (default `~/.emacs.d/`) to add your own settings.
This config uses `use-package` so you should be able to add any extra packages to your `custom.el` file.

#### environment configs

Add these lines to your custom.el to change these settings

* The default font is  [IBM Plex Mono](https://github.com/IBM/plex). To change the font settings, you can add
```
(setq eml-font "your favorite font")
(setq eml-font-size 11)
(eml-refresh-theme)
```

* SBCL is the default Common Lisp Environment. To change this add
```(setq eml-default-common-lisp "your-common-lisp-here")``` 

* For LaTeX, Okular is set as the default pdf viewer. If you want to change this, add
```(setq eml-default-pdf-program "your-pdf-viwer-here")```

* To change whether emacs starts fullscreen set
```(setq eml-open-fullscreen t)```

#### using a diferent theme

Install a new theme and note it's name (should appear in `load-theme`). In your `custom.el` to use a theme called `your-new-theme-name`, insert these lines
```
(require 'eml-theme)
(setq eml-theme-loader-fn
	'(lambda () (load-theme 'your-new-theme-name t)))
```
#### using EXWM

If you want to use emacs as a window manager, you can check out the exwm wiki.
A config for exwm is included, just add `(require 'eml-exwm)` to your `custom.el` file.

## additional tips

* if you ever get an error such as `failed to install [some package] ... Not found`
try running `package-refresh-contents` and try opening emacs again.

* errors relating to missing keys, or package signature errors can be fixed by uncommenting a line near the beginning of `default-prefs.el` to disable signature checks. Open emacs, then re-comment the line and open it again, and the errors should no longer appear.

* If you are doing C/C++ development, lsp will not install clangd for you 
(it says it does, but it doesn't work sometimes). So you need to install clangd 
and have it visible on your path for lsp to work.

* Rust Analyzer - to use rust lsp mode, you will need to [install rust analyzer](~/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/)

* If you are missing icons or have error symbols in headerline run `all-the-icons-install-fonts`. make sure you have lsp loaded, or all the icons wont be loaded yet (just open a programming file)

* you can use the `shell-init.el` config for faster loading without any language/lsp packages. This is for using emacs as a shell. Loading a different init is done by opening emacs like this:
```emacs -q -l "~/.emacs.d/shell-init.el```

* you can use the `fullscreen-init.el` config for the same as default except emacs starts in fullscreen mode.

* Ace Window is used, so to switch between windows use `M-o` and then numbers should appear if you have more than two windows. Just press the number of the window you want to switch to.


## keyboard rebindings in this config

* lsp commands prefixed with `C-c l`
* `C-c l d` -> show/hide lsp-ui-doc of current symbol
* xref-find-def/ref default bindings instead use lsp-ui-peek-find-def/ref
* magit-status -> `C-x g`

## some more screenshots

![screenshot of git gutter](https://github.com/NoamZeise/emacs-light/blob/master/example-screenshots/git-gutter-elisp-readme.png?raw=true)

![editing common lisp with repl](https://github.com/NoamZeise/emacs-light/blob/master/example-screenshots/common-lisp-repl.png?raw=true)

![editing latex documents](https://github.com/NoamZeise/emacs-light/blob/master/example-screenshots/latex-editing.png?raw=true)
