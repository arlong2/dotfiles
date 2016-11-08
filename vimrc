" vim: fdm=marker

" READ THIS FIRST {{{
" Hello, and thank you for using the best VimRC...in the world.
" There are a couple of things you'll need to do in order to make effective
" use of this configuration:
"
" 1) Install Vundle. This is simple: just run:
"	mkdir -p ~/.vim/bundle
"	git clone https://github.com/VundleVim/Vundle.vim ~/.vim/bundle
" 2) Set up YouCompleteMe. This requires doing the following:
"	cd ~/.vim/bundle/YouCompleteMe
"	python install.py --clang-completer
"	** You may omit the last argument if you don't want to have C-family
"	completion
" 3) (optional but highly recommended) Install ZShell.
"	brew install zsh
" 4) (If you want the golang tools) Set up Go tools
"	install go in some way
"	set up a $GOPATH environment variable
"	inside Vim, run :GoInstallBinaries
"
" Read through the entire file before proceeding, it's important to know what
" everything does, at least in general.
"
" Use `zc` and `zo` to close and open the folds in this file, things are
" arranged hierarchically and should be very easy to follow. If something is
" not well understood, it is a BUG. Please file a bug report on github.
"
" Thanks, and have fun!
" }}}

" PREAMBLE {{{
set nocompatible              " be iMproved, required by Vundle
filetype off                  " required by Vundle
set shell=/bin/zsh            " Replace with your favorite BASH-COMPATIBLE sh

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" }}}

" PLUGINZ {{{
" One of the plugins you should always have set up. Manages installation of
" plugins and manipulation of Vim's runtime path.
Plugin 'VundleVim/Vundle.vim'

" Provides a neat project drawer, accessible through :NERDTreeToggle
" TODO(gabe): keymaps
Plugin 'scrooloose/nerdtree'

" Provides that super-neat modeline at the bottom and top o the screen
Plugin 'vim-airline/vim-airline'

" A soothing colorscheme for angry people
Plugin 'josuegaleas/jay'

" The Tim Pope collection: provides lots of fancy features that Vim should
" just include at this point. Tim Pope is basically Bram Moolenaar 2.0.
" vim-fugitive: provides git integration through e.g. :Gstatus and :Gcommit
" Notes:
"	in Gstatus use the `-' key to stage/unstage a file.
Plugin 'tpope/vim-fugitive'
" vim-surround: too complicated to explain fully, but here's the gist: it
" allows you to manipulate the surroundings of a text object. For example,
" <word> => [word] by using the commands `cs<[' when cursor anywhere on word
Plugin 'tpope/vim-surround'
" Some sensible defaults that *definitely* should be part of Vim proper.
Plugin 'tpope/vim-sensible'
" Short version: gcc comments/uncomments lines. gc takes a motion/count.
Plugin 'tpope/vim-commentary'

" GitGutter gives you indicators on the left fringe ("gutter") of your 
" window telling you which lines have been changed.
Plugin 'airblade/vim-gitgutter'

" Turns out vim saves an awesome tree of your undo history. This plugin
" lets you visualize it.
Plugin 'mbbill/undotree'

" Repeatedly pressing `v' causes the region you're highlighting to
" expand. Just try it.
Plugin 'terryma/vim-expand-region'

" CtrlP is a fuzzy finder. Type to narrow down what you want to find and hit
" enter when you find it.
Plugin 'kien/ctrlp.vim'

" YouCompleteMe, the only decent autocomplete solution for Vim
" It's really not great, but there isn't anything better. This requires some
" additional setup on your part if you want to use all its features:
" basically, cd into ~/.vim/bundle/YouCompleteMe and then run `install.py
" --clang-completer` (omit the last arg if you don't need c-family completion)
Plugin 'Valloric/YouCompleteMe'

" Autocomplete parentheses and whatnot
Plugin 'jiangmiao/auto-pairs'

" Makes go support in Vim absolutely top-notch (literally better than any
" other language plugin I've ever seen)
Plugin 'fatih/vim-go'

" Better markdown support
Bundle 'gabrielelana/vim-markdown'

" Decent (if not excellent) syntax checker. Requires separate set up of
" external tools.
Bundle 'vim-syntastic/syntastic.git'

" Emmet: make HTTP not fucking unbearable to write in Vim
Bundle 'mattn/emmet-vim'

" }}}

" MORE PREAMBLE {{{
call vundle#end()            " required
filetype plugin indent on    " required
" }}}

" COLOR SCHEME {{{
" Yeah, no one actually codes without syntax highlighting, right?
syntax on

" Syntax highlighting: enable 256 colors and pick a theme
set t_Co=256 " because what the fuck terminal doesn't have 256 colors these
" days? It's not like I'm using a VT-100 or something
" This is where the actual theme is picked. Jay is sort of a molokai-flavoured
" opaque color scheme that looks really nice imho. But substitute your own as
" you want.
colorscheme jay
" }}}

" EDITOR OPTIONS {{{
" Tab stuff {{{
" Because 4-space tabs are god
set tabstop=4
set softtabstop=4
set shiftwidth=4
" And use real tabs, not that namby-pamby expandtab bullshit
set noexpandtab
" }}}

" Modeline customization {{{
set laststatus=2 " What the fuck does this even mean?
let g:airline#extensions#tabline#enabled = 1
" Disable fancy separators-looks better in terminal
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline_left_sep=''
let g:airline_right_sep=''
" Make Airline do some neat detection stuff
let g:airline_detect_modified=1
let g:airline_detect_paste=1
" }}}

" Splits {{{
" the only truly proper way to split things
set splitbelow
set splitright
" }}}

" Editing-related remaps {{{
" Note that these are mostly QoL stuff and cause vim builtins to behave
" properly. An explanation of each map should follow.

" Enable visual line navigation
nnoremap j gj
nnoremap k gk

" Make `Y' behave like its cousins, `D' and `R'
nnoremap Y y$

" Make jk act like <ESC> when in insert mode-easier than reaching up for the
" escape key.
inoremap jk <esc>
" }}}

" Disabling annoying features {{{
" I think everyone in the vim community hates how vim handles its backup
" files. So, an easy solution to avoid dealing with them is to dump them in
" /tmp, and that's what we're going to do.
set backupdir=/tmp//
set directory=/tmp//
" }}}

" Enabling neat features {{{
" ColorColumn is one of my favorite little features-light up a given column so
" that we know how long our lines are!
set colorcolumn=80
" Cursorline-see where your cursor is
set cursorline
" I really like line numbers. Sue me.
set nu
" Search options: highlight when we search things and search incrementally.
set hlsearch
set incsearch
set smartcase
" }}}

" Plugin-specific options {{{
" Syntastic {{{
" These are the recommended settings in Syntastic. I might update them with
" more stuff later.
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Checker definitions: need to define which checkers we want to use for each
" language.
let g:syntastic_go_checkers = ['go']
let g:syntastic_python_checkers = ['python', 'pylint']

" }}}
" }}}
" }}}

" MAGICAL AUTOMATION {{{
" Enabling modelines {{{
" Modelines are the neat little comments you can put in your files to make
" them override your vim's default settings. See the top of this file for
" examples, but basically know that Vim needs to see "vim: <stuff>" in the
" header of your file (the first 5 lines or so) for the settings to work.
set modeline
set modelines=5
" }}}

" autocmd groups {{{
" autocmd's (autocommands) are really neat. They allow for special commands to
" be run when files of certain types are opened. For example, if we're going
" to be opening a golang file, set the indentation differently because gofmt
" hates hard tabs (and puppies, probably).

" Python augroups to force basic pep8 formatting (more or less :-P)
au BufNewFile,BufRead *.py
			\ set tabstop=4 softtabstop=4 shiftwidth=4 textwidth=79
			\ expandtab autoindent fileformat=unix
" }}}

" Leader bindings {{{
" The leader key is a special key we define that can then be used to make lots
" of fun custom keybindings that are (pretty much) guaranteed to never collide
" with anything in any plugins. We'll map it to SPC.
let mapleader=" "
" Mappings based on leader. I like keeping these as mnemonic as possible, for
" example: ft for file tree, ut for undotree, etc.
nmap <leader>ft :NERDTreeToggle<CR>
nmap <leader>ut :UndotreeToggle<CR>
" Ctrl-w is an awkward keybinding in my humble opinion. Replace it with ldr-w
nmap <leader>w <C-w>
" Buffer nav-I learned these keybindings in my spacemacs days and I'm too lazy
" to change them now
nmap <leader>bn :bn<CR>
nmap <leader>bp :bp<CR>


" Remapping ctrlp to spc-f-f since ctrl-p has other meanings I like better
let g:ctrlp_map = '<leader>ff'
" }}}
" }}}

