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
end)
