local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Telescope find files in git" })

vim.keymap.set("n", "<leader>ps", function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end, { desc = "Grep for string with Telescope" })

vim.keymap.set("n", "<leader>bb", "<cmd>Telescope buffers<CR>", {
	noremap = true,
	silent = true,
	desc = "Browse open buffers",
})

vim.keymap.set("n", "<leader>pd", require("telescope.builtin").diagnostics, { desc = "Show diagnostics" })

vim.keymap.set("n", "<leader>pq", function()
	builtin.quickfix()
end, { desc = "Show quickfix with Telescope" })

vim.keymap.set("n", "<leader>m", function()
	vim.cmd("make")

	local qf = vim.fn.getqflist()
	local diagnostics_by_buf = {}
	local ns = vim.api.nvim_create_namespace("make_qf")

	for _, item in ipairs(qf) do
		if item.valid == 1 and item.bufnr and item.lnum > 0 then
			diagnostics_by_buf[item.bufnr] = diagnostics_by_buf[item.bufnr] or {}
			table.insert(diagnostics_by_buf[item.bufnr], {
				lnum = item.lnum - 1,
				col = (item.col > 0 and item.col - 1) or 0,
				message = item.text,
				severity = vim.diagnostic.severity.ERROR,
				source = "make",
			})
		end
	end

	for bufnr, diags in pairs(diagnostics_by_buf) do
		vim.diagnostic.set(ns, bufnr, diags, {})
	end

	builtin.quickfix()
end, { desc = "Run make and show diagnostics with Telescope" })
