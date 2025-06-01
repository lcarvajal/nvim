vim.g.mapleader = " "

-- Navigate to current directory
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set('t', '<C-x>', function()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-\\><C-n>', true, false, true), 'n', true)
  vim.cmd('wincmd k')  -- jump up window specifically
end, { noremap = true, silent = true, desc = "Exit terminal mode and switch to upper window" })

vim.keymap.set("n", "<leader>r", function()
  -- Save the current file
  vim.cmd("w")

  local file = vim.fn.expand("%:p")

  -- Try to find a terminal window
  local term_win = nil
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.bo[buf].buftype == "terminal" then
      term_win = win
      break
    end
  end

  -- If there's no terminal window, open one and move into it
  if not term_win then
    vim.cmd("belowright split | terminal")
    term_win = vim.api.nvim_get_current_win()
  end

  -- Get terminal buffer and job id
  local term_buf = vim.api.nvim_win_get_buf(term_win)
  local job_id = vim.b[term_buf] and vim.b[term_buf].terminal_job_id

  -- Scroll to bottom of terminal
  vim.api.nvim_win_set_cursor(term_win, {vim.api.nvim_buf_line_count(term_buf), 0})

  -- If we have a job id, send the Elixir command
  if job_id then
    vim.fn.chansend(job_id, "elixir " .. file .. "\n")
  else
    print("❌ Could not get terminal job ID.")
  end
end, { desc = "Run Elixir script in terminal" })

