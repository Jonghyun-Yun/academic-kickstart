(TeX-add-style-hook
 "math6312-syllabus"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("article" "10pt")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("inputenc" "utf8") ("fontenc" "T1") ("ulem" "normalem") ("microtype" "stretch=10" "babel=true")))
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperref")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperimage")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperbaseurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "nolinkurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "path")
   (TeX-run-style-hooks
    "latex2e"
    "article"
    "art10"
    "inputenc"
    "fontenc"
    "graphicx"
    "grffile"
    "longtable"
    "wrapfig"
    "rotating"
    "ulem"
    "amsmath"
    "textcomp"
    "amssymb"
    "capt-of"
    "hyperref"
    "geometry"
    "microtype"
    "lmodern")
   (LaTeX-add-labels
    "sec:org9a96648"
    "sec:org48efc57"
    "sec:orgd7cb9f3"
    "sec:orgb853240"
    "sec:orge0b824b"
    "sec:org741163d"
    "sec:orgdb515c2"
    "sec:orga81e482"
    "sec:org4160358"
    "sec:orgaf5cfe9"
    "sec:org5215354"
    "sec:orgff8212f"
    "sec:orgbd4c457"
    "sec:orgdefc373"
    "sec:org2a8463b"
    "sec:orgadfc57c"
    "sec:orgacf7c88"
    "sec:orga22caf7"
    "sec:org3803240"
    "sec:org9b71afd"
    "sec:org7f12c7a"
    "sec:org4e8bac6"))
 :latex)

