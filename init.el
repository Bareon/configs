(require 'package)

(menu-bar-mode -1)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit by hand, you could mess it up, so be careful.
 ;; init file should only contain one instance.
 '(haskell-process-type 'stack-ghci)
 '(add-hook 'haskell-mode-hook 'interactive-haskell-mode)
 '(haskell-process-suggest-remove-import-lines t)
 '(haskell-process-auto-import-loaded-modules t)
 '(haskell-process-log t)
 '(haskell-process-path-ghci "stack")
 '(haskell-compile-cabal-build-command "cd %s && stack build")
 '(package-archives
   (quote
    (("gnu" . "http://elpa.gnu.org/packages/")
     ("melpa-stable" . "http://stable.melpa.org/packages/"))))
 ) ; tab -> C-x o
(package-initialize)
(package-refresh-contents)
(package-install 'intero)
(package-install 'flycheck)
(global-flycheck-mode)
(global-set-key (kbd "TAB") 'other-window)
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; Ensure ibuffer opens with point at the current buffer's entry.
(defadvice ibuffer
  (around ibuffer-point-to-most-recent) ()
  "Open ibuffer with cursor pointed to most recent buffer name."
  (let ((recent-buffer-name (buffer-name)))
    ad-do-it
    (ibuffer-jump-to-buffer recent-buffer-name)))
(ad-activate 'ibuffer)

;;auto-save settings
(setq auto-save-default nil)

;;backup settings
(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
      backup-by-copying-when-linked t    ; Don't delink hardlinks
      version-control t      ; Use version numbers on backups
      delete-old-versions t  ; Automatically delete excess backups
      kept-new-versions 5   ; how many of the newest versions to keep
      kept-old-versions 0    ; and how many of the old
)
(eval-after-load 'haskell-mode
 '(progn
  (define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-or-reload)
  (define-key haskell-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
  (define-key haskell-mode-map (kbd "C-c C-n C-t") 'haskell-process-do-type)
  (define-key haskell-mode-map (kbd "C-c C-n C-i") 'haskell-process-do-info)
  (define-key haskell-mode-map (kbd "C-c C-n C-c") 'haskell-process-stack-build)
  (define-key haskell-mode-map (kbd "C-c C-o") 'haskell-compile)
  (define-key haskell-mode-map [f8] 'haskell-navigate-imports)))


(add-to-list 'load-path "~/.emacs.d/evil")
(require 'evil)
(evil-mode 1)
(define-key evil-normal-state-map (kbd "TAB") 'other-window)
(setq evil-want-fine-undo t) 
