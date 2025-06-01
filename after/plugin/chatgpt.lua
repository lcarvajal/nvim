
-- ChatGPT
vim.keymap.set("n", "<leader>c", function()
  local prompt = vim.fn.input("Prompt for ChatGPT: ")
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local code = table.concat(lines, "\n")
  local filetype = vim.bo.filetype
  local message = string.format("%s\n\n```%s\n%s\n```", prompt, filetype, code)
  vim.fn.setreg("+", message)
  vim.fn.jobstart({ "open", "https://chat.openai.com" }, { detach = true }) -- macOS
end, { desc = "Prompt + buffer to ChatGPT in browser" })

vim.keymap.set("v", "<leader>c", function()
  local prompt = vim.fn.input("Prompt for ChatGPT: ")
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  local lines = vim.api.nvim_buf_get_lines(0, start_pos[2] - 1, end_pos[2], false)
  local code = table.concat(lines, "\n")
  local filetype = vim.bo.filetype
  local message = string.format("%s\n\n```%s\n%s\n```", prompt, filetype, code)
  vim.fn.setreg("+", message)
  vim.fn.jobstart({ "open", "https://chat.openai.com" }, { detach = true }) -- macOS
end, { desc = "Prompt + selection to ChatGPT in browser" })
