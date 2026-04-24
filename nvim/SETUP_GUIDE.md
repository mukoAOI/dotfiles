# Neovim 配置完整教程（当前版本）

本教程基于你当前这份配置，目标是：

- 从零完成环境安装
- 理解每个模块做了什么
- 直接使用现有快捷键
- 按固定工作流高效开发

---

## 1. 当前配置概览

这份配置已经包含：

- 插件管理：`lazy.nvim`
- 主题：`kanagawa`（已做高亮增强）
- 文件树：`nvim-tree`
- 标签栏：`barbar.nvim`
- 查找：`telescope.nvim`
- 语法与结构：`nvim-treesitter` + `rainbow-delimiters` + `indent-blankline`
- LSP：`mason` + `lspconfig`（C/C++/Lua/Rust/Zig）
- 补全：`nvim-cmp` + `LuaSnip` + `autopairs`
- Git：`gitsigns`
- 格式化：`conform`
- Lint：`nvim-lint`
- 调试：`nvim-dap` + `nvim-dap-ui` + `mason-nvim-dap`
- 测试：`neotest`（python/rust）
- 终端：`toggleterm`
- 注释/环绕：`Comment.nvim` + `nvim-surround`
- 交互 UI：`noice`、`which-key`
- 快速跳转：`flash.nvim`

---

## 2. 需要安装的软件（Windows）

## 必装

- `Neovim`（建议 0.11+）
- `Git`
- `ripgrep`（`rg`，给 Telescope live_grep 用）
- `fd`（可选但强烈建议，提升找文件速度）
- `Nerd Font`（图标正常显示）

## 编译与语言工具链

- C/C++：`clangd`（也可由 Mason 管理）
- Rust：
  - `rustup`（含 `rustc`、`cargo`、`rustfmt`、`clippy`）
- Zig：
  - `zig`（含 `zig fmt`）
  - `zls`（可用 Mason 安装）
- 调试（C/C++/Rust/Zig）：
  - `codelldb`（由 Mason 自动安装）
- Python（如需 python 开发）：`python` + `black` + `ruff`
- Python 测试（可选）：`pytest`
- Lua lint（可选）：`luacheck`
- Markdown lint（可选）：`markdownlint-cli`

## 建议用的 Windows 包管理器

- `winget`
- `scoop`
- `choco`

你可以按自己习惯装，核心是命令能在终端里找到。

---

## 3. 首次安装步骤

1. 把配置放到：
   - `~/AppData/Local/nvim/`（或你当前使用路径）
2. 启动 Neovim：
   - `nvim`
3. 安装插件：
   - `:Lazy sync`
4. 安装 LSP（Mason）：
   - `:Mason`
   - 确认安装：`clangd`、`lua_ls`、`rust_analyzer`、`zls`
5. 安装 Treesitter 解析器：
   - `:TSInstall lua c cpp json rust zig python vim vimdoc query`
6. 检查：
   - `:checkhealth`

---

## 4. 你当前已经设置的核心选项

- `Leader`：空格（`<leader> = Space`）
- 剪贴板：`unnamedplus`
- 缩进：4 空格（`tabstop/shiftwidth/softtabstop=4`）
- 相对行号：开启
- 光标行列高亮：开启
- 分屏方向：右/下打开
- 空白字符可视化：关闭
- 分隔线颜色：已高亮增强

---

## 5. 快捷键总表（当前配置）

## 文件与搜索

- `<leader>e`：切换文件树（NvimTree）
- `<leader>ff`：查找文件
- `<leader>fg`：全局搜索文本
- `<leader>fb`：查看/切换已打开 buffers
- `<leader>fh`：帮助文档搜索
- `<leader>fr`：恢复上一次 Telescope
- Telescope 面板中：
  - `<C-j>` 下移
  - `<C-k>` 上移

## 标签栏（barbar）

- `H`：上一个 buffer
- `L`：下一个 buffer
- `<leader>c`：关闭当前 buffer
- `<leader>bp`：选择 buffer（Pick）
- `<leader>bo`：关闭其他 buffer

## 快速跳转（flash）

- `s`：快速跳转
- `S`：Treesitter 跳转
- `r`（operator 模式）：远程跳转（配合 `d/c`）
- `R`（operator/可视）：Treesitter 搜索跳转

## Git（gitsigns）

- `<leader>gb`：查看当前行 blame
- `<leader>gd`：当前文件 diff
- `<leader>gr`：重置当前 hunk
- `]h`：下一个 hunk
- `[h`：上一个 hunk

## 代码格式化

- `<leader>cf`：手动格式化当前文件
- 保存时自动格式化（`BufWritePre`）

## 补全

- `<Tab>`：补全下一个/片段跳转
- `<S-Tab>`：补全上一个/片段回跳
- `<CR>`：确认补全

## 调试（DAP）

- `<leader>db`：切换断点
- `<leader>dc`：继续运行
- `<leader>di`：单步进入
- `<leader>do`：单步越过
- `<leader>dO`：单步跳出
- `<leader>dr`：调试 REPL
- `<leader>du`：切换调试 UI

## 测试（Neotest）

- `<leader>tn`：运行最近测试
- `<leader>tF`：运行当前文件测试
- `<leader>td`：用 DAP 调试最近测试
- `<leader>ts`：切换测试摘要面板
- `<leader>to`：打开测试输出

## 终端（Toggleterm）

- `<leader>tt`：切换终端
- `<leader>tf`：浮动终端
- `<leader>th`：水平终端
- `<leader>tv`：垂直终端

## 注释 / 环绕

- 注释：`gcc`（当前行），`gc`（可视模式选中）
- 环绕：
  - `ysiw"` 给单词加双引号
  - `cs"'` 把 `"` 改成 `'`
  - `ds"` 删除双引号包裹

---

## 6. 格式化与 Lint 当前规则

## 格式化（Conform）

- Lua：`stylua`
- Python：`black`
- C/C++：`clang-format`
- Rust：`rustfmt`
- Zig：`zig fmt`
- JSON/Markdown：`prettierd` 或 `prettier`

## Lint（nvim-lint）

- Python：`ruff`
- Lua：`luacheck`
- Rust：`clippy`
- Markdown：`markdownlint`

注意：这些命令需要你本机已安装，否则对应语言不会生效。

---

## 7. 推荐工作流（每天照着用）

1. 打开项目：`nvim .`
2. `Space e` 打开文件树，定位目录
3. `Space ff` 精确找文件；`Space fg` 全局搜关键词
4. 进入代码后：
   - 用 `s` / `S` 快速跳到目标
   - 用 `H` / `L` 切换文件标签
5. 编码过程：
   - 自动补全 + snippets（Tab/Shift-Tab）
   - 保存自动格式化
   - 实时 lint/LSP 诊断修复问题
6. 需要调试时：
   - `Space db` 打断点
   - `Space dc` 启动，`Space di/do/dO` 单步
7. 需要测试时：
   - `Space tn` 跑最近测试
   - `Space tF` 跑当前文件测试
8. 看 Git 变更：
   - `]h` / `[h` 逐段查看改动
   - `Space gb` 看 blame，`Space gd` 看 diff
9. 需要临时命令行时：
   - `Space tt` 打开浮动终端
10. 收尾：
   - `Space bo` 清理其他标签

---

## 8. 常见问题排查

## `:Telescope live_grep` 无结果/报错

- 检查 `rg` 是否安装：`rg --version`

## 图标显示成方块

- 终端字体没设成 Nerd Font

## Rust/Zig 没有 LSP

- `:Mason` 检查 `rust_analyzer` / `zls`
- `rustup component add rustfmt clippy`
- `zls --version` 检查是否可执行

## DAP 无法启动调试

- `:Mason` 检查 `codelldb` 是否已安装
- 确认编译产物可执行（调试时会询问可执行文件路径）

## 测试命令没反应

- Python：确认 `pytest` 可执行
- Rust：确认项目可正常 `cargo test`

## 格式化不生效

- 先试手动：`<leader>cf`
- 在终端验证对应 formatter 命令可执行

## Treesitter 没高亮

- 执行：`:TSInstall <language>`
- 执行：`:TSUpdate`

---

## 9. 后续可选增强

- 增加项目级任务面板（如 `overseer.nvim`）
- 增加测试覆盖率展示（coverage）
- 增加语言专用增强（如 `rustaceanvim`）

---

如果你愿意，我下一步可以再给你出一份“最小必装外部工具清单（仅 C++/Rust/Zig）”，按你现在环境一条命令一条命令装好。
