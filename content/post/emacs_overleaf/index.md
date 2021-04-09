---
title: "Sync Overleaf projects using Emacs"
author: ["Jonghyun Yun"]
lastmod: 2021-04-09T06:05:55-05:00
draft: false
math: true
diagram: true
---

My [hack](post.md) to sync [Overleaf](https://www.overleaf.com/) projects stopped working after upgrading Emacs to 27.2. The previous hack was also a bit risky as it could push changes for another project I visit. So, I decide to write new lisp codes that can eliminate the chance of this unwanted update. Local and remote changes in [Overleaf](https://www.overleaf.com/) projects can be synced using `git`. In my normal workflow, I `pull` the remote changes from Overleaf upon first time opening the project in Emacs, and I `push` the local changes to Overleaf before closing the project. Sometimes I forget to `pull` or `push`, which can cost me labors to fix differences in local and remote. My goal is to make Emacs do the synchronization automatically, so that opening the project triggers `pull` and saving the project triggers `push`. This hack requires `find-file-in-project` and `magit` packages.

The below are functions `config.el` to sync Overleaf projects. They take `directory` as an argument, so that their execution would be limited for a target `directory`. It can prevent from accidentally updating another project's remote.

```emacs-lisp
;;;###autoload
(defun jyun/magit-push-overleaf (directory)
  "Use Magit to stage files if there are unstaged ones.
Call asynchronous magit processes to commit and push staged files (if exist) to origin"
  (progn
    (unless (featurep 'magit) (require 'magit))
    (let ((default-directory (magit-toplevel directory)))
    (when (or (magit-anything-unstaged-p) (magit-anything-staged-p))
      (magit-with-toplevel
        (magit-stage-1 "--u" magit-buffer-diff-files))
      (let ((message (format "pushing changes %s" (format-time-string "%Y-%m-%d %H:%M:%S %Z"))))
        (magit-run-git-async "commit" "-m" message)
        (magit-run-git-async "push" "origin" "master")
        )))))

;;;###autoload
(defun jyun/magit-pull-overleaf (directory)
  "Run `git pull origin master' using asynchronous magit processes."
  (progn
    (unless (featurep 'magit) (require 'magit))
    (let ((default-directory (magit-toplevel directory)))
    (magit-run-git-async "pull" "origin" "master"))
  ))
```

These functions need to be hooked with opening and saving actions as the project's directory local variables. They are added in a target project's `.dir-locals.el` as follows.

```emacs-lisp
((nil . (eval . (setq overleaf-directory (ffip-project-root)))
        (eval . (add-hook 'projectile-after-switch-project-hook (lambda () (jyun/magit-pull-overleaf overleaf-directory)))))
 (latex-mode . (eval . (add-hook 'after-save-hook (lambda () (jyun/magit-push-overleaf overleaf-directory))))))
```

For some reasons, Emacs 27.2 becomes strict about enabling risky local variables.
The last step is to teach Emacs that the above local variables are safe to run. To do so, I put the below in `config.el`.

```emacs-lisp
(setq safe-local-eval-forms
      (append safe-local-eval-forms
              '((setq overleaf-directory (ffip-project-root))
                (add-hook 'projectile-after-switch-project-hook (lambda () (jyun/magit-pull-overleaf overleaf-directory)))
                (add-hook 'after-save-hook (lambda () (jyun/magit-push-overleaf overleaf-directory)))
                )))
```

So far, the new hack works well. It prints a completion message in a minibuffer after every silent synchronization, which gives me peace of mind. LaTeX files are saved when compiled, so the compiling triggers pushing changes to Overleaf.
