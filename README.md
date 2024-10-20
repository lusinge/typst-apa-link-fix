# Collection of Typst templates

All templates/works in this repository are made by me under my free time, and licensed under the MIT License.

## Usage

To use a template from this project, simply copy/clone the contents.

### Cloning or Using Submodules

You can clone the whole repository inside your working directory/project and use the template as:

```sh
git clone https://github.com/jassielof/typst-templates.git template
```

This method won't let you upload your project because it will be a cloned repository, you can either remove the `.git/` directory, but this won't let you update the template for any future changes.

In that case, you can use a submodule:

```sh
git submodule add https://github.com/jassielof/typst-templates.git template
```

This will let you update the template by running `git submodule update --remote --merge` inside the `template/` directory.
And also upload your project as a git repository without any conflicts.
The repository will appear as a reference git repository in your project.

### Typst Universe
