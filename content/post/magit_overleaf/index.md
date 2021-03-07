---
title: "How to sync between Overleaf projects and Emacs"
author: ["Jonghyun Yun"]
lastmod: 2021-03-06T21:07:12-06:00
draft: false
math: true
diagram: true
---

My collaborators and I have a few shared projects in [Overleaf](https://www.overleaf.com/). It provides a few options to sync local and remote changes in project files. At this moment, using `git` to sync files is the only "free" option, but it requires users to manually sync files. I edit TeX files locally using Emacs, and use [`Magit`](https://magit.vc/) to sync. Sometimes I forget to commit and push local changes to Overleaf, which can cost me a long to compare my local changes with changes in Overleaf updated by collaborators. I made a chain of commands to do semi-automatic synchronization of Overleaf projects in Emacs. It pushes local changes to Overleaf on saving TeX files. I need to do `magit pull` manually before editing project files, and that's why I called this "semi-" automatic.

To use this method, I need to put the below in `.dir-locals.el` of the project. This directory local variable enables running `'jyun/magit-update-overleaf` whenever a TeX file belongs to the project is saved.

```emacs-lisp
((latex-mode . ((after-save-hook . jyun/magit-update-overleaf))))
```

The below is the function defined in my `config.el`. It uses [find-file-in-project](https://github.com/redguardtoo/find-file-in-project) to determine the top-level directory of the current project. The function triggers to run `update-overleaf.sh` if it detects any changes in local files being tracked.

```emacs-lisp
;;;###autoload
(defun jyun/magit-update-overleaf ()
  "Use Magit to stage files if there are unstaged ones.
Run a shellscript to commit and push staged files (if exist) to Overleaf.
 Assign a name to a shell command output buffer."
  (interactive)
  (progn
    (unless (featurep 'find-file-in-project) (require 'find-file-in-project))
    (when (or (magit-anything-unstaged-p) (magit-anything-staged-p))
      (magit-with-toplevel
        (magit-stage-1 "--u" magit-buffer-diff-files))
      (message "Asynchronously pushing changes to Overleaf...")
      (async-shell-command (format "sh %supdate-overleaf.sh" (ffip-project-root))
                           (format "*overleaf: %s*" (projectile-project-name))
                           (format "*overleaf error: %s*" (projectile-project-name)))
      ;; (message "Done!")
      )
    ))
```

Finally, the below is `update-overleaf.sh` resided in in the project root. It generate the commit message and push to Overleaf.

```sh
#!/bin/sh

# If a command fails then the push stops
set -e

printf "\033[0;32mPushing updates to Overleaf...\033[0m\n"

## this has done by Magit!
# Add changes to git.
# git add main.tex

# Commit changes.
msg="updates $(date)"
if [ -n "$*" ]; then
    msg="$*"
fi
git commit -m "$msg"

# Push source to Overleaf
git push origin master
```

So far, this method works well. LaTeX files are saved when compiled, so the compiling triggers pushing changes to Overleaf. It would be a good idea to write codes for triggering `git pull` when the project is first opened in Emacs.
