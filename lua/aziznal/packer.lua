-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require("packer").startup(
    function(use)
        -- Packer can manage itself
        use "wbthomason/packer.nvim"

        use {
            "nvim-telescope/telescope.nvim",
            tag = "0.1.1"
        }

        -- required for telescope
        use("nvim-lua/plenary.nvim")

        use(
            {
                "projekt0n/github-nvim-theme",
                tag = "v0.0.7"
            }
        )

        use("nvim-treesitter/nvim-treesitter", {run = ":TSUpdate"})

        use("windwp/nvim-ts-autotag")

        use("mbbill/undotree")

        -- LSP Zero
        use {
            "VonHeikemen/lsp-zero.nvim",
            branch = "v2.x",
            requires = {
                -- LSP Support
                {"neovim/nvim-lspconfig"}, -- Required
                {
                    -- Optional
                    "williamboman/mason.nvim",
                    run = function()
                        pcall(vim.cmd, "MasonUpdate")
                    end
                },
                {"williamboman/mason-lspconfig.nvim"}, -- Optional
                -- Autocompletion
                {"hrsh7th/nvim-cmp"}, -- Required
                {"hrsh7th/cmp-nvim-lsp"}, -- Required
                {"L3MON4D3/LuaSnip"} -- Required
            }
        }

        -- Nvim tree
        use {
            "nvim-tree/nvim-tree.lua",
            requires = {
                "nvim-tree/nvim-web-devicons" -- optional
            }
        }

        use("zbirenbaum/copilot.lua")

        use("theprimeagen/Vim-be-good")

        -- markdown preview in the browser
        use(
            {
                "iamcco/markdown-preview.nvim",
                run = function()
                    vim.fn["mkdp#util#install"]()
                end
            }
        )
        -- transparency support in neovim (for adding background image, etc.)
        use("xiyaowong/transparent.nvim")

        -- Recent project explorer
        use("ahmedkhalf/project.nvim")

        -- Show git changes in gutter
        use("airblade/vim-gitgutter")

        -- show inline git blame
        use("f-person/git-blame.nvim")

        -- toggle comments in code
        use("numToStr/Comment.nvim")

        -- auto detect indentation
        use("nmac427/guess-indent.nvim")

        -- git support in vim
        use("tpope/vim-fugitive")

        -- custom status line
        use {"nvim-lualine/lualine.nvim"}

        -- line for showing open buffers in tabline
        use {"akinsho/bufferline.nvim", tag = "*"}

        -- add color to hex codes
        use {"norcalli/nvim-colorizer.lua"}

        -- util for closing buffers easily
        use {"kazhala/close-buffers.nvim"}

        use {"mhartington/formatter.nvim"}
    end
)
