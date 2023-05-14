-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        -- or                            , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    use({
        'projekt0n/github-nvim-theme', tag = 'v0.0.7',
        -- or                            branch = '0.0.x'
    })

    use ('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})

    use ('theprimeagen/harpoon')

    use ('mbbill/undotree')

    -- LSP Zero
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {                                      -- Optional
            'williamboman/mason.nvim',
            run = function()
                pcall(vim.cmd, 'MasonUpdate')
            end,
        },
        {'williamboman/mason-lspconfig.nvim'}, -- Optional

        -- Autocompletion
        {'hrsh7th/nvim-cmp'},     -- Required
        {'hrsh7th/cmp-nvim-lsp'}, -- Required
        {'L3MON4D3/LuaSnip'},     -- Required


        use {
            'nvim-tree/nvim-tree.lua',
            requires = {
                'nvim-tree/nvim-web-devicons', -- optional
            },
        },

        use ('github/copilot.vim'),

        use ('theprimeagen/Vim-be-good'),

        use({
            "iamcco/markdown-preview.nvim",
            run = function() vim.fn["mkdp#util#install"]() end,
        }),

        use('xiyaowong/transparent.nvim'),

        -- prettier
        use('jose-elias-alvarez/null-ls.nvim'),
        use('MunifTanjim/prettier.nvim'),
    }
}
end)
