return {
	"goolord/alpha-nvim",
	config = function()
		-- Set the colorscheme
		vim.api.nvim_set_hl(0, "AlphaHeader", { fg = "#89B4FA" }) -- LightBlue
		vim.api.nvim_set_hl(0, "AlphaButton", { fg = "#CDD6F4" }) -- LightGrey
		vim.api.nvim_set_hl(0, "AlphaShortcut", { fg = "#A6ADC8" }) -- DarkGrey
		vim.api.nvim_set_hl(0, "AlphaFooter", { fg = "#FAB387" }) -- LightOrange
		vim.api.nvim_set_hl(0, "AlphaButtonContainer", { bg = "#1E1E2E" }) -- DarkBlue

		-- Set the buttons
		-- local buttons = {
		-- 	type = "group",
		-- 	val = {
		-- 		{
		-- 			type = "button",
		-- 			val = "  New File",
		-- 			on_press = function()
		-- 				vim.cmd("ene!")
		-- 			end,
		-- 			opts = {
		-- 				key = "n",
		-- 				position = "center",
		-- 				hl = "AlphaButton",
		-- 			},
		-- 		},
		-- 		{
		-- 			type = "button",
		-- 			val = "󰩈 Quit",
		-- 			on_press = function()
		-- 				vim.cmd("qa") -- Quit Neovim
		-- 			end,
		-- 			opts = {
		-- 				key = "q",
		-- 				position = "center",
		-- 				hl = "AlphaButton",
		-- 			},
		-- 		},
		-- 	},
		-- 	opts = {
		-- 		spacing = 1,
		-- 		hl = "AlphaButtonContainer",
		-- 	},
		-- }

		-- Set the header
		-- Change header based on the screen size

		local function hasExternalDisplay()
			local handle = io.popen("system_profiler SPDisplaysDataType | grep -c 'Display Type'")
			local result = handle:read("*a")
			handle:close()
			return tonumber(result) > 1
		end

		local logo_number = 2
		if hasExternalDisplay() then
			logo_number = math.random(1, 4)
		else
			logo_number = math.random(1, 3)
		end

		local logo_file = "logo-" .. logo_number
		local path = vim.fn.stdpath("config") .. "/lua/plugins/alpha/"
		local logo_path = path .. logo_file .. ".txt"

		local function read_file(path)
			local file = io.open(path, "r")
			if not file then
				return nil
			end

			local lines = {}
			for line in file:lines() do
				table.insert(lines, line)
			end

			file:close()
			return lines
		end

		local header = {
			type = "text",
			val = read_file(logo_path) or { "Could not find: " .. logo_path },
			opts = {
				position = "center",
				hl = "AlphaHeader",
			},
		}

		-- Set the info_block
		local function get_footer()
			local datetime = os.date(" %d-%m-%Y   %H:%M:%S")
			local lazy_stats = require("nvim.lua.config.lazy").stats()
			local plugin_count = lazy_stats.count
			local version = vim.version()
			local nvim_version_info = string.format(" v%d.%d.%d", version.major, version.minor, version.patch)

			return "  󰏗 " .. plugin_count .. " plugins  " .. nvim_version_info .. "  "
		end

		local info_block = {
			type = "text",
			val = get_footer(),
			opts = {
				position = "center",
				hl = "AlphaFooter",
			},
		}

		-- Set the whole config:
		local layout = {
			{ type = "padding", val = 3 },
			header,
			{ type = "padding", val = 1 },
			info_block,
			{ type = "padding", val = 3 },
			--buttons,
		}

		local config = {
			layout = layout,
		}

		require("alpha").setup(config)
	end,
}
