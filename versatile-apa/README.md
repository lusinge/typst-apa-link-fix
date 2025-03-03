# Versatile APA 7th Edition Template for Typst

APA 7th Edition template for Typst. This template is based on the official APA 7th Edition style guide and includes all the necessary elements for a research paper. It is designed to be versatile and can be used for any type of research paper, including essays, theses, and dissertations.

## Usage

Usage is indicated in the Typst Universe page through the `typst` command for local or use the Typst Web App directly.

Otherwise, you can use git to clone the repository as a submodule. Check the README of this repository for more information.

### Features

The template allows you to easily create academic students for both student and professional versions of APA 7th Edition:

- Title page
- Abstract
- Headings
- Raw/computer code
- Math equations
- References
- Quotation (short/block depending on word count)
- Lists
- Footnotes

Aside:

#### Figures

Figures (images, tables, and math equations) are supported with the following features:

- General notes
- Specific notes
- Probability notes

For appendix figures, use the `appendix-figure` function (same parameters as `apa-figure`).

#### Language Support

- English
- Spanish
- Portuguese
- German
- Italian
- French
- Dutch

#### Appendice

- Figure appendices with its own numbering
- Appendices outline
- Appendix numbering (disabled if it's only one appendix)

#### Authoring

- Automatic footnotes/numbering for author/affiliation
- Author notes
- ORCID

## Regarding LaTeX

**LaTeX `apa7` class full support/port**: Heavily inspired by the `apa7` class in LaTeX (which is also based on the `apa6` class), *the `journal` and `document` format will not be ported due to styling and formatting variations, although is possible for me to port it (at least from the LaTeX one, I see no further use case other than just a journal format for not publishing, since I suppose that every APA-compliant journal has its own style*.

## Known Issues and Limitations

### Appendix Figure Numbering

Works decently but not perfect, make use of the `appendix-figure` function. The numbering works good, but the figure supplement is the one that takes the heading number instead of the figure numbering, which causes the outline of figures to be inconsistent, for example having a figure `Figure B2` will be shown as `Figure B 2` in the outline. **You can manually modify the outline for those cases**, but for the consistency's sake, I added `joined-figure-numbering` in the `appendix`, which can be set to false for that `B 2` format for both figure and outline.

> The cause for the figure numbering to be part of the supplement was due to the fact that setting "A" for first figures bugged the numbering and caused it to count it as the numbering, so the figure numbering wouldn't be shown at all (thus, the numbering for the figure was like "A, B, ...")

## License

Package licensed under the MIT License. See the repository for more information.
