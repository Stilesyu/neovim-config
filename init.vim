"################################## 插件管理 ##################################
" 关闭文件类型自动检测功能,这个功能被filetype plugin indent on代替          
filetype off 

"设置vim-plug路径
call plug#begin('~/.vim/plugged')

"*************界面美化******************
"terminal下输入nvim,你将看到一个酷酷的启动界面
Plug 'mhinz/vim-startify'

"gruvbox 主题
Plug 'morhetz/gruvbox'

"vim-airline 底部状态栏优化
Plug 'bling/vim-airline'

"*************代码补全******************
"ncm2 代码补全
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'HansPinckaers/ncm2-jedi'

"jedi-vim 作用同样是代码补全,这里协助ncm2,仅开启方法参数提醒
Plug 'davidhalter/jedi-vim'

"*************效率工具*******************
"vim-autopep8,自动格式化
Plug 'tell-k/vim-autopep8'

"snipmate 模板补全----按tab键根据模板自动补全
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
" Optional:
Plug 'honza/vim-snippets'

"自动引号/括号
Plug 'jiangmiao/auto-pairs'


"*************其他工具******************
"nerdtree 文件树

Plug 'scrooloose/nerdtree'


call plug#end()
      




"##################################按键设置##################################

" F3 开启关闭文件树
nnoremap <F3> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" F6自动格式化
autocmd FileType python noremap <buffer> <F6> :call Autopep8()<CR>

" ctrl-j/k/l/h  分屏窗口移动 Normal mode
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l
nnoremap <C-h> <C-W>h

" F5 自动编译文件 Normal+Visual mode
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
        exec "w"
        if &filetype == 'c'
                exec "!g++ % -o %<"
                exec "!time ./%<"
        elseif &filetype == 'cpp'
                exec "!g++ % -o %<"
                exec "!time ./%<"
        elseif &filetype == 'java'
                exec "!javac %"
                exec "!time java %<"
        elseif &filetype == 'sh'
                :!time bash %
        elseif &filetype == 'python'
                exec "!clear":
                exec "!time python3 %"
        elseif &filetype == 'html'
                exec "!firefox % &"
        elseif &filetype == 'go'
                " exec "!go build %<"
                exec "!time go run %"
        elseif &filetype == 'mkd'
                exec "!~/.vim/markdown.pl % > %.html &"
                exec "!firefox %.html &"
        endif
endfunc

" ctrl+s 保存 	Insert mode
" linux默认情况下ctrl+s是锁定terminal,需要ctrl+q解锁.在.bashrc 设置 stty-ixon可以禁用
imap <C-s> <Esc>:w!<CR>i
"ctrl+a	全选+复制 Normal+Insert+visual mode
map <C-A> ggVG
map! <C-A> <Esc>ggVG
"ctrl+f 复制到系统粘贴板
map  <C-F> "+y
map! <C-F> "+y


"##################################插件设置##################################

" *********** NERDTree插件配置 ***********
" 默认打开NERDTree
let NERDTreeChDirMode=2                                         " 设置当前目录为nerdtree的起始目录
let NERDChristmasTree=1                                         " 使得窗口有更好看的效果
let NERDTreeMouseMode=1                                         " 双击鼠标左键打开文件
let NERDTreeWinSize=25                                          " 设置窗口宽度为25
let NERDTreeQuitOnOpen=1                                        " 打开一个文件时nerdtree分栏自动关闭
" 打开文件默认开启文件树
autocmd VimEnter * NERDTree


"******************auto format设置***************
"vim-autopep8设置,关闭diff提示
let g:autopep8_disable_show_diff=1

"******************ncm2 设置***************
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=menu,noinsert
set shortmess+=c
inoremap <c-c> <ESC>
" 延迟弹窗,这样提示更加流畅
let ncm2#popup_delay = 5
"输入几个字母开始提醒:[[最小优先级,最小长度]]
"如果是输入的是[[1,3],[7,2]],那么优先级在1-6之间,会在3个字符弹出,如果大于等于7,则2个字符抬出----优先级概念请参考文档中 ncm2-priority 
let ncm2#complete_length = [[1, 1]]

"模糊匹配模式,详情请输入:help ncm2查看相关文档
let g:ncm2#matcher = 'substrfuzzy'
"使用tab键向下选择弹框菜单
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>" 
"使用shift+tab键向上选择弹窗菜单,这里不设置因为笔记本比较难操作.如果向下太多我通常习惯使用Backspace键再重新操作一遍
"inoremap <expr> <S> pumvisible() ? "\<C-p>" : "\<S>"   



"****************jedi-vim设置*******************
let g:jedi#auto_initialization = 1
let g:jedi#completions_enabled = 0
"如果你想启用这个功能,auto_initialization必须开启
let g:jedi#show_call_signatures = 1



"#################################vim设置##################################
"************常规设置****************
"设置历史操作记录为1000条
set history=1000  
" 不启用vi的键盘模式,而是vim自己的
set nocompatible
" 语法高亮支持
syntax on
" 载入文件类型插件,代替filetype off 
filetype plugin indent on

"************搜索设置***************
" 搜索的时候不区分大小写,是set ignorecase缩写.如果你想启用,输入:set noic(noignorecase缩写)
set ic
" 搜索的时候随字符高亮
set hlsearch


"************编码设置***************
" 设置编码格式为utf-8
set encoding=utf-8
" 自动判断编码时,依次尝试下编码
set fileencodings=utf-8,ucs-bom,GB2312,big5

"************行和列设置***************
" 显示行横线
set cursorline
" 显示行号
set nu

"************缩进设置***************
" 自动套用上一行的缩进方式
set autoindent
" 开智能缩进
set smartindent
" 光标移动到buffer的顶部和底部保持4行继续
set scrolloff=4
" 当光标移动到一个括号时,高亮显示对应的另一个括号
set showmatch

" 对退格键提供更好帮助
set backspace=indent,eol,start   
"自动保存
let g:auto_save = 1
let g:auto_save_events = ["InsertLeave", "TextChanged", "TextChangedI", "CursorHoldI", "CompleteDone"]

"------------------- python 文件设置--------------------
" 开启语法高亮
let python_highlight_all=1
" 设定tab的格数为4
au Filetype python set tabstop=4
" 设置编辑模式下tab的宽度
au Filetype python set softtabstop=4
au Filetype python set shiftwidth=4
au Filetype python set textwidth=79
au Filetype python set expandtab
au Filetype python set autoindent
au Filetype python set fileformat=unix
autocmd Filetype python set foldmethod=indent
autocmd Filetype python set foldlevel=99






" ################################## 设置vim主题外观 ##################################
"set background=light                                           " 设置vim背景为浅色
set background=dark                                             " 设置vim背景为深色
set cursorline                                                  " 突出显示当前行
set cursorcolumn                                                " 突出显示当前列
colorscheme gruvbox                                             " 设置gruvbox高亮主题
" ************** vim的配色 **************
hi vertsplit ctermbg=bg guibg=bg
hi GitGutterAdd ctermbg=bg guibg=bg
hi GitGutterChange ctermbg=bg guibg=bg
hi GitGutterDelete ctermbg=bg guibg=bg
hi GitGutterChangeDelete ctermbg=bg guibg=bg
hi SyntasticErrorSign ctermbg=bg guibg=bg
hi SyntasticWarningSign ctermbg=bg guibg=bg
hi FoldColumn ctermbg=bg guibg=bg
" 插入模式下,光标变成细线
if has("autocmd")
  au VimEnter,InsertLeave * silent execute '!echo -ne "\e[2 q"' | redraw!
  au InsertEnter,InsertChange *
    \ if v:insertmode == 'i' | 
    \   silent execute '!echo -ne "\e[6 q"' | redraw! |
    \ elseif v:insertmode == 'r' |
    \   silent execute '!echo -ne "\e[4 q"' | redraw! |
    \ endif
  au VimLeave * silent execute '!echo -ne "\e[ q"' | redraw!
endif









" ####################################定义SetTitle，自动插入文件头##############################
func SetTitle()
    "如果文件类型为.sh文件
	if &filetype == ‘sh‘
         call setline(1,"\#########################################################################")

        call append(("."), "\# File Name: ".("%"))

         call append(line(".")+1, "\# Author: Stilesyu")

         call append(line(".")+2, "\# mail: yuxiaochen886@gmail.com")

     
    "call append((".")+3, "\# Created Time: ".strftime("%c"))
         call append(line(".")+3, "\# Created Time: ".strftime("%Y-%m-%d",localtime()))

         call append(line(".")+4, "\#########################################################################")

         call append(line(".")+5, "\#!/bin/bash")

         call append(line(".")+6, "")

     else

        call setline(1, "/*************************************************************************")

        call append(line("."), "    > File Name: ".("%"))

        call append(line(".")+1, "    > Author: YourName")

        call append(line(".")+2, "    > Mail: YourEmail ")

       " 同样的 改变时间格式
        "call append((".")+3, "    > Created Time: ".strftime("%c"))
        call append((".")+3, "    > Created Time: ".strftime("%Y-%m-%d",localtime()))

        call append((".")+4, " ************************************************************************/")

        call append(line(".")+5, "")

     endif

     if &filetype == ‘‘

        call append(line(".")+6, "#include<iostream>")

         call append(line(".")+7, "using namespace std;")

        call append(line(".")+8, "")

    endif

    if &filetype == ‘c‘

         call append(line(".")+6, "#include<stdio.h>")

       call append(line(".")+7, "")

    endif
 
   "新建文件后，自动定位到文件末尾
    autocmd BufNewFile * normal G
 endfunc

" Python自动插入文件标题
 autocmd BufNewFile *py exec ":call SetPythonTitle()"
 func SetPythonTitle()
  call setline(1,"# Copyright (c) StilesYu  All Rights Reserved.")
  call append(line("."), "\# File Name: ".("%"))
  call append(line(".")+1, "\# Author: Stiles Yu")
  call append(line(".")+2, "\# mail: yuxiaochen886@gmail.com")
  call append(line(".")+3,"\# github:https://github.com/Stilesyu")
  call append(line(".")+4,"\# blog:http://www.stilesyu.com/")
  call append(line(".")+5, "\# Created Time: ".strftime("%Y-%m-%d",localtime()))
 endfunc
"新建文件后，自动定位到文件末尾
 autocmd BufNewFile * normal G o
