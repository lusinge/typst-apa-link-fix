# Versatile APA 7th Edition Template for Typst

APA 7th Edition template for Typst. This template is based on the official APA 7th Edition style guide and includes all the necessary elements for a research paper. It is designed to be versatile and can be used for any type of research paper, including essays, theses, and dissertations.

## Usage

To use this template, you can use the CLI tool:

```sh
typst init @preview/versatile-apa
```

### Features

The template allows you to easily create academic students for both student and professional versions of APA 7th Edition:

- Title page
- Abstract
- Localization:
  - English
  - Spanish
  - Portuguese
  - German
  - Italian
  - French
  - Dutch
- Headings
- Raw/computer code
- Math equations
- Appendices
  - Figure appendices with its own numbering
  - Appendices outline
  - Appendix numbering (disabled if it's only one appendix)
- References
- Quotation (short/block depending on word count)
- Figures and tables with notes:
  - General notes
  - Specific notes
  - Probability notes
- Lists
- Footnotes
- Authoring:
  - Automatic footnotes for author/affiliation
  - Author notes
  - ORCID

## Planned Features

As of now, the template is in its initial stages and will be updated with more features in the future. Some of the planned features include:

- **LaTeX `apa7` class full support**: This template is inspired by the `apa7` class in LaTeX, and it's planned to also include support for all 4 formats of APA (student, professional, journal, and manuscript).

## Known Issues and Limitations

- **Appendix figure numbering**: Works decently but not perfect, make use of the `appendix-figure` function. The numbering works good, but the figure supplement is the one that takes the heading number instead of the figure numbering, which causes the outline of figures to be inconsistent, for example having a figure `Figure B2` will be shown as `Figure B 2` in the outline. **You can manually modify the outline for those cases**, but for the consistency's sake, I added `joined-figure-numbering` in the `appendix`, which can be set to false for that `B 2` format for both figure and outline.

> The cause for the figure numbering to be part of the supplement was due to the fact that setting "A" for first figures bugged the numbering and caused it to count it as the numbering, so the figure numbering wouldn't be shown at all (thus, the numbering for the figure was like "A, B, ...")

## License

Package licensed under the MIT License. See the repository for more information.
