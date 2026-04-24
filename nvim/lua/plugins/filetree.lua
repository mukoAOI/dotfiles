return {
    {
        "nvim-tree/nvim-tree.lua", -- 仓库已更名，建议用这个新地址
        version = "*",
        cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFindFile" },
        keys = {
            { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "Toggle File Tree" },
        },
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("nvim-tree").setup({
                sort_by = "case_sensitive",
                view = {
                    width = 30,
                    side = "right", -- 靠左显示
                },
                renderer = {
                    group_empty = true, -- 空文件夹合并显示
                    icons = {
                        show = {
                            git = true, -- 显示 git 状态图标
                        },
                    },
                },
                filters = {
                    dotfiles = false, -- 是否隐藏点文件
                },
            })
        end,
    },
}
