local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}

-- Install your plugins here
return packer.startup(function(use)
    -- My plugins here
    use "wbthomason/packer.nvim" -- Have packer manage itself
    use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
    use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
    use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
    use "numToStr/Comment.nvim" -- Easily comment stuff
    use "kyazdani42/nvim-web-devicons"
    use "kyazdani42/nvim-tree.lua"
    use "akinsho/bufferline.nvim"
    use 'folke/tokyonight.nvim'
    use {
        "rcarriga/nvim-dap-ui",
        requires = { "mfussenegger/nvim-dap" }
    }
    use {
        'gelguy/wilder.nvim',
        config = function()
            require('wilder').setup({
                modes = { ':', '/', '?' },
                accept_key = "<Right>",
                reject_key = "<Left>",
                next_key = "<Tab>",
                previous_key = "<S-Tab>",
            })
        end,
    }
    use {
        "nvim-lualine/lualine.nvim",
        options = { theme = 'powerline' }
    }
    use {
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("todo-comments").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    }
    use {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("trouble").setup {
                mode = "loclist"
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    }
    use {
        'stevearc/aerial.nvim',
    }
    use 'kazhala/close-buffers.nvim'
    use 'simrat39/symbols-outline.nvim'
    use "akinsho/toggleterm.nvim"
    use "ahmedkhalf/project.nvim"
    use "lewis6991/impatient.nvim"
    use "lukas-reineke/indent-blankline.nvim"
    use "goolord/alpha-nvim"
    use "antoinemadec/FixCursorHold.nvim" -- This is needed to fix lsp doc highlight
    use "folke/which-key.nvim"
    use {
        'phaazon/hop.nvim',
        branch = 'v1', -- optional but strongly recommended
        config = function()
            -- you can configure Hop the way you like here; see :h hop-config
            require 'hop'.setup {
                keys = 'etovxqpdygfblzhckisuran',
            }
        end
    }
    -- use "indianboy42/hop-extensions"
    -- use 'ThePrimeagen/harpoon'

    -- Colorschemes
    -- use "lunarvim/colorschemes" -- A bunch of colorschemes you can try out
    use "lunarvim/darkplus.nvim"

    -- cmp plugins
    use "hrsh7th/nvim-cmp" -- The completion plugin
    use "hrsh7th/cmp-buffer" -- buffer completions
    use "hrsh7th/cmp-path" -- path completions
    use "hrsh7th/cmp-cmdline" -- cmdline completions
    use "saadparwaiz1/cmp_luasnip" -- snippet completions
    use "hrsh7th/cmp-nvim-lsp"
    -- snippets
    use "L3MON4D3/LuaSnip" --snippet engine
    use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

    -- LSP
    use "neovim/nvim-lspconfig" -- enable LSP
    use "williamboman/nvim-lsp-installer" -- simple to use language server installer
    use "tamago324/nlsp-settings.nvim" -- language server settings defined in json for
    use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters
    use 'simrat39/rust-tools.nvim' -- use 'glepnir/lspsaga.nvim'

    -- Telescope
    use "nvim-telescope/telescope.nvim"
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use { 'nvim-telescope/telescope-ui-select.nvim' }
    use  { "nvim-telescope/telescope-live-grep-args.nvim" }
    use 'cljoly/telescope-repo.nvim'
    -- use { "nvim-telescope/telescope-file-browser.nvim" }
    -- use { "nvim-telescope/telescope-project.nvim" }
    -- use { 'junegunn/fzf', run = './install --bin' }
    -- use { 'ibhagwan/fzf-lua',
    --     -- optional for icon support
    --     requires = { 'kyazdani42/nvim-web-devicons' }
    -- }
    -- use { 'nvim-telescope/telescope-hop.nvim' }
    -- Treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
    }
    use "JoosepAlviste/nvim-ts-context-commentstring"
    use {
        "danymat/neogen",
        config = function()
            require('neogen').setup {}
        end,
        requires = "nvim-treesitter/nvim-treesitter",
        -- Uncomment next line if you want to follow only stable versions
        -- tag = "*"
    }

    -- Git
    use "lewis6991/gitsigns.nvim"

    use {
        "kdheepak/lazygit.nvim",
        requires = {
            'nvim-lua/plenary.nvim',
        },
    }
    use {
        'TimUntersberger/neogit',
        requires = {
            'nvim-lua/plenary.nvim',
            'sindrets/diffview.nvim'
        }
    }
    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
