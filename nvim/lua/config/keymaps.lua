local function prompt_motion(prefix)
  vim.ui.input({ prompt = prefix .. " " }, function(char)
    if char and char ~= "" then
      vim.api.nvim_input(prefix .. char)
    end
  end)
end

vim.keymap.set("n", "<leader>jf", function()
  prompt_motion("f")
end, { desc = "Jump to character forward" })

vim.keymap.set("n", "<leader>jF", function()
  prompt_motion("F")
end, { desc = "Jump to character backward" })

vim.keymap.set("n", "<leader>jt", function()
  prompt_motion("t")
end, { desc = "Jump before character forward" })

vim.keymap.set("n", "<leader>jT", function()
  prompt_motion("T")
end, { desc = "Jump before character backward" })

for _, item in ipairs({
  { key = '"', desc = "quotes" },
  { key = "'", desc = "single quotes" },
  { key = "(", desc = "parentheses" },
  { key = "[", desc = "brackets" },
  { key = "{", desc = "braces" },
}) do
  vim.keymap.set("n", "<leader>ci" .. item.key, "ci" .. item.key, { desc = "Change inside " .. item.desc })
  vim.keymap.set("n", "<leader>ca" .. item.key, "ca" .. item.key, { desc = "Change around " .. item.desc })
  vim.keymap.set("n", "<leader>di" .. item.key, "di" .. item.key, { desc = "Delete inside " .. item.desc })
  vim.keymap.set("n", "<leader>da" .. item.key, "da" .. item.key, { desc = "Delete around " .. item.desc })
end

vim.keymap.set("n", "<leader>n%", "%", { desc = "Jump to matching pair" })
vim.keymap.set("n", "<leader>n*", "*", { desc = "Search word under cursor" })
vim.keymap.set("n", "<leader>nzz", "zz", { desc = "Center cursor" })
vim.keymap.set("n", "<leader>nzt", "zt", { desc = "Cursor to top" })
vim.keymap.set("n", "<leader>nzb", "zb", { desc = "Cursor to bottom" })
vim.keymap.set("n", "<leader>no", "<C-o>", { desc = "Backward in jumplist" })
vim.keymap.set("n", "<leader>ni", "<C-i>", { desc = "Forward in jumplist" })

vim.keymap.set("n", "<leader>uu", function()
  require("neotest").run.run()
end, { desc = "Run nearest test" })

vim.keymap.set("n", "<leader>uf", function()
  require("neotest").run.run(vim.fn.expand("%"))
end, { desc = "Run file tests" })

vim.keymap.set("n", "<leader>us", function()
  require("neotest").summary.toggle()
end, { desc = "Toggle test summary" })

vim.keymap.set("n", "<leader>uo", function()
  require("neotest").output.open({ enter = true })
end, { desc = "Open test output" })

vim.keymap.set("n", "<leader>ur", function()
  require("neotest").run.run_last()
end, { desc = "Run last test" })

vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
