return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        open_mapping = [[<leader>ft]],
        direction = "float",
        shade_terminals = true,
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
        persist_mode = true,
      })
    end,
  },
}
