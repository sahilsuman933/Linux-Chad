local lazy = {}

function lazy.install(path)
  if not vim.loop.fs_stat(path) then
    print('Installing lazy.nvim....')
    vim.fn.system({
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      '--branch=stable', -- latest stable release
      path,
    })
  end
end

function lazy.setup(plugins)
  if vim.g.plugins_ready then
    return
  end

  -- You can "comment out" the line below after lazy.nvim is installed
  lazy.install(lazy.path)

  vim.opt.rtp:prepend(lazy.path)

  require('lazy').setup(plugins, lazy.opts)
  vim.g.plugins_ready = true
end

lazy.path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
lazy.opts = {}



lazy.setup({
{"craftzdog/solarized-osaka.nvim", lazy = false, priority = 1000,opts = {}}, -- Theme
-- LSP, Autocompletion
{'williamboman/mason.nvim', opt = {ensure_installed = {"typescript-language-server"}} },
{'williamboman/mason-lspconfig.nvim'},
{'VonHeikemen/lsp-zero.nvim', branch = 'v3.x' , lazy = false},
{'neovim/nvim-lspconfig', lazy = false},
{'hrsh7th/cmp-nvim-lsp', lazy = false},
{'hrsh7th/nvim-cmp', lazy = false},
{'L3MON4D3/LuaSnip', lazy = false},
{'nvim-telescope/telescope.nvim', tag = '0.1.4', dependencies = { 'nvim-lua/plenary.nvim' }}, -- Fuzzy Finder
{'lukas-reineke/indent-blankline.nvim', main = 'ibl', opts = {} }, -- Indentation
{'kyazdani42/nvim-tree.lua', dependencies = { 'kyazdani42/nvim-web-devicons' }}, -- File Explorer Tree
{'nvim-lualine/lualine.nvim', config = function () require('lualine').setup({ options = { icons_enabled = false,}}) end}, -- Bottom Bar
{'ThePrimeagen/harpoon'},
{'nvim-lua/plenary.nvim'},
{"mhartington/formatter.nvim", event = "VeryLazy", opts = function() return require "plugins/formatter" end},
{"mfussenegger/nvim-lint", event = "VeryLazy", config = function() require "plugins/lint" end},
{
     "goolord/alpha-nvim",
     config = function ()
         local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
 return
end

local dashboard = require("alpha.themes.dashboard")
dashboard.section.header.val = {

    [[          ▀████▀▄▄              ▄█ ]],
    [[            █▀    ▀▀▄▄▄▄▄    ▄▄▀▀█ ]],
    [[    ▄        █          ▀▀▀▀▄  ▄▀  ]],
    [[   ▄▀ ▀▄      ▀▄              ▀▄▀  ]],
    [[  ▄▀    █     █▀   ▄█▀▄      ▄█    ]],
    [[  ▀▄     ▀▄  █     ▀██▀     ██▄█   ]],
    [[   ▀▄    ▄▀ █   ▄██▄   ▄  ▄  ▀▀ █  ]],
    [[    █  ▄▀  █    ▀██▀    ▀▀ ▀▀  ▄▀  ]],
    [[   █   █  █      ▄▄           ▄▀   ]],

}

 dashboard.section.buttons.val = {
   dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
   dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
   dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
   dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
   dashboard.button("c", "  Configuration", ":e ~/.config/nvim/init.vim<CR>"),
   dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
}

local function footer()
 return "Don't Stop Until You are Proud..."
end

dashboard.section.footer.val = footer()

dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"

dashboard.opts.opts.noautocmd = true
alpha.setup(dashboard.opts)
     end
 }
})
