
-- Get a prompt as input, then copy Prompt with the entire buffer and open Windsurf chat in browser
vim.keymap.set("n", "<leader>w", function()
  local prompt = vim.fn.input("Prompt for Windsurf Chat: ")
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local code = table.concat(lines, "\n")
  local filetype = vim.bo.filetype
  local message = string.format("%s\n\n```%s\n%s\n```", prompt, filetype, code)
  vim.fn.setreg("+", message)
  vim.cmd("Codeium Chat")
end, { desc = "Prompt + buffer to Windsurf Chat" })

vim.keymap.set("v", "<leader>w", function()
  local prompt = vim.fn.input("Prompt for Windsurf Chat: ")
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  local lines = vim.api.nvim_buf_get_lines(0, start_pos[2] - 1, end_pos[2], false)
  local code = table.concat(lines, "\n")
  local filetype = vim.bo.filetype
  local message = string.format("%s\n\n```%s\n%s\n```", prompt, filetype, code)
  vim.fn.setreg("+", message)
  vim.cmd("Codeium Chat")
end, { desc = "Prompt + selection to Windsurf Chat" })

