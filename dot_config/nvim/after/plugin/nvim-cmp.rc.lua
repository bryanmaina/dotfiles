local cmp_status, cmp = pcall(require, "cmp")
if not cmp_status then
	return
end

local luasnip_status, luasnip = pcall(require, "luasnip")
if not luasnip_status then
	return
end

local lspkind_status, lspkind = pcall(require, "lspkind")
if not lspkind_status then
	return
end

-- load friendly-snippets
require("luasnip/loaders/from_vscode").lazy_load()

vim.opt.completeopt = "menu,menuone,noselect"

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
			vim.fn["vsnip#anonymouse"](args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-l>"] = cmp.mapping.select_prev_item(), -- previous suggestion
		["<C-k>"] = cmp.mapping.select_next_item(), -- next suggestion
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-space>"] = cmp.mapping.complete(), -- show completion suggestion
		["<C-e>"] = cmp.mapping.abort(), -- close completion window
		["<CR>"] = cmp.mapping.confirm({ select = false }),
	}),
	sources = cmp.config.sources({
		{ name = "luasnip" }, -- snippets
		{ name = "buffer", keyword_length = 2 }, -- text within current paths
		{ name = "path" }, -- file system paths
		{ name = "nvim_lsp", keyword_length = 3 }, -- from languge server
		{ name = "nvim_lsp_signature_help" }, -- display function signature with current parameter emphasized
		{ name = "nvim_lua", keyword_length = 2 }, -- complete neovim's Lua runtime API such vim.lsp.*
		{ name = "vsnip", keyword_length = 2 }, -- nvim-cmp source for nvim-vsnip
		{ mane = "calc" }, -- source for math calculation
	}),
	formatting = {
		format = lspkind.cmp_format({
			maxwidth = 50,
			ellipsis_char = "...",
		}),
	},
})
