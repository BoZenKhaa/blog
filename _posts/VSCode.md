# VS Code

## Useful hotkeys
 - Ctrl+g: Go to line number
 - Multi-cursor
    - Alt + LMB: add multiple cursors
    - Ctrl+Alt+Down: add multi-cursor below

## Color schemes of choice

*Noctis Obscuro* - great night theme
*Noctis Lilac* - day theme

with some Latex-specific tweaks:

```json
    // from https://dev.to/psudo-dev/how-to-customize-or-make-your-own-vscode-color-theme-49j1
    "editor.tokenColorCustomizations":{
      "[Noctis Obscuro]": {
        "textMateRules": [
          { // or you can target all languages
            "scope":["entity.name.section.latex","support.function.section.latex"],
            "settings": {
              "fontStyle": "bold"
            }
          }
        ]
      }
    },
```

## Fonts
    // "editor.fontFamily": "Consolas, 'Courier New', monospace",
    "editor.fontFamily": "JetBrains Mono", // From https://github.com/JetBrains/JetBrainsMono
    "editor.fontLigatures": true, // Enables joint symbols, like => and === in one glyph


## Recover deleted file or overwritten changes

VS code keeps track of file history, so [you can recover deleted or overwritten files](https://stackoverflow.com/a/72706798/1400490).  

In WSL, look into `~/.vscode-server/data/User/History`. In Windows, look into `%APPDATA%\Code\User\History`. 

Sort by date modified to find the most recent version of the file.

## Search and replace regex
Press ctrl+f to open search bar, then click the .* button to enable regex search.

The regex is apparently the ["Visual studio" flavor](https://learn.microsoft.com/en-us/previous-versions/visualstudio/visual-studio-2012/2k3te2cs(v=vs.110)?redirectedfrom=MSDN). The highlight selection is here:

| Character                           | Description                                                                                                                                                                                                                                   |
| ----------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `.`                                 | Matches any single character except a newline character.                                                                                                                                                                                      |
| `*`                                 | [Greedy](https://www.regular-expressions.info/repeat.html)-matches the preceding element zero or more times.                                                                                                                                  |
| `.*`                                | Matches any character *zero* or more times.                                                                                                                                                                                                   |
| `+`                                 | Greedy-matches the preceding element *one* or more times.                                                                                                                                                                                     |
| `?`                                 | Make the preceding quantifier lazy, e.g. `.*?` or `.*?`                                                                                                                                                                                       |
| `\`                                 | Escapes a special character.                                                                                                                                                                                                                  |
| `^`                                 | Matches the beginning of the string or line.                                                                                                                                                                                                  |
| `$`                                 | Matches the end of the string or line.                                                                                                                                                                                                        |
| `[abcd0-9]`                         | Matches any single character in the specified set of characters. Can use ranges, such as `0-9` or `a-z`                                                                                                                                       |
| `[^abcd0-9]`                        | Matches any single character **not** in the specified set of characters.                                                                                                                                                                      |
| `\|`                                | Matches either the expression before or after the operator.                                                                                                                                                                                   |
| `()`                                | Groups a series of pattern elements to a single element.                                                                                                                                                                                      |
| `()` and `$1` (and `$2`, `$3`, ...) | Used in find and *REPLACE* to keep part of the matched pattern in the replaced text. For example, `([0-9]+)_img` matches `01_img` and `02_img` but not `_img`. To replace these with `01_fig` and `02_fig`, use `$1_fig` in the replace field |

And some special characters:
| Character | Description                 |
| --------- | --------------------------- |
| `\w`      | Matches any word character. |
| `\b`      | Matches a word boundary.    |
| `\d`      | Matches any decimal digit.  |

However, perl syntax for [lookahead and lookbehind](https://www.regular-expressions.info/lookaround.html) also seems to work:

### Lookahead and lookbehind

| Character                         | Description                                                                                             |
| --------------------------------- | ------------------------------------------------------------------------------------------------------- |
| `some_regex(?=lookahead_regex)`   | Positive lookahead. Matches `some_regex` element only if it is followed by `lookahead_regex`.           |
| `(?<=lookbehind_regex)some_regex` | Positive lookbehind. Matches `some_regex` element only if it is preceded by `lookbehind_regex`.         |
| `some_regex(?!lookahead_regex)`   | Negative lookahead. Matches `some_regex` element only if it is **not** followed by `lookahead_regex`.   |
| `(?<!lookbehind_regex)some_regex` | Negative lookbehind. Matches `some_regex` element only if it is **not** preceded by `lookbehind_regex`. |

Example:

`(?<!\\)MDP` - matches only `MDP`, not `\MDP`. This only looks with "lookbehind" and not the "lookeahead" since the slash has to be looked up *behind* the `MDP` when reading the text from left to right.

[Note](https://www.regular-expressions.info/lookaround.html) that lookaround are "assertions" and do not consume characters in the string. The are also discarded after evaluatin, so e.g. `a(?=b)c` will **NOT** match `ac` in `abc` because after evaluating the match for `(?=b)`, the result is discarded and continoues with matching `c` to the `b` in the `abc`.

Also, when regex engine does it's thing, when processing string with lookbehind, the lookbehind is evaluated *first* and only then is the following regex matched, not the other way around.

### Useful Examples

- `(?<!\\)MDP` - matches only `MDP`, not `\MDP`

- To replace `$math$` with `\(math\)`:
  - Find: `(\$)([^$\r]+)(\$)`
  - Replace: `\($2\)`
- To replace `$$math$$` with `\[math\]`
  - Find: `(\$\$)([^$\r]+)(\$\$)`
  - Replace: `\[$2\]`
  - See regex101 for an [explanation](https://regex101.com/r/quNvo3/1).
  - The `\r` is for [multiline](https://stackoverflow.com/a/41151078/1400490) math in VS Code. 

