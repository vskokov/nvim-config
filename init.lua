-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

require("luasnip").config.set_config({ -- Setting LuaSnip config

  -- Enable autotriggered snippets
  enable_autosnippets = true,

  -- Use Tab (or some other key if you prefer) to trigger visual selection
  store_selection_keys = "<Tab>",
})

require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/LuaSnip/"})


vim.cmd[[

imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
smap <silent><expr> <Tab> luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : '<Tab>'

imap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'
smap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'


"------------------------------------------------------------------------------
" slime configuration
"------------------------------------------------------------------------------
let g:slime_target = 'tmux'
let g:slime_default_config = {"socket_name": "default", "target_pane": "{right-of}"}
let g:slime_dont_ask_default = 1


" Run cell for vim-slime
function! SendCell(pattern)
    let start_line = search(a:pattern, 'bnW')

    if start_line
        let start_line = start_line + 1
    else
        let start_line = 1
    endif

    let stop_line = search(a:pattern, 'nW')
    if stop_line
        let stop_line = stop_line - 1
    else
        let stop_line = line('$')
    endif

    call slime#send_range(start_line, stop_line)
endfunction

" Custom vim-slime mappings
let g:slime_no_mappings = 1
xmap <c-c><c-x> <Plug>SlimeRegionSendj
nmap <c-c><c-x> <Plug>SlimeLineSendj
nmap <c-c><c-c> :<c-u>call SendCell('^##')<cr>

]]
