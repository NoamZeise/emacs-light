# emacs-light
A config for GNU Emacs. I call this a 'light' config because I try to keep close to the package default controls/shortcuts, and it tries to have minimal clutter on screen.

## features
- C/C++/Rust/Java/CommonLisp/Scheme/LaTex/Python IDE
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

To use the default font install [IBM Plex Mono](https://github.com/IBM/plex), or change `nano-font-family-monospaced` to your preferred font, then call `eml-refresh-theme`.

This uses [Okular](https://okular.kde.org/en-gb/) as the default pdf viewer for TeX files, so having it installed will let you open pdfs while editing Tex.

## settings
You can make a `custom.el` file in your emacs dir (default `~/.emacs.d/`) to add your own settings.
This config uses `use-package` so you should be able to add any extra packages to your `custom.el` file.

#### Using a diferent theme

Install a new theme and note it's name (should appear in `load-theme`). In your `custom.el` to use a theme called `your-new-theme-name`, insert these lines
```
(require 'eml-theme)
(setq eml-theme-loader-fn
	'(lambda () (load-theme 'your-new-theme-name t)))
```

## Additional tips

* if you ever get an error such as `failed to install [some package] ... Not found`
try running `package-refresh-contents` and try opening emacs again.

* If you are doing C/C++ development, lsp will not install clangd for you 
(it says it does, but it doesn't work sometimes). So you need to install clangd 
and have it visible on your path for lsp to work.

* If you are missing icons or error symbols in headerline -> run `all-the-icons-install-fonts`.

* you can use the `shell-init.el` config for your emacs daemon and use emacs as your terminal with eshell.

## keyboard rebindings in this config

* lsp commands prefixed with `C-c l`
* `C-c l d` -> show/hide lsp-ui-doc of current symbol
* xref-find-def/ref default bindings instead use lsp-ui-peek-find-def/ref

## some more screenshots

![screenshot of git gutter](https://github.com/NoamZeise/emacs-light/blob/master/example-screenshots/git-gutter-elisp-readme.png?raw=true)

![editing common lisp with repl](https://github.com/NoamZeise/emacs-light/blob/master/example-screenshots/common-lisp-repl.png?raw=true)

![editing latex documents](https://github.com/NoamZeise/emacs-light/blob/master/example-screenshots/latex-editing.png?raw=true)
