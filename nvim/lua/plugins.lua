local M = {}

local fn = vim.fn
local cmd = vim.cmd

local packer_bootstrap = false

local function packer_init()
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		packer_bootstrap = fn.system({
			"git",
			"clone",
			"--depth",
			"1",
			"https://github.com/wbthomason/packer.nvim",
			install_path,
		})
		cmd([[packadd packer.nvim]])
	end
	cmd("autocmd BufWritePost plugins.lua source <afile> | PackerCompile")
end

packer_init()

function M.setup()
	local conf = {
		compile_path = fn.stdpath("config") .. "/lua/packer_compiled.lua",
		display = {
			open_fn = function()
				return require("packer.util").float({ border = "rounded" })
			end,
		},
	}

	local function plugins(use)
		-- plugin imaptient requires to restart nvim twice
		-- use { "lewis6991/impatient.nvim" } -- speed up loading Lua modules
		use({ "wbthomason/packer.nvim" }) -- plugin manager

		-- Color scheme
		require("plugins-colorscheme").setup(use)

		-- Development
		require("plugins-development").setup(use)

		-- Better syntax
		require("plugins-syntax").setup(use)

		-- Dashboard
		require("plugins-dashboard").setup(use)

		-- Telescope
		require("plugins-telescope").setup(use)

		-- Completion
		require("plugins-completion").setup(use)

		-- LSP
		require("plugins-lsp").setup(use)

		if packer_bootstrap then
			print("Setting up Neovim. Restart required after installation!")
			require("packer").sync()
		end
	end

	pcall(require, "impatient")
	pcall(require, "packer_compiled")
	require("packer").init(conf)
	require("packer").startup(plugins)
	-- return require("packer").startup(plugins,conf)
end

return M
