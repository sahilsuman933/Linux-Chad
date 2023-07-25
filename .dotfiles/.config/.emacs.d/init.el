;; inhibit cl warrings
(setq byte-compile-warrings '(cl-functions))

;; Disable dialog boxes
(setq use-dialog-box nil)

;; Disable file dialogs
(setq use-file-dialog nil)

;;Hide tool bar
(tool-bar-mode -1)

;;Use y-or-n-p for prompts
(defalias 'yes-or-no-p 'y-or-n-p)

;; inhibit's the splash screen | Remove the homepage text.
(setq inhibit-splash-screen t)

;; Hide menu bar
(menu-bar-mode -1)

;; auto-closing brackets
(electric-pair-mode 1)

;; Melpa Package Manager (Just like vscode package manager)
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; use-package macro allows you to isolate package configuration
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(modus-vivendi ef-bio))
 '(custom-safe-themes
   '("4294aff6a80a0e683bf1ae776c2ae329f207c6a25c091941bc4025e4346161d1" "e5616f027ca0c17597ae35e6643a129b4ddaf0f64fdf45669b561e0e47c3ada5" "ee1670225ebb4abfaef8a0fe1d4224e14fb2e94d05cbae544ac7cfb433e3ff85" "d5e9309a9c9eb889e1e5728a948afd4240aaa6ca6555d40659c2e09f56798475" "917d7e7f0483dc90a5e2791db980ce9bc39e109a29198c6e9bdcd3d88a200c33" "14ba61945401e42d91bb8eef15ab6a03a96ff323dd150694ab8eb3bb86c0c580" "438f0e2b9fd637c53b20c27c140d2fc14fa154acf9ef92630666cab497c69742" "9a456f2aac10f18204e8ece27c84950c359f91bb06bda8c711bf4f5095ca8250" "b940c68944436ab216d83c13a05808bcacf40ac224c4aba2c209c3cbf2c76427" "0b96409bc39262906837afe75155e94bc84819cead6e66a778fdd3833cee7435" "a876039e0832c9a0e11af80ffbdbb4539aede1fbdc19460290fc4d1bf3a21741" "bebec7cd48f56fbca1c878d7f43ece10d5390ab95790883d95ae4c0f6045600a" "a8a5fd1c8afea56c5943ead67442a652f1f64c8191c257d76988edb0b1ad5dfa" "1a5bf8692b9aaa73a9a29bf8895546cfc06c0e064e4306f7f78a8f8437502322" "ef585bc8c42814cf045d07c4d85177f38dc8df1fc11c9f20b32a24c1eaaed80b" "ec8d9249bfb886752ee7a12bf6668665b1d053f30122720a99ef60f444a13652" "76c646974f43b321a8fd460a0f5759f916654575da5927d3fd4195029c158018" "13bf32d92677469e577baa02d654d462f074c115597652c1a3fce6872502bbea" "df2cdf4ffb933c929b6a95d60ac375013335b61565b9ebf02177b86e5e4d643f" default))
 '(package-selected-packages
   '(org-bullets magit pyvenv lsp-pyright tide dap-mode lsp-ui lsp-mode projectile company format-all highlight-indent-guides treemacs centaur-tabs smex ido-vertical-mode mood-line ef-themes use-package prettier web-mode markdown-mode emmet-mode js2-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Display Numbers
(global-display-line-numbers-mode)

;; Theme
(use-package ef-themes
  :if window-system
  :ensure t
  :config
  ;; Enable the theme
  (load-theme 'ef-winter t))

;; Font
(add-to-list 'default-frame-alist
             '(font . "JetBrains Mono-14"))



;; Mood Line
(use-package mood-line
  :ensure t
   :init
  (mood-line-mode))

;; Package suggestion in vertical mode (While searching for package)
(use-package ido-vertical-mode
  :ensure t
  :config
  (setq ido-enable-flex-matching t)
  (setq ido-everywhere t)
  (setq ido-vertical-define-keys 'C-n-and-C-p-only)      
  :init
  (ido-mode 1)
  (ido-vertical-mode 1))

;; Show most used package in ido-vertical mode
(use-package smex
  :ensure t
  :init (smex-initialize)
  :bind
  ("M-x" . smex))

;; Tabs
(use-package centaur-tabs
  :if window-system
  :demand
  :init
  ;; Set the style to rounded with icons
  (setq centaur-tabs-style "bar")
  (setq centaur-tabs-set-icons t)

  :config
  ;; Enable centaur-tabs
  (centaur-tabs-mode t))


;; For tree like view
(use-package treemacs
  :ensure t
  :defer t
  :bind
  (("C-c t" . treemacs))
  :config
  (setq treemacs-width 30)
  (setq-local mode-line-format nil))


;; For Highlight
(use-package highlight-indent-guides
  :ensure t
  :defer t
  :hook (prog-mode . highlight-indent-guides-mode)
  :config
  (setq highlight-indent-guides-method 'character)
  (setq highlight-indent-guides-character ?\|)
  (setq highlight-indent-guides-responsive 'top))

;; For Formatting
(use-package format-all
  :ensure t)

;; For Suggestion
(use-package company
  :ensure t
  :defer t
  :config
  (add-hook 'after-init-hook 'global-company-mode))


;; For navigation easily
(use-package projectile
  :ensure t
  :defer t
  :config
  ;; Enable Projectile globally
  (setq projectile-completion-system 'ido)
  (setq ido-enable-flex-matching t)
  (projectile-mode 1))

;; Advance code analysis, autocompletion and other language specific feature (Language Server Model)
(use-package lsp-mode 
  :ensure t
  :defer t
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (setq lsp-headerline-breadcrumb-enable nil))

;; Enchance lsp-mode ui
(use-package lsp-ui
  :ensure t
  :defer t)

;; Debugging Mode
(use-package dap-mode
  :after lsp-mode
  :ensure t
  :defer t)

;; web-mode for webdevelopment
(use-package web-mode
  :ensure t
  :defer t
  :config
  (setq
   web-mode-markup-indent-offset 2
   web-mode-css-indent-offset 2
   web-mode-code-indent-offset 2
   web-mode-style-padding 2
   web-mode-script-padding 2
   web-mode-enable-auto-closing t
   web-mode-enable-auto-opening t
   web-mode-enable-auto-pairing t
   web-mode-enable-auto-indentation t)
  :mode
  (".html$" "*.php$" "*.tsx"))

;; emmet-mode
(use-package emmet-mode
  :ensure t
  :defer t)

(use-package tide
  :ensure t
  :defer t
  :config
  (setq company-tooltip-align-annotations t)
  (add-hook 'before-save-hook 'tide-format-before-save))
(add-hook 'typescript-mode-hook #'setup-tide-mode)

;; Typescript mode
(defun setup-tide-mode ()
  "Set up Tide mode."
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save-mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1))

;; Add support for TSX file
(add-hook 'web-mode-hook
	    (lambda ()
	      (when (string-equal "tsx" (file-name-extension buffer-file-name))
		(setup-tide-mode))))

;; For Python Language Server Model 
(use-package lsp-pyright
  :ensure t
  :defer t
  :hook (python-mode . (lambda ()
			   (setq indent-tabs-mode t)
			   (setq tab-width 4)
			   (setq python-indent-offset 4)
			   (company-mode 1)
			   (require 'lsp-pyright)
			   (pyvenv-autoload)
			   (lsp))))

;; Python pyvenv
(use-package pyvenv
  :ensure t
  :defer t)

;; Git Integration
(use-package magit
  :ensure t
  :defer t)

;; Org Mode Bullet

(use-package org-bullets
  :ensure t
  :defer t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

;; Org Mode Agenda
(setq org-agenda-files (append
                        (file-expand-wildcards "~/dox/org/*.org")))


;; Locale

(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
