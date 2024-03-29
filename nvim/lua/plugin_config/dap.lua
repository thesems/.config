require("dapui").setup()

local dap, dapui = require("dap"), require("dapui")

dap.listeners.after.event_initialized["dapui_config"] = function ()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function ()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function ()
    dapui.close()
end

vim.keymap.set("n", "<Leader>db", ':DapToggleBreakpoint<CR>')
vim.keymap.set("n", "<Leader>dt", ':DapTerminate<CR>')
vim.keymap.set("n", "<Leader>dc", ':DapContinue<CR>')
vim.keymap.set("n", "<Leader>do", ':DapStepOver<CR>')
vim.keymap.set("n", "<Leader>di", ':DapStepInto<CR>')
