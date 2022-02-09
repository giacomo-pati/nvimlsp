------------------------------------------------
-- Plugin: preservim/nerdtree
------------------------------------------------
local M = {}

function M.setup()
    -- vim.api.nvim_set_keymap('n', '<Leader>d', ':NERDTreeToggle<cr>', { noremap = true })
    vim.api.nvim_set_keymap('n', '<F2>', ':NERDTreeToggle<cr>', { noremap = true })

    -- Files to ignore
    vim.api.nvim_exec([[
        let NERDTreeIgnore = [
            \ '\~$',
            \ '\.pyc$',
            \ '^\.DS_Store$',
            \ '^node_modules$',
            \ '^.ropeproject$',
            \ '^__pycache__$'
        \]
    ]], false)

    -- Close vim if NERDTree is the only opened window.
    -- vim.cmd 'autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif'
    vim.cmd 'autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif'

    -- Show hidden files by default.
    vim.g.NERDTreeShowHidden = 1

    -- Allow NERDTree to change session root.
    vim.g.NERDTreeChDirMode = 2

    -- Close NERDTree window when a file has been selected
    -- vim.g.NERDTreeQuitOnOpen=1

    -- Allow NERDTree to show git status using NERDFonts.
    vim.g.NERDTreeGitStatusUseNerdFonts = 1
end

return M
