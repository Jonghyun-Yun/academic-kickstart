---
title: "How to fix when Emacs in OS X displays decomposed Korean characters"
author: ["Jonghyun Yun"]
lastmod: 2021-03-06T21:07:12-06:00
draft: false
math: true
diagram: true
---

I ran into this problem recently while I was using Emacs to find a file with Korean characters in filename. OS X's filesystem uses UTF-8 NFD (normalized form D), which Emacs doesn't support by default. As a result, some characters in filenames are decomposed into sequences of characters. The below shows how Emacs `dired-mode` fails to correctly display a filename.

{{< figure src="nfd_filename.png" >}}

This issue prevents me from searching files by their names. Characters affected by this issue are

-   All characters containing diacritical marks (accents, umlauts, tilde, etc.)
-   Japanese Kana characters with Dakuten/Handakuten signs
-   Korean Hangul characters

The problem is quite annoying, but it only affects a small group of users (using Emacs in OS X and having filenames containing one of these characters). That's probably why it took a while for me to find a fix. After reading [Emacs Unicode Pitfalls](https://nullprogram.com/blog/2014/06/13/) and [EmacsWiki: Carbon Emacs Package](https://www.emacswiki.org/emacs/CarbonEmacsPackage#h5o-24), I got some hints and added the below in `emacs.d`.

```emacs-lisp
(require 'ucs-normalize)
(set-file-name-coding-system 'utf-8-hfs)
```

It solved the problem! Now, `dired-mode` correctly displays filenames.

{{< figure src="nfc_filename.png" >}}

In addition, if you are having the similar issue in iTerm2, you may want to choose `Unicode normalization form` to `NFC`. The option can be found in `Preferences` -> `Profiles` -> `Text`.
