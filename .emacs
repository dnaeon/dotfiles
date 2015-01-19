;; Misc
(global-set-key [C-tab] "\C-q\t")       ; Control tab quotes a tab.
 (setq backup-by-copying-when-mismatch t)

;; Add subdirectories
(let ((default-directory "~/.emacs.d/el-get/"))
  (normal-top-level-add-subdirs-to-load-path))

;; el-get
;;(add-to-list 'load-path "~/.emacs.d/el-get/el-get")


(require 'emacs-color-themes)
(load-theme 'junio t)

(require 'indent-guide)

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
(el-get 'sync)

;; Disable tool bar
;; (tool-bar-mode -1)

;; Disable scroll bar
(scroll-bar-mode -1)

;; Emacs Jedi
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:setup-keys t)                      ; optional
(setq jedi:complete-on-dot t)                 ; optional

;; Markdown mode
(autoload 'markdown-mode "markdown-mode.el"
  "Major mode for editing Markdown files" t)

(setq auto-mode-alist
  (cons '("\\.md" . markdown-mode) auto-mode-alist))

;; Python auto indent
;;(add-hook 'python-mode-hook '(lambda () (define-key python-mode-map "\C-m" 'newline-and-indent)))
(add-hook 'python-mode-hook 'indent-guide-mode)

(add-hook 'python-mode-hook 'electric-indent-mode)

;; Under UNIX
(server-start)

(require 'fill-column-indicator)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("a233249cc6f90098e13e555f5f5bf6f8461563a8043c7502fb0474be02affeea" "96998f6f11ef9f551b427b8853d947a7857ea5a578c75aa9c4e7c73fe04d10b4" "3cd28471e80be3bd2657ca3f03fbb2884ab669662271794360866ab60b6cb6e6" "b3775ba758e7d31f3bb849e7c9e48ff60929a792961a2d536edec8f68c671ca5" "3d5ef3d7ed58c9ad321f05360ad8a6b24585b9c49abcee67bdcbb0fe583a6950" "e9776d12e4ccb722a2a732c6e80423331bcb93f02e089ba2a4b02e85de1cf00e" "46fd293ff6e2f6b74a5edf1063c32f2a758ec24a5f63d13b07a20255c074d399" "58c6711a3b568437bab07a30385d34aacf64156cc5137ea20e799984f4227265" "0c29db826418061b40564e3351194a3d4a125d182c6ee5178c237a7364f0ff12" "1a85b8ade3d7cf76897b338ff3b20409cb5a5fbed4e45c6f38c98eee7b025ad4" "7bde52fdac7ac54d00f3d4c559f2f7aa899311655e7eb20ec5491f3b5c533fe8" "5cbfbbc76f64d4035c2d1647f2fac8d89080e3d9f9d0f3b57a1ac886d246276e" default)))
 '(ede-project-directories (quote ("/home/mnikolov"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
