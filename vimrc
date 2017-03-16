" vim: fdm=marker

" READ THIS FIRST {{{
" Hello, and thank you for using the best VimRC...in the world.
" There are a couple of things you'll need to do in order to make effective
" use of this configuration:
"
" 1) Install Vundle. This is simple: just run:
"	mkdir -p ~/.vim/bundle
"	git clone https://github.com/VundleVim/Vundle.vim ~/.vim/bundle
"	Note: This might work automagically now. NO GUARANTEES THOUGH.
" 2) Open Vim and run :PluginInstall to install all the plugins needed.
"	Note: This might work automagically now. NO GUARANTEES THOUGH.
" 3) Set up YouCompleteMe. This requires doing the following:
"	cd ~/.vim/bundle/YouCompleteMe
"	python install.py --clang-completer
"	** You may omit the last argument if you don't want to have C-family
"	completion and/or you hate puppies
" 4) (optional but highly recommended) Install ZShell.
"	brew install zsh
" 5) (If you want the golang tools) Set up Go tools
"	install go in some way
"	set up a $GOPATH environment variable
"	inside Vim, run :GoInstallBinaries
" 6) Install ag. Install ctags. Both are insanely useful, you won't regret it.
" 7) (If you want python syntax checks) install pylint and pylint-django
" 8) (If you want Ruby syntax checks) install rubocop
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

" AUTO-SETUP MAGICS {{{
" We'll detect which vim derivative we're using (vim vs. nvim)
if has('nvim')
	" and set the path to the config root
	let s:editor_root=expand("~/.config/nvim")
else
	let s:editor_root=expand("~/.vim")
endif

" Then we can set up Vundle
let s:vundle_installed=1
let s:vundle_readme=s:editor_root . '/bundle/Vundle.vim/README.md'
if !filereadable(s:vundle_readme)
	echo "Installing Vundle, please wait!"
	echo ""
	silent call mkdir(s:editor_root . '/bundle', "p")
	silent execute "!git clone https://github.com/VundleVim/Vundle.vim " . s:editor_root . "/bundle/Vundle.vim"
	let s:vundle_installed=0
endif
let s:vundle_path=s:editor_root . '/bundle/Vundle.vim'
let &rtp = &rtp . ',' . s:editor_root . '/bundle/Vundle.vim'
call vundle#rc(s:editor_root . '/bundle')
" }}}

" PREAMBLE {{{
set nocompatible              " be iMproved, required by Vundle
filetype off                  " required by Vundle
set shell=/bin/zsh            " Replace with your favorite BASH-COMPATIBLE sh
set t_ut=                     " Fix background color issues in Tmux
" }}}

" PLUGINZ {{{
" One of the plugins you should always have set up. Manages installation of
" plugins and manipulation of Vim's runtime path.
Plugin 'VundleVim/Vundle.vim'

" Provides a neat project drawer, accessible through :NERDTreeToggle or <spc>ft
Plugin 'scrooloose/nerdtree'
" Makes NERDTree a little easier to use
Plugin 'jistr/vim-nerdtree-tabs'

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

" Provides automagical completion for C languages (that use Makefiles)
Plugin 'rdnetto/YCM-Generator'

" Autocomplete parentheses and whatnot
Plugin 'jiangmiao/auto-pairs'

" Makes go support in Vim absolutely top-notch (literally better than any
" other language plugin I've ever seen)
Plugin 'fatih/vim-go'

" Rust plugin. I can't live without autoformat and colors...
Plugin 'rust-lang/rust.vim'

" Haskell support plugins
Plugin 'bitc/vim-hdevtools'

" Python-mode, decent python language support.
Plugin 'python-mode/python-mode'

" Better markdown support
Plugin 'gabrielelana/vim-markdown'

" Decent (if not excellent) syntax checker. Requires separate set up of
" external tools.
Plugin 'vim-syntastic/syntastic.git'

" Emmet: make HTTP not fucking unbearable to write in Vim
Plugin 'mattn/emmet-vim'

" Search plugin. Use with ack or ag to supercharge code search. (Note:
" requires ack or ag)
Plugin 'mileszs/ack.vim'

" easytags-always updates your ctags in the background.
Plugin 'xolox/vim-easytags'
" Dependency for easytags
Plugin 'xolox/vim-misc'
" Tagbar, a really nice way to view ctags. Toggle with <spc>tt
Plugin 'majutsushi/tagbar'
" A plugin for Godot engine's syntax. It ain't fancy but it's good enough.
Plugin 'a-watson/vim-gdscript'

" A plugin for distraction-free writing.
Plugin 'junegunn/goyo.vim'

" A minimap sublime-style. It's kinda silly, but I like it.
Plugin 'severin-lemaignan/vim-minimap'

" easymotion. type spc-spc-w and see what happens.
Plugin 'easymotion/vim-easymotion'

" }}}

" MORE PREAMBLE {{{
call vundle#end()            " required

if !s:vundle_installed
	echo "Installing plugins..."
	echo ""
	execute "PluginInstall"
endif

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
set background=dark
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

" Scrolloff: prevent the cursor from moving more than 5 lines close to the
" screen boundaries
" Play around with it on a long file and you'll see what I mean
set scrolloff=5
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
			\ set tabstop=4 softtabstop=4 shiftwidth=4 textwidth=80
			\ expandtab autoindent fileformat=unix

" Fix the horrible markdown defaults
au BufNewFile,BufRead *.md
			\ set textwidth=80 nospell

" Add auto save/reload pos in case your Vim doesn't already have support enabled
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" This is similar to the Python formatting, but I tend to like Groovy code
" with 2 space tabs for some reason.
au BufNewFile,BufRead *.groovy
			\ set tabstop=2 softtabstop=2 shiftwidth=2
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
nmap <leader>tt :TagbarToggle<CR>
" Ctrl-w is an awkward keybinding in my humble opinion. Replace it with ldr-w
nmap <leader>w <C-w>
" Buffer nav-I learned these keybindings in my spacemacs days and I'm too lazy
" to change them now
nmap <leader>bn :bn<CR>
nmap <leader>bp :bp<CR>
" Also add leader-based bindings for fuzzy buffer finding. (also a spacemacs
" holdover)
nmap <leader>bb :CtrlPBuffer<CR>

" Similar bindings to above for tabs
nmap <leader>tp :tabp<CR>
nmap <leader>tn :tabn<CR>

" Search binding: <spc>ag (isn't that cute)
nmap <leader>ag :Ack 

" Disabling syntastic with <spc>ss in situations where it's unacceptably slow
" or useless
nmap <leader>ss :SyntasticToggleMode<cr>

" Map <spc>e to the emmet functionality
nmap <leader>e <C-y>,

" Remapping ctrlp to spc-f-f since ctrl-p has other meanings I like better
" First completely unmap regular old ctrlp
let g:ctrlp_map = ''
" always ensures you're finding files from your current working directory
nmap <leader>ff :CtrlPCurWD<CR>
" But since the localdir version is sometimes useful...
nmap <leader>fF :CtrlP<CR>

" Adding a mapping for my custom :Insertdate function
nmap <leader>id :Insertdate<CR>I<BS> <ESC>$

" minimap shortcut
nmap <leader>mm :MinimapToggle<CR>
" }}}

" Custom functions {{{
" Some stuff I've whipped up or stolen from around teh internetz to make my
" life a little easier
command! -range -nargs=0 -bar JsonTool <line1>,<line2>!python -m json.tool
" Fixing yo typos
command! Q :q
command! Wq :wq
command! WQ :wq

command! Insertdate :r !date
" }}}
" }}}

" PLUGIN CUSTOMIZATION {{{
" Sometimes plugins don't work correctly. These are per-plugin customizations
" that (disclaimer) work on MY MACHINE AND MY MACHINE ONLY.
"
" Basically, here be dragons.

" YouCompleteMe {{{
" Mac OS X ships with a hilariously out of date python. Let's override it with
" the current one being used (i.e. python 3 or whatever is installed in your
" venv)
let g:ycm_python_binary_path='python'
let g:ycm_server_python_interpreter='python3'
" Fix for constantly being asked about using C completion. UNSAFE AND
" INSECURE. YOU SHOULDN'T DO THIS UNLESS YOU DON'T CARE ABOUT SECURITY.
" Related: run :YcmGenerateConfig in a C project to auto-generate C completion
" tool for YouCompleteMe
let g:ycm_confirm_extra_conf=0
" Rust settings. VERY machine specific, THIS WILL BREAK YOUR VIM IF YOU DON'T
" CHANGE IT.
let g:ycm_rust_src_path='~/.cargo/sources/rust-1.13.0/src'
" Fix Ruby completion
let g:ycm_seed_identifiers_with_syntax=1
" }}}

" Syntastic {{{
" Fix the behavior of warning me about every single fucking issue, and save
" error messages for only actual errors.
let g:syntastic_quiet_messages = { "level" : "warnings" }

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
" language. YOU HAVE TO INSTALL THESE, THAT'S NOT MY PROBLEM.
let g:syntastic_go_checkers = ['go']
let g:syntastic_python_checkers = ['python', 'pylint']
let g:syntastic_ruby_checkers = ['rubocop']

" Fix Django bullshit with Syntastic
let g:syntastic_python_pylint_args = "--load-plugins pylint_django"
" }}}

" ack.vim {{{
" Use ag if you have it. It's way faster than ack, you should get it.
if executable('ag')
	let g:ackprg = 'ag --vimgrep'
endif
" }}}

" vim-easytags {{{
" Attempts to improve performance
let g:easytags_syntax_keyword = 'always'
let g:easytags_async = 1
" }}}

" python-mode {{{
" Fix to use Python 3 by default. Usually a good thing to do.
let g:pymode_python='python3'
" Disable autocompletion; ycm does it better.
let g:pymode_rope_completion = 0
" }}}
" }}}

" ESOTERIC NONSENSE {{{
" Most of the stuff below is stuff I got from random places on the internet. It
" will likely change very frequently since it's mostly just silliness.

" Make the scroll wheel undo/redo changes
set mouse=a
map <ScrollWheelUp> <C-r>
map <ScrollWheelDown> u
" }}}
