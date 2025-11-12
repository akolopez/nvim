return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate', -- Automatically update parsers on installation/update
  config = function()
    require('nvim-treesitter.configs').setup {
      highlight = { enable = true },
      indent = { enable = true },
      autoinstall = true, -- Automatically install missing parsers
      -- Add other configurations as needed, e.g., for specific languages
      -- ensure_installed = { "lua", "javascript", "typescript", "html", "css" },
      -- ignore_install = { "php" }, -- List of parsers to ignore installation
    }
  end,
  -- Optional: Lazy load the plugin on specific events for performance
  -- event = { "BufReadPost", "BufNewFile" },
}
