---
title: "To use Chroma code highlighting with the Hugo Academic theme"
author: ["Jonghyun Yun"]
lastmod: 2020-04-10T17:00:39-05:00
draft: false
math: true
diagram: true
---

The Academic theme uses Highlight.js for code highlighting, and it works well with the theme. Unfortunately, Highlight.js doesn't support Emacs-lisp code highlighting. I spent some time to add Emacs-lisp to the lisp configuration using [`hljs.registerLanguage`](https://stackoverflow.com/questions/55860466/how-can-i-add-language-aliases-to-highlightjs), but I could not understand how those work.

Hugo 0.28+ uses Chroma as the default code highlighter, and Chroma supports Emacs-lips syntax highlighting. So I have a couple of good reasons to try Chroma. I use Hugo v0.68.3 and Academic theme v4.8.0.

First, to disable Highlight.js, set `highlight = false` in `params.toml`. Then to enable Chroma, find `[markup.highlight]` in `config.toml` and put lines below:

{{< highlight toml "linenos=table, linenostart=1, hl_lines=5 23" >}}
[markup.highlight]
  # https://www.engino.co.uk/form-elements/syntax-highlighting/
  # codeFences = false  # Disable Hugo's code highlighter as it conflicts with Academic's highligher.
  pygmentsUseClassic            = false # Set to true to use Pygments instead of the much faster Chroma.
  pygmentsCodeFences            = true  # Enable Hugo's code highlighter
  pygmentsUseClasses            = false # Set to true to use syntax.css for highlighting
  pygmentsCodefencesGuessSyntax = false # Set to true to try to do syntax highlighting on code fenced blocks in markdown without a language tag.

  # https://xyproto.github.io/splash/docs/all.html
  # Note that this option is not relevant when pygmentsUseClasses is set.
  # pygmentsStyle = "emacs"
  # pygmentsStyle = "github"
  # pygmentsStyle = "solarized-light"
  # pygmentsStyle = "solarized-dark"

  # The below is pygmentsOptions
  guessSyntax = false
  hl_Lines = ""
  lineNoStart = 1
  lineNos = false
  lineNumbersInTable = false
  noClasses = true
  style = "emacs"
  # style = "solarized-light"
  tabWidth = 4
{{< /highlight >}}

There are some mismatch between background colors of code block and snippets. To fix it, run `hugo gen chromastyles --style=<my_style>` to find the background color of `my_style`. I choose "emacs", whose background color is `#f8f8f8`. The last step is to set `background-color` of `code` in `assets/scss/custom.scss`. Visit the gallery of the highligh style in <https://xyproto.github.io/splash/docs/all.html>.

```css
/* assets/scss/custom.scss */
code {
  background-color: #f8f8f8;
}
```

The result is code blocks in this post. Displaying line numbers and line highlights are a plug of using Chroma.
