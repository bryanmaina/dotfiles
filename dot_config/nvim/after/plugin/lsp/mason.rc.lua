local mason_status, mason = pcall(require, "mason")
if not mason_status then
	return
end

local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
	return
end

local mason_null_ls_status, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_status then
	return
end

local mason_nvim_dap_status, mason_nvim_dap = pcall(require, "mason-nvim-dap")
if not mason_nvim_dap_status then
	return
end

mason.setup()

mason_lspconfig.setup({
	ensure_installed = {
		"tsserver",
		"angularls",
		"svelte",
		"vuels",
		"zls",
		"lemminx",
		"yamlls",
		"emmet_ls",
		"html",
		"cssls",
		"tailwindcss",
		"lua_ls",
		"dockerls",
		"rust_analyzer",
	},
})

mason_null_ls.setup({
	ensure_installed = {
		-- "hadolint",
		"prettier",
		"stylua",
		"eslint_d",
		"sql_formatter",
		"shfmt",
		"rustfmt",
		"solhint",
		"gitlint",
	},
})

mason_nvim_dap.setup({
	ensure_installed = {
		"codelldb",
	},
})
