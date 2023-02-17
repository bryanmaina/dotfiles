local telescope_setup, telescope = pcall(require, "telescope")
if not telescope_setup then
	return
end

local actions_setup, actions = pcall(require, "telescope.actions")
if not actions_setup then
	return
end

local builtin_setup, builtin = pcall(require, "telescope.builtin")
if not builtin_setup then
	return
end

local function telescope_buffer_dir()
	return vim.fn.expand("%:p:h")
end

local fb_actions = telescope.extensions.file_browser.actions

telescope.setup({
	defaults = {
		layout_config = {
			vertical = {
				preview_cutoff = 0,
			},
		},
		file_ignore_patterns = {
			"node_modules",
			".git",
			"plugin/packer_compiled.lua",
			"target",
			"package-lock.json",
		},
		mappings = {
			n = {
				["q"] = actions.close,
				["C-x k"] = actions.delete_buffer,
			},
		},
	},
	extentions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		},
		file_browser = {
			theme = "dropdown",
			-- disable newtr and use telescope-file-browser in its place
			hijack_netrw = true,
			mappings = {
				-- insert mode
				["i"] = {
					["<C-w>"] = function()
						vim.cmd("normal vbd")
					end,
				},
				-- normal mode
				["n"] = {
					["N"] = fb_actions.create,
					["h"] = fb_actions.goto_parent_dir,
					["/"] = function()
						vim.cmd("startinsert")
					end,
				},
			},
		},
	},
})

telescope.load_extension("fzf")

telescope.load_extension("file_browser")

vim.keymap.set("n", ";f", function()
	builtin.find_files({
		no_ignore = false,
		hidden = true,
	})
end)
vim.keymap.set("n", ";r", function()
	builtin.live_grep({
		layout_strategy = "vertical",
	})
end)
vim.keymap.set("n", "\\\\", function()
	builtin.buffers()
end)
vim.keymap.set("n", ";h", function()
	builtin.help_tags()
end)
vim.keymap.set("n", ";;", function()
	builtin.resume()
end)
vim.keymap.set("n", ";e", function()
	builtin.diagnostics({
		layout_strategy = "vertical",
	})
end)
vim.keymap.set("n", ";z", function()
	builtin.lsp_dynamic_workspace_symbols({
		layout_strategy = "vertical",
	})
end)
vim.keymap.set("n", "sf", function()
	telescope.extensions.file_browser.file_browser({
		path = "%:p:h",
		cwd = telescope_buffer_dir(),
		respect_gitignore = false,
		hidden = true,
		grouped = true,
		previewer = false,
		initial_mode = "normal",
		layout_config = { height = 40 },
	})
end)
