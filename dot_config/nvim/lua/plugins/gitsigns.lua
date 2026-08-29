return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("gitsigns").setup({
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local opts = { buffer = bufnr }

        -- Navigation (next_hunk/prev_hunk are deprecated in favour of nav_hunk)
        vim.keymap.set("n", "]c", function() gs.nav_hunk("next") end, opts)
        vim.keymap.set("n", "[c", function() gs.nav_hunk("prev") end, opts)

        -- Actions
        vim.keymap.set("n", "<leader>hs", gs.stage_hunk, opts)
        vim.keymap.set("n", "<leader>hr", gs.reset_hunk, opts)
        vim.keymap.set("n", "<leader>hp", gs.preview_hunk, opts)
        vim.keymap.set("n", "<leader>hb", gs.blame_line, opts)
      end,
    })
  end,
}
