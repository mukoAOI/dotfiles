return {
    {
        "tiagovla/scope.nvim",
        -- 建议在 Neovim 启动时立即加载，以接管 buffer 管理
        event = "VeryLazy", 
        config = function()
            require("scope").setup({
                -- 默认配置即可胜任大多数场景
                -- 如果你希望切换 Tab 时恢复上一次的光标位置，保持默认即可
                restore_cursor = true, 
            })
        end
    }
}
