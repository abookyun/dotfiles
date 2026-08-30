return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("gitsigns").setup({
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local function map(lhs, rhs, desc)
          vim.keymap.set("n", lhs, rhs, { buffer = bufnr, desc = desc })
        end

        -- Navigation (next_hunk/prev_hunk are deprecated in favour of nav_hunk)
        map("]c", function() gs.nav_hunk("next") end, "Next hunk")
        map("[c", function() gs.nav_hunk("prev") end, "Previous hunk")

        -- Actions
        map("<leader>hs", gs.stage_hunk, "Stage hunk")
        map("<leader>hr", gs.reset_hunk, "Reset hunk")
        map("<leader>hp", gs.preview_hunk, "Preview hunk")
        map("<leader>hb", gs.blame_line, "Blame line")
      end,
    })
  end,
}
