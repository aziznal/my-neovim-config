require('packer').startup(function(use)
    -- Gameified Vim Tutorial by the Primeagean
    use 'ThePrimeagen/vim-be-good'

    -- File navigator, icons, etc.
    use 'nvim-lua/plenary.nvim'
    use {'nvim-telescope/telescope.nvim', tag = '0.1.1'}
    use 'BurntSushi/ripgrep'
    use 'sharkdp/fd'
    use 'nvim-treesitter/nvim-treesitter'
    use 'nvim-tree/nvim-web-devicons'

    -- Undo tree
    use 'mbbill/undotree'

    -- Github Theme
    use {'projekt0n/github-nvim-theme', tag = 'v0.0.7'}

    -- LSP 0
    use 'neovim/nvim-lspconfig'                           -- Required
    use {'williamboman/mason.nvim', run = ':MasonUpdate'} -- Optional
    use 'williamboman/mason-lspconfig.nvim'               -- Optional

    -- Autocompletion
    use 'hrsh7th/nvim-cmp'     -- Required
    use 'hrsh7th/cmp-nvim-lsp' -- Required
    use 'L3MON4D3/LuaSnip'     -- Required

    -- Prettier (requires nvim-lspconfig)
    use 'jose-elias-alvarez/null-ls.nvim'
    use 'MunifTanjim/prettier.nvim'

    use {'VonHeikemen/lsp-zero.nvim', branch = 'v2.x'}

    -- Better tmux-vim navigation
    use 'christoomey/vim-tmux-navigator'

    use 'github/copilot.vim'

    -- File Tree
    use 'nvim-tree/nvim-tree.lua'

    -- Harpoon for quick file navigation
    use 'ThePrimeagen/harpoon'

    -- Comments
    use 'numToStr/Comment.nvim'
end)
