return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = false,
  keys = {
    { "<leader>t", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file tree" },
    { "<leader>o", "<cmd>NvimTreeFindFile<cr>", desc = "Find file in tree" },
  },
  config = function()
    require("nvim-tree").setup({
      view = {
        width = 35,
      },
      filters = {
        dotfiles = false,
      },
      on_attach = function(bufnr)
        local api = require("nvim-tree.api")
        -- default mappings
        api.config.mappings.default_on_attach(bufnr)
        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end
        -- unbind C-k
        vim.keymap.del("n", "<C-k>", { buffer = bufnr })
        -- custom mappings
        vim.keymap.set("n", "<leader>i", api.node.show_info_popup, opts("File Info"))
      end,
    })
  end,
}
