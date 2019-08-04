# Paracomm: Paragraph Motions in Comments

This overrides the `{` and `}` motions as well as the `ip` and `ap` text
objects to work with paragraphs within comments.  The behavior when the
cursor is outside of a comment is unchanged.

Paracomm depends on syntax highlighting being on to work.

## Installation

Install using your favorite plugin manager.  With vim-plug:

```vim
Plug 'bkoropoff/paracomm.vim'
```

## Configuration

Paracomm automatically installs itself into buffers for [supported
filetypes](plugin/paracomm.vim).  To disable this behavior:

```vim
let g:paracomm_disable = 1
```

You can manually set up paracomm for the current buffer by calling
`paracomm#install` with a list of syntax items representing comments for the
filetype.  [See here](plugin/paracomm.vim) for examples.
