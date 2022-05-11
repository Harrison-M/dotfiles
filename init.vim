set nocompatible
set hidden
syntax enable
set background=dark

set cmdheight=2
set updatetime=300

let mapleader = "\<Space>"

call plug#begin(stdpath('data') . '/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Plug 'clojure-vim/async-clj-omni'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fireplace'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
Plug 'morhetz/gruvbox'
" Plug 'Galooshi/vim-import-js'
" Plug 'yuezk/vim-js'
" Plug 'maxmellon/vim-jsx-pretty'
Plug 'Yggdroot/indentLine'
Plug 'scrooloose/nerdcommenter',
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
" Plug 'moll/vim-node'
Plug 'vim-scripts/paredit.vim'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-rhubarb'
Plug 'rust-lang/rust.vim'
Plug 'mhinz/vim-startify'

" Telescope and related
Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'fannheyward/telescope-coc.nvim'

Plug 'ternjs/tern_for_vim'
Plug 'kien/rainbow_parentheses.vim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'dhruvasagar/vim-table-mode'
" Plug 'leafgarland/typescript-vim'

call plug#end()

set termguicolors
colorscheme gruvbox
let g:gruvbox_contrast_light = 'medium'
let g:gruvbox_contrast_dark = 'medium'

" coc
let g:coc_filetype_map = {
    \ 'tsx': 'typescriptreact',
    \ 'stories.tsx': 'typescriptreact',
\ }

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> <C-w>gd :<C-u>call CocAction('jumpDefinition', 'tab drop')<cr>
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nmap <leader>rf <Plug>(coc-refactor)
nmap <leader>rn <Plug>(coc-rename)

" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Function and class text objects
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Diagnostic list
nnoremap <silent><nowait> <Leader>; :<C-u>CocList diagnostics<cr>

augroup tsgroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" coc-actions
"
" Remap for do codeAction of selected region
function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction
xmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>ac <Plug>(coc-codeaction)
nmap <leader>A <Plug>(coc-codeaction-selected)l

" CocLists
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
nnoremap <silent> <space>t  :<C-u>CocList outline<cr>
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>

" ctrl-p
" let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" coc completion/old deoplete stuff
" let g:deoplete#enable_at_startup = 1
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
inoremap <expr><C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr><C-k> pumvisible() ? "\<C-p>" : "\<C-k>"
" inoremap <expr><BS> deoplete#smart_close_popup()."\<C-h>"
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" coc other
autocmd CursorHold * silent call CocActionAsync('highlight')

" fireplace
nnoremap <buffer> <silent> <Leader>e :Eval<CR>
nnoremap <buffer> <silent> <Leader>E :%Eval<CR>

" fzf
nmap <Leader>g :Ag <C-r><C-w><CR>
nmap <C-p> :Files<CR>
nmap <Leader>o :GFiles<CR>
nmap <Leader>w :Buffers<CR>

" rust
let g:rustfmt_autosave = 1

" telescope
lua << EOF
require("telescope").load_extension('coc')
EOF

set autoindent
set autoread
set backspace=2
set backupcopy=yes
set encoding=utf-8
set expandtab " expand tabs to spaces
set foldmethod=syntax
set foldlevelstart=99
set ignorecase " case-insensitive search
set incsearch " search as you type
set laststatus=2 " always show statusline
set list " show trailing whitespace
set listchars=tab:▸\ ,trail:▫
set number " show line numbers
set ruler " show where you are
set scrolloff=3 " show context above/below cursorline
set shiftwidth=4 " normal mode indentation commands use 2 spaces
set showcmd
set smartcase " case-sensitive search if any caps
set softtabstop=4
set tabstop=4
set smartindent
set wildignore=log/**,node_modules/**,target/**,tmp/**,*.rbc
set wildmenu " show a navigable menu for tab completion
set wildmode=longest,list,full

set mouse=a

map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Select last selection/paste
map gp `[v`]

" My leader things (plugin-related ones defined in plugin sections):
" a: Coc action menu (requires selection or navigation)
" A: Coc action menu for current location
" b: move tab backward
" c: Coc command list
" f: move tab forward
" g: fzf :Ag command
" j: CocNext
" l: open location list
" k: CocPrev
" m: run macro
" n: remove search highlights
" o: fzf Git files
" p: paste from clipboard
" s: Coc symbol search
" S: save the contents of default register to a char register
" t: Open Coc outline
" w: fzf buffers
" y: yank to system clipboard
" ;: CocDiagnostics
nmap <Leader>b :tabmove -<CR>
nmap <Leader>f :tabmove +<CR>
nmap <Leader>l :lw<CR>
nnoremap <Leader>m @
nmap <Leader>n :noh<CR>
nnoremap <Leader>S :call setreg(nr2char(getchar()), @")<cr>
nnoremap <Leader>y "+y
vnoremap <Leader>y "+y
nnoremap <Leader>p "+p<CR>
vnoremap <Leader>p "+p<CR>
nnoremap <Leader>P "+P<CR>
vnoremap <Leader>P "+P<CR>

" Other QOL
nmap Y y$

command! Nterminal new term://$SHELL
command! Tterminal tabnew term://$SHELL
command! Vterminal vnew term://$SHELL

tnoremap <Esc> <C-\><C-n>

let g:startify_custom_header_quotes = [
    \ ["ARMY: your nickname reflects poorly on us all. we're changing it to something like \"raven\" or \"switchknife\"", 'ME: no. "hostage killer" is good'],
    \ ['if your grave doesnt say "rest in peace" on it you are automatically drafted into the skeleton war'],
    \ ['the pursuit of having trhe nicest opinions online... is the only thing that separates us from the god damn animals. the sole reason we exist'],
    \ ['THERAPIST: your problem is, that youre perfect, and everyone is jealous of your good posts, and that makes you rightfully upset.', 'ME: I agree'],
    \ ['Food $200', 'Data $150', 'Rent $800', 'Candles $3,600', 'Utility $150', 'someone who is good at the economy please help me budget this. my family is dying'],
    \ ['it is with a heavy heart that i must announce that the celebs are at it again'],
    \ ['awfully bold of you to fly the Good Year blimp on a year that has been extremely bad thus far'],
    \ ['"im not owned!  im not owned!!", i continue to insist as i slowly shrink and transform into a corn cob'],
    \ ['IF THE ZOO BANS ME FOR HOLLERING AT THE ANIMALS I WILL FACE GOD AND WALK BACKWARDS INTO HELL'],
    \ ['its the weekend baby. youknow what that means.  its time to drink precisely one beer and call 911'],
    \ ['"Is Wario A Libertarian" - the greatest thread in the history of forums, locked by a moderator after 12,239 pages of heated debate,'],
    \ ['THE COP GROWLS "TAKE OFF TH OSE JEANS, CITIZEN." I COMPLY, REVEALING THE FULL LENGTH DENIM TATTOOS ON BOTH LEGS. THE COP SCREAMS; DEFEATED'],
    \ ['blocked. blocked. blocked. youre all blocked. none of you are free of sin'],
    \ ["joke's on you; i actually love being body slammed by one dozen perfect wrestlers. and my mouth isn't filled with bloodm, it's victory wine"],
    \ ['the numa numa man just bougt a $70million house and im here at the library trying to photocopy a fruit roll up'],
    \ ['koko the talking ape.. has been living high on the hog, wasting our tax dollars on high capacity diapers. No more. i will suplex that beast,'],
    \ ["Politic's is back baby. It's good again. Awoouu (wolf Howl)"],
    \ ['so long suckers! i rev up my motorcylce and create a huge cloud of smoke. when the cloud dissipates im lying completely dead on the pavement'],
    \ ['im afraid i must say that i do not find the mysteries featured on "scooby-doo" challenging enough .'],
    \ ['my friend the only crypto currency you wanna get your hands on is this: bird seed. There is a lot of birds and they all gotta eat'],
    \ ['playing the worlds most normal sized violin'],
    \ ['ive never normalized a thing in my life'],
    \ ['my 125 IQ growth hormone consultant and legal conservator has confirmed to me that they are going to make the 2022 hyundai sonata "WOKE"'],
    \ ['we are living in a culture where you can be punished just for being Dr. Phil'],
    \ ['eating a single Dorito on a bed of Jasmine Rice'],
    \ ['Leut me make this clear: gloves are Next-Gen mittens , mittens are trash, i will never wear a mitten, i will take down anyone whos mad at me'],
    \ ['enya on full blast.. accessing 100 sites per minute'],
    \ ['i shall not be attending boys night, as i have injured myself while attempting to butterfly an auntie annes pretzel stick .'],
    \ ['my repulsive cohorts and I are searching the woods for tree sap so we can rub it all over our hands and improve our golf grip'],
    \ ['priest plugs my coffin in at the end of the funeral. "MILLERTIME" lights up in neon on the side, desecrating my corspe & sending me to hell'],
    \ ['LISTEN UP NERD, THE WEIGHTS WITH HIEROGLYPHS ON THEM ARE IMPOSSIBLE TO LIFT UNLESS YOU POSSESS THE CORRESPONDING RUNESTONE, THIS IS HELL GYM'],
    \ ['the vatican should not be allowed to name any new saints until God sorts out my numerous issues with the citibank web portal'],
    \ ["in a world where big data threatens to commodify our lives,. telling online surveys that i \"Don't Know\" what pringles are constitutes Heroism"],
    \ ['buy shares in the Markets.  i have a really good feeling about the markets']
    \ ]

set exrc
set secure
