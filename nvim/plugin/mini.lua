vim.pack.add({{ src = "https://github.com/nvim-mini/mini.nvim"}})

require('mini.basics').setup {
	options = { extra_ui = true },
	mappings = { windows = true },
}

require('mini.')

local function extra_mode_status()
	-- recording macros
	local reg_recording = vim.fn.reg_recording()
	if reg_recording ~= '' then
		return ' @' .. reg_recording
	end
	-- executing macros
	local reg_executing = vim.fn.reg_executing()
	if reg_executing ~= '' then
		return ' @' .. reg_executing
	end
	-- ix mode (<C-x> in insert mode to trigger different builtin completion sources)
	local mode = vim.api.nvim_get_mode().mode
	if mode == 'ix' then
		return '^X: (^]^D^E^F^I^K^L^N^O^Ps^U^V^Y)'
	end
	return ''
end

require('mini.statusline').setup {
	content = {
		active = function()
			local mode, mode_hl = MiniStatusline.section_mode { trunc_width = 120 }
			local git = MiniStatusline.section_git { trunc_width = 40 }
			local diff = MiniStatusline.section_diff { trunc_width = 75 }
			local diagnostics = MiniStatusline.section_diagnostics { trunc_width = 75 }
			local lsp = MiniStatusline.section_lsp { trunc_width = 75 }
			local filename = MiniStatusline.section_filename { trunc_width = 140 }
			local fileinfo = MiniStatusline.section_fileinfo { trunc_width = 120 }
			local location = tostring(math.floor(vim.fn.line('.') / vim.fn.line('$') * 100)) .. '%%'
			local search = MiniStatusline.section_searchcount { trunc_width = 75 }
			local extra_mode_status_label = extra_mode_status()

			return MiniStatusline.combine_groups {
				{ hl = mode_hl, strings = { mode } },
				{ hl = 'MiniStatuslineDevinfo', strings = { git, diff, diagnostics, lsp } },
				'%<',
				{ hl = 'MiniStatuslineFilename', strings = { filename } },
				'%=',
				{ hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
				{ hl = mode_hl, strings = { extra_mode_status_label, search, location } },
			}
		end,
	},
}


require('mini.files').setup {
	windows = { preview = true },
}

vim.keymap.set('n', '-', MiniFiles.open, { desc='Mini Files' })
