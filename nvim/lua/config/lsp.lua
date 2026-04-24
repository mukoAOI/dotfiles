require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "clangd", "lua_ls", "rust_analyzer", "zls" },
})

-- 1. 准备补全能力参数 (这个依然来自 cmp_nvim_lsp)
local caps = require('cmp_nvim_lsp').default_capabilities()

-- 2. 使用 0.11 的新 API 配置 clangd
-- 注意：新 API 下，配置直接挂在 vim.lsp.config['server_name']
vim.lsp.config['clangd'] = {
    cmd = { "clangd", "--background-index", "--clang-tidy" },
    capabilities = caps,
    -- 如果想关闭 LSP 语义高亮（只用 Treesitter），取消注释下面这行：
     on_init = function(client) client.server_capabilities.semanticTokensProvider = nil end
}
-- 显式启动
vim.lsp.enable('clangd')

-- 3. 配置 lua_ls (同样使用新 API)
vim.lsp.config['lua_ls'] = {
    capabilities = caps,
}
vim.lsp.enable('lua_ls')

-- 4. 配置 rust_analyzer
vim.lsp.config['rust_analyzer'] = {
    capabilities = caps,
}
vim.lsp.enable('rust_analyzer')

-- 5. 配置 zls (Zig)
vim.lsp.config['zls'] = {
    capabilities = caps,
}
vim.lsp.enable('zls')
