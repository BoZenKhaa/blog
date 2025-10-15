# Builidng fancy github readme

Nice guide as a reminder of what to write in the text: https://coding-boot-camp.github.io/full-stack/github/professional-readme-guide

## Shields/badges
Shields or badges are the small images that you see in the Readme file. You can use shields.io to generate them. For example, the following code generates a badge for the license of the project:

```Markdown
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
```

However, you can build custom badges for e.g. a paper, dataset etc by customizing the shields link:
```url
https://img.shields.io/static/v1?label=<LABEL>&message=<MESSAGE>&color=<COLOR>&logo=logo=<LOGO>
```
where the logo and color can be selected using the simpleicons.org website. For example, the following code generates a badge for a arxiv paper and a zenodo dataset:

```Markdown
[![arXiv link](http://img.shields.io/badge/Paper-arXiv%3A2305.18859-B31B1B.svg?style=flat)](https://arxiv.org/abs/2305.18859)
[![Dataset DOI](https://img.shields.io/static/v1?label=Dataset&message=DOI%3A10.5281/zenodo.7986104&color=1682D4)](https://doi.org/10.5281/zenodo.7986104)
```

To use special characters, such as `:` or `<space>` in the message, you have to use the ["percent" encoding](https://developer.mozilla.org/en-US/docs/Glossary/percent-encoding). Some useful characters are:

| Character | Encoding |
|-----------|----------|
| `:`       | `%3A`    |
| `<space>` | `%20`    |
| `#`       | `%23`    |

## Unicode emojis
You can spice up the readme with unicode emojis. You can search emojis [here](https://unicodeplus.com/U+1F5C4). Example can be file and folder icons when describing directory structure, e.g. [here](https://github.com/aicenter/Ridesharing_DARP_instances).

## Directory tree builder
When discussing directory structure, it's nice to be able to display it in text mode. You can use https://tree.nathanfriend.io to do that.