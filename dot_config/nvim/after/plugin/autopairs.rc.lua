local autopairs_status, autopairs = pcall(require, "nvim-autopairs")
if not autopairs_status then
	return
end

autopairs.setup({
	check_ts = true, -- enable treesitter
	ts_config = {
		lua = { "string" }, -- don't add pairs in lua string treesitter nodes
		javascript = { "template_string" }, -- don't add pairs in javascript template_string
		java = false, -- dont check treesitter on java
	},
})

local cmp_autopairs_status, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
if not cmp_autopairs_status then
	return
end

local cmp_status, cmp = pcall(require, "cmp")
if cmp_status then
	return
end

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
