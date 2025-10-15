# Latex

## Installation on Windows with VS Code
Fido has a [guide](https://f-i-d-o.github.io/Manuals/LaTeX/LaTeX%20workflow/).

Default hotkeys in VS Code Latex Workshop:
 - Ctrl+Alt+j in source - jump to pdf
 - Ctrl+mouseclick in pdf - jump to source
 - Ctrl+Alt+b - build

## SI units - siunitx

Package for typesetting numbers and SI units. See [docs](https://ctan.math.utah.edu/ctan/tex-archive/macros/latex/contrib/siunitx/siunitx.pdf) for details.

Usage: 
```Latex
\usepackage{siunitx}

% number
\num{<value>} % e.g. \num{10}, \num{-e10}, \num{3.45d-4}, \num{.12345}

%\unit
\unit{<unit>} % e.g. \unit{\meter\per\second}, \unit{\kilo\watt\hour}, \unit{\kWh}

% value and unit
\SI{<value>}{<unit>} % e.g. \SI{10}{\meter\per\second}
```


## Cleverref

For clever references that automatically detect the type of reference (e.g. figure, table, etc.) and add the appropriate prefix (e.g. "Figure 1.1" instead of "1.1").

```Latex
% preamble
\usepackage{hyperref}
\usepackage[capitalise, noabbrev]{cleveref} % for \cref, MUST be loaded AFTER hyperref

% usage
\cref{sec:some_section} % -> section 1.1
\Cref{sec:some_section} % -> Section 1.1 - capitalize first letter even if "capitalise" option is not set
\cref{sec:some_section,sec:some_other_section} % -> sections 1.1 and 1.2. Note that there CANT be any space between the references

\crefrange{label1}{label2} % -> sections 1.1 to 1.4
```
Package options
- `capitalise` - capitalises the first letter of the reference type (e.g. "Figure 1.1" instead of "figure 1.1")
- `noabbrev` - disables abbreviations (e.g. "Figure" instead of "Fig.")

When used with hyperref, `\cref*` (and other asterisked commands) will not create a link to the reference, just the text and number.

Note that figure labels must be placed *after* the caption, otherwise, the reference will point to the section instead of the figure, e.g.:

```Latex
\begin{figure}
    \centering
    \includegraphics[width=0.5\textwidth]{example-image-a}
    \caption{Example image}
    \label{fig:example_image} % <- must be placed after the caption
```

## Tables

### Footnotes in tables
See https://f-i-d-o.github.io/Manuals/LaTeX/Latex%20manual/#using-the-talltblr 

## Figures
Guide e.g. [here](https://www.overleaf.com/learn/latex/How_to_Write_a_Thesis_in_LaTeX_(Part_3)%3A_Figures%2C_Subfigures_and_Tables). 

Template for single figure:
```Latex
\begin{figure}[h]
\centering
\includegraphics[scale=0.5]{graph_a} %or width=0.9\textwidth
\caption{An example graph}
\label{fig:x cubed graph}
\end{figure}
```

Template for subfigures:
```Latex
\usepackage{caption}
\usepackage{subcaption}

\begin{figure}
     \centering
     \begin{subfigure}[t]{0.3\textwidth} % [t] is for top alignment of subfigure caption
         \centering
         \includegraphics[width=\textwidth]{graph1}
         \caption{$y=x$}
         \label{fig:y equals x}
     \end{subfigure}
     \hfill
     \begin{subfigure}[t]{0.3\textwidth}
         \centering
         \includegraphics[width=\textwidth]{graph2}
         \caption{$y=3\sin x$}
         \label{fig:three sin x}
     \end{subfigure}
     \hfill
     \begin{subfigure}[t]{0.3\textwidth}
         \centering
         \includegraphics[width=\textwidth]{graph3}
         \caption{$y=5/x$}
         \label{fig:five over x}
     \end{subfigure}
        \caption{Three simple graphs}
        \label{fig:three graphs}
\end{figure}
```

For subfigures, use the 'subcaption' environment. The 'subfigure' environment is deprecated. 

## Algorithms packages
After some research, `algorithmicx` with `algpseudocode` seems like the package of choice for algorithms. For comparison of options, see SO [answer](https://tex.stackexchange.com/questions/229355/algorithm-algorithmic-algorithmicx-algorithm2e-algpseudocode-confused).

For the distinction:
 - ✅ `algorithm` - package that provides float environment for algorithms
 - ❌ `algorithmic` - older package that provides environment for typesetting algorithms
 - ✅ `algorithmicx` - "upgraded" version of the `algorithmic` package, environment for typesetting algorithms with custom defined commands
 - ✅ `algpseudocode` - "layout" for `algorithmicx`, it emulates `algorithmic` using `algorithmicx` defined commands. **Seems like this is what you want to use.** Other options for layout include Pascal pseudoce and so on. This package automatically loads `algorithmicx`
 - ✅ `algpseudocodex` - improved version of `algpseudocode`, better handling of code comments
 - ❌ `algorithm2e` - another package for typesetting algorithms, but it is not compatible with `algorithmicx` and `algpseudocode` and supposedly has more complicated syntax

 ### Usage
 No need to import following:
```Latex
\usepackage{algorithm} % for the float environment
\usepackage{algpseudocodex} % automatically loads algorithmicx, adding options for different layouts
```
 
 Template for usage is:

 ```Latex
\begin{algorithm}
\caption{Caption}\label{alg:label}
\begin{algorithmic}[1] % 1 means line numbering
    <Your algorithm>
\end{algorithmic}
\end{algorithm}
 ```

 Use of keywords is described by the documentation [(Section 3.1, page 5)](https://mirror.ox.ac.uk/sites/ctan.org/macros/latex/contrib/algorithmicx/algorithmicx.pdf). Reference is here:

```Latex
% \State denotes regular line of code, render as "var <-- 0"
\State $var \gets 0$

% Requirements
\Require something
\Ensure something
% Empty unnumbered line
\Statex
% Function call
\State \Call{Fun}{10}
% Inline comment
\Comment{<xtet>}
% Label - place after \End to reference structures below
\label{<xtet>}
% return - created manually
\State \Return $100$


\For{<xtet>}
<body>
\EndFor

\While{<text>}
<body>
\EndWhile

\If{<text>}
<body>
\ElsIf{<text>}
<body>
...
\Else
<body>
\EndIf

\Procedure{<name>}{<params>}
<body>
\EndProcedure

\Function{<name>}{<params>}
<body>
\EndFunction

\Loop
<body>
\EndLoop
```


## Citations

According to David Fiedler, its best to use `biblatex` with `biber` backend. 

```Latex
\usepackage[backend=biber,style=authoryear]{biblatex} % or numeric, etc.    
```

### Extracting only cited references
Great for journal submissions, this blog has the way: https://brianbuccola.com/use-biblatex-biber-to-create-a-new-subdatabase-based-on-an-auxiliary-file/

```Bash
pdflatex root_IEEE.tex
biber --output-format=bibtex root_IEEE.bcf # generates fule root_IEEE_biber.bib that contains only cited references

# expanded example:
biber --output-format=bibtex --output_fieldcase=lower --output-file=cited_references.bib root_IEEE.bcf

```

## Doublequotes

If you do `"text"` in Latex, you will get wrong-looking quotes.

### OG approaches
To fix this, you can do either of the following:
```Latex
\textquotedbl{} quoted text \textquotedbl{}
```
(But this might give the 'unavailable in encoding OT1' error)

or 

```
``quoted text''
```

But both are cumbersome in my opinion. 

### CSQUOTES: The Better Solution
Better solution is to use `csquotes`:
```Latex
\usepackage[autostyle=false, style=english]{csquotes}
\MakeOuterQuote{"}

% usage
"quoted text displayed correctly"
% or
\enquote{this, you must use this for nested quotes}
```

Other package commands

```Latex
\enquote{quote} % proper "double quotes"
\enquote*{quote} % proper `single quotes`
\enquote{quote \enquote{quote in quote}} % nested "quote 'quote in quote'"

```

## Dashes: hyphen `-`, en-dash `--`, em-dash `---`

Reference on their use [here](https://www.merriam-webster.com/grammar/em-dash-en-dash-how-to-use) and [here](https://tex.stackexchange.com/a/434619)   

Note that there are *no spaces* around the dashes.

### Hyphen ` - `
Used for compound words like ‘daughter-in-law’ and ‘X-ray’. Hyphens are also use to break up a long word at the end of a line within a paragraph.

### En-dash ` -- `, `\textendash{}`
En-dashes are used for number ranges like ‘pages 13–34’, and also in contexts like ‘exercise 1.2.6–52’ or ‘August 1–August 31’. 

### Em-dash ` --- `, `\textemdash{}`
Em-dashes are used for punctuation in sentences. They are used as:

- the middle-ground between commas and parentheses, where
  - `..., text,...` commas are used for the most closely related but additiona information
  - `... (text) ...` parentheses are used for the least closely related information
- instead of colon or semicolon
- to introduce a list
- ... see the usage references above for more

## Glossaries

```Latex
\usepackage[acronym]{glossaries} % To generate a separate list of acronyms, the package needs to be loaded with the acronym option.

\makeglossaries % Prints glossary entries

\newglossaryentry{maths}
{
        name=mathematics,
        description={Mathematics is what mathematicians do}
}

% Acronyms: \newacronym{⟨label⟩}{⟨abbrv⟩}{⟨full⟩}
\newacronym{gcd}{GCD}{Greatest Common Divisor}
\newacronym{lcm}{LCM}{Least Common Multiple}


% Usage: 
% Standard command
\gls{⟨label⟩}
% Capitalize first letter
\Gls{⟨label⟩}
% Pluralize term
\glspl{⟨label⟩}
%Capitalize and pluralize term
\Glspl{⟨label⟩}

\clearpage

\printglossary[type=\acronymtype] % Prints acronym entries

```

## Fonts and Typography

```Latex
\usepackage{microtype}
```
`microtype` should make the text look imperceptibly better. It is recommended to use it, see nice [answer](https://tex.stackexchange.com/a/82637) on SO for more details.

## Tikz

For overview of tree-making options, see this [guide](https://latexdraw.com/draw-trees-in-tikz/)

## Numbers in text: `-th` vs `^th` vs `th`
Just use `th`.

Read more on [SO](https://tex.stackexchange.com/questions/4118/whats-the-quickest-way-to-write-2nd-3rd-etc-in-latex)

# Revisions with Latex and Git
To show changes in pdf, the (latexdiff)[https://www.ctan.org/pkg/latexdiff] package is useful. It is most likely preinstalled with latex. 

Usage for highlighting changes after journal revision:

1. Tag the commit with your submitted version, e.g. `git tag -a v1.0 -m "Submitted version"`
2. Commit some changes
3. Run `latexdiff` with the following command:
```Bash
# if all your latex lives in a single file
latexdiff-vc -r v1.0 main.tex
# or if your headers are in a separate root file
latexdiff-vc -r v1.0 content.tex root.tex
```
4. Compile the newly created latex documents

## Errors

- the packag errors if "" are used for quotes in the text.
- the package errors if using custom commands such as `\MDP/` because of the ending `/`
