---
title: "Creating short stylish cover letters using Org-mode"
author: ["Jonghyun Yun"]
lastmod: 2020-04-10T17:00:38-05:00
tags: ["cover letter", "Org-mode", "emacs"]
draft: false
math: true
diagram: true
image:
  placement: 3
---

This stylish cover letter includes a custom large header and footer. The original LaTeX
template can be found in
<https://www.latextemplates.com/template/short-stylish-cover-letter>.
Unfortunately
these header and foorter do not leave much space for text. To squeeze everything into one page, you may want to play with margins.
See <http://texdoc.net/texmf-dist/doc/latex/koma-script/scrguien.pdf>.

I use LaTeX much less than I did 10 years ago. Even for scientific articles, I create a draft using the Org-mode and export it to LaTeX when the project is mature. I also write a simple letter using the Org-mode, and export it to a PDF file.


##### KOMA-Script letter exporter {#koma-script-letter-exporter}

See the minimal configuration of `koma-letter-exporter` in
<https://orgmode.org/worg/exporters/koma-letter-export.html>.
The below loads a
multilingual support package depeding on TeX engines.

```emacs-lisp
;; https://orgmode.org/manual/LaTeX-specific-export-settings.html
(add-to-list 'org-latex-packages-alist
             '("AUTO" "babel" t ("pdflatex")))
(add-to-list 'org-latex-packages-alist
             '("AUTO" "polyglossia" t ("xelatex" "lualatex")))
```

The KOMA-Script exporter can be enabled by putting the below in a emacs config file. The option `hidelinks` in `hyperref` is used to hide a ugly bluebox enclosing a link.

```emacs-lisp
 ;; KOMA-SCript letter
  (eval-after-load 'ox '(require 'ox-koma-letter))
  (eval-after-load 'ox-koma-letter
    '(progn
       (add-to-list 'org-latex-classes
                    '("my-koma-letter"
                      "\\documentclass\{scrlttr2\}
\\usepackage[hidelinks,unicode]{hyperref}
[NO-DEFAULT-PACKAGES]"))

       (setq org-koma-letter-default-class "my-koma-letter")))
```


##### Cover letter {#cover-letter}

Placement of elements is defined in letter class option (LCO) file. The Short
Stylish Cover Letter LCO ([SSCL LCO](SSCL.lco)) is customized for large header and footer based on
UScommercial9 LCO, and the file should be placed in the search path of LaTeX.
Now, I can open [Pink letter](ramsay.org) and press `C-c C-e k o` to the pdf export.
Pink Letter are fan-given names for a letter purportedly written by Ramsay Bolton in George R. R. Martin's _A Song of Ice and Fire_.

A signature image can be placed right after closing. With no signature image, the line with
`#+LATEX_HEADER_EXTRA: \setplength{sigbeforevskip}{0cm}` should be commented to have proper spacing between closing and signature.

Another nice CLO file is found the R package `komaletter`. This package lets us export a R Markdown letter to a PDF file. After install this package, a path of the CLO file can be located using the below R code. I need to replace `SSCL` in `#+LATEX_HEADER: \LoadLetterOption{SSCL}` with the path found without the extension (.lco).

```R
install.package(komaletter)
system.file("rmarkdown", "templates", "pdf", "resources", "maintainersDelight.lco", package="komaletter")
```

Now with this LCO, the letter should be exported with the personal information in a big header with no footer.

{{< figure src="ramsay_rkoma.png" >}}
