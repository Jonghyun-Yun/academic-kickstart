---
title: "example post1"
lastmod: 2020-03-26T03:14:10-05:00
draft: false
title: Writing technical content in Academic
date: 2019-07-12
math: true
diagram: true
image:
  placement: 3
  caption: 'Image credit: [**John Moeses Bauan**](https://unsplash.com/photos/OGZtQF8iC0g)'
---

Academic is designed to give technical content creators a seamless experience.
You can focus on the content and Academic handles the rest.

****Highlight your code snippets, take notes on math classes, and draw diagrams from textual representation.****

On this page, you'll find some examples of the types of technical content that can be rendered with Academic.


##### Examples {#examples}


###### Code {#code}

Academic supports a Markdown extension for highlighting code syntax. You can enable this feature by toggling the \`highlight\` option in your \`config/\_default/params.toml\` file.

```text
```python
import pandas as pd
data = pd.read_csv("data.csv")
data.head()
```
```

renders as

```python
import pandas as pd
data = pd.read_csv("data.csv")
data.head()
```


###### Math {#math}

Academic supports a Markdown extension for \\(\LaTeX\\) math. You can enable this feature by toggling the \`math\` option in your \`config/\_default/params.toml\` file.

To render **inline** or **block** math, wrap your LaTeX math with \`$...$\` or \`\\[...\\]\`, respectively.

Example ****math block****:

```text
```tex
$$\gamma_{n} = \frac{
\left | \left (\mathbf x_{n} - \mathbf x_{n-1} \right )^T
\left [\nabla F (\mathbf x_{n}) - \nabla F (\mathbf x_{n-1}) \right ] \right |}
{\left \|\nabla F(\mathbf{x}_{n}) - \nabla F(\mathbf{x}_{n-1}) \right \|^2}$$
```
```

renders as

\\[\gamma\_{n} = \frac{ \left | \left (\mathbf x\_{n} - \mathbf x\_{n-1} \right )^T \left [\nabla F (\mathbf x\_{n}) - \nabla F (\mathbf x\_{n-1}) \right ] \right |}{\left \\|\nabla F(\mathbf{x}\_{n}) - \nabla F(\mathbf{x}\_{n-1}) \right \\|^2}\\]

Example ****inline math**** \`\\(\nabla F(\mathbf{x}\_{n})\\)\` renders as \\(\nabla F(\mathbf{x}\_{n})\\).

Example ****multi-line math**** using the \`\\\\\` math linebreak:

```text
```tex
$$f(k;p_0^*) = \begin{cases} p_0^* & \text{if }k=1, \\
1-p_0^* & \text {if }k=0.\end{cases}$$
```
```

renders as

\\[f(k;p\_0^\*) = \begin{cases} p\_0^\* & \text{if }k=1, \\\\\\
1-p\_0^\* & \text {if }k=0.\end{cases}\\]


###### Diagrams {#diagrams}

Academic supports a Markdown extension for diagrams. You can enable this feature by toggling the \`diagram\` option in your \`config/\_default/params.toml\` file or by adding \`diagram: true\` to your page front matter.

An example ****flowchart****:

```text
```mermaid
graph TD
A[Hard] -->|Text| B(Round)
B --> C{Decision}
C -->|One| D[Result 1]
C -->|Two| E[Result 2]
```
```

renders as

```mermaid
graph TD
A[Hard] -->|Text| B(Round)
B --> C{Decision}
C -->|One| D[Result 1]
C -->|Two| E[Result 2]
```

An example ****sequence diagram****:

```text
```mermaid
sequenceDiagram
Alice->>John: Hello John, how are you?
loop Healthcheck
    John->>John: Fight against hypochondria
end
Note right of John: Rational thoughts!
John-->>Alice: Great!
John->>Bob: How about you?
Bob-->>John: Jolly good!
```
```

renders as

```mermaid
sequenceDiagram
Alice->>John: Hello John, how are you?
loop Healthcheck
    John->>John: Fight against hypochondria
end
Note right of John: Rational thoughts!
John-->>Alice: Great!
John->>Bob: How about you?
Bob-->>John: Jolly good!
```

-   [ ] a
-   [X] b
-   [X] c
