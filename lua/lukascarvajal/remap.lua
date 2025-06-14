vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Open file explorer" })

vim.keymap.set("t", "<C-x>", function()
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true), "n", true)
    vim.cmd("wincmd k")
end, { noremap = true, silent = true, desc = "Exit terminal mode and switch to upper window" })

-- Elixir run
vim.keymap.set("n", "<leader>r", function()
    vim.cmd("w")
    local file = vim.fn.expand("%:p")

    local term_win = nil
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        if vim.bo[buf].buftype == "terminal" then
            term_win = win
            break
        end
    end

    if not term_win then
        vim.cmd("belowright split | terminal")
        term_win = vim.api.nvim_get_current_win()
    end

    local term_buf = vim.api.nvim_win_get_buf(term_win)
    local job_id = vim.b[term_buf] and vim.b[term_buf].terminal_job_id
    vim.api.nvim_win_set_cursor(term_win, { vim.api.nvim_buf_line_count(term_buf), 0 })

    if job_id then
        vim.fn.chansend(job_id, "elixir " .. file .. "\n")
    else
        print("❌ Could not get terminal job ID.")
    end
end, { desc = "Run Elixir script in terminal" })

-- Buffer
vim.keymap.set("n", "<leader>bn", "<cmd>bnext<CR>", { noremap = true, silent = true, desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", "<cmd>bprevious<CR>", { noremap = true, silent = true, desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bd", "<cmd>bd<CR>", { noremap = true, silent = true, desc = "Delete current buffer" })
vim.keymap.set(
    "n",
    "<leader>bw",
    "<cmd>bwipeout<CR>",
    { noremap = true, silent = true, desc = "Wipe buffer from buffer list" }
)
vim.keymap.set("n", "<leader>bl", "<cmd>ls<CR>", { noremap = true, silent = true, desc = "List all buffers" })
vim.keymap.set("n", "<leader>b", ":b ", { noremap = true, desc = "Switch to buffer by number or name" })

local augroup = vim.api.nvim_create_augroup("strdr4605", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "typescript", "typescriptreact" },
    group = augroup,
    callback = function()
        vim.opt_local.makeprg = "npx tsc --noEmit"
        vim.cmd("compiler tsc")
    end,
})

-- Diagnostics

vim.keymap.set("n", "<leader>cq", function()
    local ns = vim.api.nvim_create_namespace("make_qf")
    vim.diagnostic.reset(ns)
end, { desc = "Clear diagnostics from make" })

vim.keymap.set("n", "K", function()
    vim.diagnostic.open_float(nil, { scope = "line", focusable = false })
end, { desc = "Show diagnostic under cursor" })

vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })

-- Linter
vim.keymap.set(
    "n",
    "<leader>ef",
    ":silent !npx eslint --fix %<CR>:edit!<CR>",
    { noremap = true, silent = true, desc = "Fix current file with eslint --fix" }
)

-- System clipboard
vim.keymap.set({ "n", "v" }, "<leader>cy", [["+y]])
vim.keymap.set("n", "<leader>cY", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>cp", [["+p]])
vim.keymap.set("n", "<leader>cP", [["+P]])
