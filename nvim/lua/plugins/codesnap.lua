return {
	"mistricky/codesnap.nvim",
	build = "make build_generator",
	keys = {
		{
			"<leader>cs",
			"<cmd>CodeSnap<cr>",
			mode = "x",
			desc = "Save selected code snapshot into clipboard",
		},
		{
			"<leader>csp",
			"<cmd>CodeSnapSave<cr>",
			mode = "x",
			desc = "Save selected code snapshot in ~/Pictures",
		},
        {
			"<leader>csa",
			"<cmd>CodeSnapASCII<cr>",
			mode = "x",
			desc = "Save selected code ASCII snapshot into clipboard ",
        },
	},
	config = function()
		require("codesnap").setup({
			save_path = os.getenv("XDG_PICTURES_DIR") or (os.getenv("HOME") .. "/Pictures"),
			has_breadcrumbs = true,
			bg_theme = "bamboo",
			bg_padding = 0,
            has_line_number=true,
            mac_window_bar = true,
            watermark ="",
		})
	end,
}
