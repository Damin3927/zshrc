vim.cmd([[
let g:arch = system('uname -m')

" vim-plug
call plug#begin()

" fugitive
Plug 'tpope/vim-fugitive'

" fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'

" far.vim
Plug 'brooth/far.vim'

" enable :GBrowse
Plug 'tpope/vim-rhubarb'

" trailing-whitespace
Plug 'bronson/vim-trailing-whitespace'

" Rust
Plug 'rust-lang/rust.vim'

" zig
Plug 'ziglang/zig.vim'

" Svelte
Plug 'evanleck/vim-svelte', {'branch': 'main'}

" Go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Protobuf
Plug 'uarun/vim-protobuf'

" Kotlin
Plug 'udalov/kotlin-vim'

" nvim-notify
Plug 'rcarriga/nvim-notify'

" libraries
Plug 'nvim-lua/plenary.nvim'

" devicons
Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-telescope/telescope.nvim'

" bufferline
Plug 'akinsho/bufferline.nvim', { 'tag': 'v2.*' }

" scrollbar
Plug 'petertriho/nvim-scrollbar'

" color scheme
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }

" transparent
Plug 'xiyaowong/nvim-transparent'

" color code colorizer
Plug 'norcalli/nvim-colorizer.lua'

" % extension
Plug 'andymass/vim-matchup'

" Rust crates
Plug 'nvim-lua/plenary.nvim'
Plug 'saecki/crates.nvim'

" dasbboard
Plug 'goolord/alpha-nvim'

" bclose
Plug 'rbgrouleff/bclose.vim'

" test runner
Plug 'vim-test/vim-test'

" racket
Plug 'wlangstroth/vim-racket'

" uuid
Plug 'kburdett/vim-nuuid'

" asm support
Plug 'shirk/vim-gas'

" terraform
Plug 'hashivim/vim-terraform'

" Swift
Plug 'keith/swift.vim'

" mdx
Plug 'jxnblk/vim-mdx-js'

" Quickrun
Plug 'thinca/vim-quickrun'

" Astro
Plug 'wuelnerdotexe/vim-astro'


call plug#end()


""" Fern
" Show hidden files
let g:fern#default_hidden=1

" Show file true with <C-n>
nnoremap <C-n> :Fern . -drawer -reveal=%<CR>

" Set fern renderer to nerdfont
let g:fern#renderer = "nerdfont"

" See a file preview with p
function! s:fern_settings() abort
  nmap <silent> <buffer> p     <Plug>(fern-action-preview:toggle)
  nmap <silent> <buffer> <C-p> <Plug>(fern-action-preview:auto:toggle)
  nmap <silent> <buffer> <C-d> <Plug>(fern-action-preview:scroll:down:half)
  nmap <silent> <buffer> <C-u> <Plug>(fern-action-preview:scroll:up:half)
endfunction

augroup fern-settings
  autocmd!
  autocmd FileType fern call s:fern_settings()
augroup END

""" Fugitive
nnoremap [fugitive] <Nop>
nmap <Leader>i [fugitive]
nnoremap <silent> [fugitive]s :G<CR><C-w>T
nnoremap <silent> [fugitive]a :Gwrite<CR>
nnoremap <silent> [fugitive]w :w<CR>
nnoremap <silent> [fugitive]c :G commit<CR>
nnoremap <silent> [fugitive]d :Gdiff<CR>
nnoremap <silent> [fugitive]h :G diff --cached<CR>
nnoremap <silent> [fugitive]m :G blame<CR>
nnoremap <silent> [fugitive]p :G push<CR>
nnoremap <silent> [fugitive]l :G pull<CR>
nnoremap <silent> [fugitive]b :GBranches<CR>
nnoremap <silent> [fugitive]g V:GBrowse<CR>


""" Tab keybindings
" ref: https://qiita.com/wadako111/items/755e753677dd72d8036d
" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2

" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    t [Tag]
" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor

map <silent> [Tag]t :tablast <bar> tabnew<CR>
" tt open a new tab
map <silent> [Tag]x :tabclose<CR>
" tx close a tab
map <silent> [Tag]n :tabnext<CR>
" tn jump to the next tab
map <silent> [Tag]p :tabprevious<CR>
" tp jump to the previous tab

""" fzf
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)
nnoremap [fzf] <Nop>
nmap <Leader>f [fzf]
" TODO: Replace with Telescope
nnoremap <silent> [fzf]h :<C-u>Telescope oldfiles<CR>
nnoremap <silent> [fzf]b :<C-u>Telescope buffers<CR>
nnoremap <silent> [fzf]f :<C-u>Telescope find_files<CR>
nnoremap <silent> [fzf]g :<C-u>Telescope git_files<CR>
nnoremap <silent> [fzf]c :<C-u>Commands<CR>
nnoremap <silent> [fzf]r :<C-u>Telescope live_grep<CR>
nnoremap <silent> [fzf]u :<C-u>Telescope grep_string<CR>


""" terminal
nnoremap <silent> <Leader>d :<C-u>sp <CR> :wincmd j <CR> :term<CR>
nnoremap <silent> <Leader>D :<C-u>vsp<CR> :wincmd l <CR> :term<CR>
nnoremap <silent> <Leader>s :term<CR>
tnoremap <C-[> <C-\><C-n>
autocmd TermOpen * startinsert


""" far.vim
let g:far#source = "rgnvim"
let g:far#enable_undo = 1
nnoremap [far-replace] <Nop>
nmap <Leader>r [far-replace]
nnoremap <silent> [far-replace]  :Farr<cr>
vnoremap <silent> [far-replace]  :Farr<cr>


""" nvim-notify
lua << EOF

local coc_status_record = {}

function coc_status_notify(msg, level)
  local notify_opts = { title = "LSP Status", timeout = 500, hide_from_history = true, on_close = reset_coc_status_record }
  -- if coc_status_record is not {} then add it to notify_opts to key called "replace"
  if coc_status_record ~= {} then
    notify_opts["replace"] = coc_status_record.id
  end
  coc_status_record = vim.notify(msg, level, notify_opts)
end

function reset_coc_status_record(window)
  coc_status_record = {}
end

local coc_diag_record = {}

function coc_diag_notify(msg, level)
  local notify_opts = { title = "LSP Diagnostics", timeout = 500, on_close = reset_coc_diag_record }
  -- if coc_diag_record is not {} then add it to notify_opts to key called "replace"
  if coc_diag_record ~= {} then
    notify_opts["replace"] = coc_diag_record.id
  end
  coc_diag_record = vim.notify(msg, level, notify_opts)
end

function reset_coc_diag_record(window)
  coc_diag_record = {}
end
EOF

function! s:DiagnosticNotify() abort
  let l:info = get(b:, 'coc_diagnostic_info', {})
  if empty(l:info) | return '' | endif
  let l:msgs = []
  let l:level = 'info'
   if get(l:info, 'warning', 0)
    let l:level = 'warn'
  endif
  if get(l:info, 'error', 0)
    let l:level = 'error'
  endif

  if get(l:info, 'error', 0)
    call add(l:msgs, ' Errors: ' . l:info['error'])
  endif
  if get(l:info, 'warning', 0)
    call add(l:msgs, ' Warnings: ' . l:info['warning'])
  endif
  if get(l:info, 'information', 0)
    call add(l:msgs, ' Infos: ' . l:info['information'])
  endif
  if get(l:info, 'hint', 0)
    call add(l:msgs, ' Hints: ' . l:info['hint'])
  endif
  let l:msg = join(l:msgs, "\n")
  if empty(l:msg) | let l:msg = ' All OK' | endif
  call v:lua.coc_diag_notify(l:msg, l:level)
endfunction

function! s:StatusNotify() abort
  let l:status = get(g:, 'coc_status', '')
  let l:level = 'info'
  if empty(l:status) | return '' | endif
  call v:lua.coc_status_notify(l:status, l:level)
endfunction

function! s:InitCoc() abort
  execute "lua vim.notify('Initialized coc.nvim for LSP support', 'info', { title = 'LSP Status' })"
endfunction

" notifications
autocmd User CocNvimInit call s:InitCoc()
autocmd User CocDiagnosticChange call s:DiagnosticNotify()
autocmd User CocStatusChange call s:StatusNotify()

""" devicons
lua << EOF
require'nvim-web-devicons'.setup {
 -- your personal icons can go here (to override)
 -- you can specify color or cterm_color instead of specifying both of them
 -- DevIcon will be appended to `name`
 override = {};
 -- globally enable default icons (default to false)
 -- will get overridden by `get_icons` option
 default = true;
}
EOF


""" bufferline
set termguicolors
lua << EOF
require("bufferline").setup{
  options = {
    offsets = {
      {
        filetype = "fern",
        text = "File Explorer",
        text_align = "left",
        separator = true,
      }
    },
    separator_style = "slant",
  }
}
EOF


""" scrollbar
lua require("scrollbar").setup()


""" color scheme
" Color scheme
colorscheme tokyonight-night


""" color code colorizer
lua require'colorizer'.setup()


""" Rust crates
lua require('crates').setup()


""" dashboard
lua require'alpha'.setup(require'alpha.themes.theta'.config)


""" test runner
" nnoremap <silent> <leader>t :<C-u>TestNearest<CR>
nnoremap <silent> <leader>T :<C-u>TestFile<CR>
nnoremap <silent> <leader>a :<C-u>TestSuite<CR>
nnoremap <silent> <leader>l :<C-u>TestLast<CR>
nnoremap <silent> <leader>g :<C-u>TestVisit<CR>


""" python location
let g:python3_host_prog = '~/.pyenv/shims/python3'


""" Telescope
lua << EOF
require("telescope").setup{
  pickers = {
    live_grep = {
      additional_args = function(opts)
        return {
          "--hidden",
          "--glob",
          "!**/.git/*",
        }
      end
    },
  },
}
EOF

"""volar
" set - as a keyword in vue file
autocmd Filetype vue setlocal iskeyword+=-


let g:chat_gpt_key=""


""" Astro
let g:astro_typescript = 'enable'
]])
