-- Floating setup for the editor from here: https://github.com/folke/snacks.nvim/discussions/1306
return {
  "folke/snacks.nvim",
  opts = {
    explorer = {
      -- your explorer configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    dashboard = {
      preset = {
        pick = function(cmd, opts)
          return LazyVim.pick(cmd, opts)()
        end,
        header = [[
    ⠀⠀⠀⠀⠀⠀⢒⣤⠲⠂⠤⣀⠀⠀⠀⠀⢀⡀⠐⢂⠀⠀⠀⠀⠀⠀⣠⣶⣿⣿⡿⣿⡿⣿⣤⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⣶⣾⢟⢟⠛⠓⢿⣴⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⡀⣿⣿⡻⠟⠿⣿⣧⡦⣤⣤⣶⣿⠛⠋⠉⠳⠉⠀⠀⣾⣿⣿⢿⠋⠋⠉⠀⣻⣶⣽⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⠰⣿⣿⣿⣿⣿⣿⣿⣶⣠⢀⠀⠀⠀⠀⠐⠙⠋⠁⠀⠀⠀⠐⡁⠘⠙⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⣴⣿⡷⠁⠀⠀⠀⠀⠉⠁⠀⠀⠀⡍⠽⠀⠐⠀⠀⣿⣿⠋⠀⣀⠀⠀⠀⠠⢘⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⢠⢫⠭⢻⣿⣿⣿⣿⣿⣟⣿⣿⣛⣿⣽⣯⠛⣀⡷⠛⠛⠿⣿⠀⠀⠀⠀⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⢠⣿⣿⡷⡀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⣄⠀⠀⠈⢾⡇⠀⠀⠀⡰⢀⠈⠰⣿⣿⡿⠀⠀⠀⠀⠀⠀⣴⣿⣿⠻⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⡏⣴⡀⢰⠈⣾⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠸⣿⢛⣿⣶⡀⠀⠀⠀⠀⠀⠏⠚⢖⢈⠃⠀⠀⠈⠙⠛⠋⠁⠐⢠⣼⣿⣿⠋⠀⠀⠀⠀⠀⣠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡀⡇⡉⣱⣶⠀⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠿⠗⠉⠀⠛⠒⠀⠀⠀⢠⣰⡾⠋⠀⠀⠀⠀⠀⠀⠀⣶⠀⣾⣽⠟⠀⠀⠀⠀⣤⣶⣿⣿⣿⣿⣿⣿⣿⡿⠛⣛⠉⠿⣷⣿⣿⣽⣟⣿⣿⣿⣿⣷⣦⡭⠋⠀⠀⣿⣿⠛⠤⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⢀⣤⣨⣵⣾⣿⠿⠛⣒⣩⣵⣖⣶⣶⣶⣶⣤⣴⣶⠂⠛⠃⠻⣰⠁⣶⣾⣿⣿⣿⣿⣿⣿⢻⣿⣿⣿⡿⠀⣿⡆⣰⣷⡟⣷⣄⠉⠙⠛⠛⠛⠉⠉⠁⠀⠀⠀⠀⠀⣿⣿⠋⠰⡌⠲⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠄⠛⣿⣿⠟⠀⠀⠐⠃⢉⠛⠛⠛⢉⣉⣉⡛⢟⣿⣟⠀⣿⠀⠛⠃⠃⣿⣿⡿⡿⢿⣿⡿⢋⣾⣿⣿⡿⢀⣿⣿⠑⠁⠀⢀⣺⣿⠿⣿⡄⡠⣴⣶⣶⣤⡀⠀⠀⠀⢀⣾⣿⣿⠁⠀⢻⢱⡞⠃⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠎⠙⣿⠟⠀⠀⠀⠀⠀⠀⣠⣾⣿⡿⣿⠻⣿⣿⣦⠀⣿⢀⠙⠟⢸⠀⣴⣾⣿⣿⣿⣿⣿⠟⣴⣿⠋⠈⣿⣿⠀⢹⣿⠂⣤⡄⢲⠘⣿⢛⣿⣍⠻⣟⣿⣿⡷⠀⣴⣿⣿⣿⠀⠀⠀⠀⡿⣯⣉⠉⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⣅⠉⣿⢭⠀⣀⣀⣤⣶⣿⣿⠟⠚⠛⡈⠊⠁⠻⠿⠈⣿⡀⠿⠟⢸⣿⣤⢉⣙⡃⣴⡌⣰⣿⣿⡷⠘⣿⠗⢸⣿⣿⢠⣿⣿⣟⢿⠀⠙⡍⠋⣉⡿⣿⣶⣴⣿⣿⣿⠟⣷⠀⣀⣀⠀⠀⣿⢩⣬⠉⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⣠⣾⢻⢦⠹⣿⣿⡿⢛⡉⠛⠀⣴⣿⣿⢿⡟⡿⠀⠛⠂⣝⢿⠃⢻⣿⣿⣿⠠⣹⠁⣿⣿⣿⠘⣿⣿⠘⢴⣿⠟⣭⣿⣿⣿⣿⣿⡋⣁⢯⢳⣠⠻⠿⠉⠭⠛⠹⠋⣴⠛⠀⠁⢿⣿⣄⠙⠈⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⢸⠃⠀⠀⣀⣻⠉⠿⠀⠉⠀⠀⣾⡿⢛⡄⢬⣽⠑⠦⠀⣭⣌⠉⠻⠦⢨⠉⠁⠈⠁⠀⣿⣿⠛⠘⣿⡖⠸⢀⣶⠀⠛⠓⣿⣿⣿⣿⣿⢰⠉⠀⢼⡝⢁⣭⠉⠉⢀⠿⠀⠾⠀⣴⢆⠉⣿⣿⠈⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠈⡀⠀⡠⢉⡏⠀⠀⠀⠀⠀⣼⡟⠛⠀⠀⠀⠀⠀⠀⠐⠒⢀⠙⠃⠀⠙⠋⡀⠉⠉⠀⣿⣿⣥⠘⠂⠀⠃⠀⠀⠀⠀⠀⠌⣿⣿⣿⣿⣆⠀⠀⠀⠀⠀⠀⠀⣴⠙⣠⠛⠁⠀⠁⠀⠀⠐⣿⣿⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⢠⢁⡿⠀⠀⠀⠀⠀⠀⠿⢡⠀⠀⠀⠀⠀⣀⣤⣶⣿⣿⣿⣿⣶⣦⣤⣤⣤⣴⣿⣿⠟⣀⠛⠁⠛⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⠿⣶⡀⠀⠀⣠⣶⣻⢉⡖⡬⠀⠀⠀⠋⠆⢷⠀⣼⣿⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠊⠀⠘⠀⡮⠄⠀⣠⣴⣿⢿⣿⣿⣿⣶⣴⣽⣿⣿⣿⣟⣽⣿⡿⠻⣿⣿⣿⣷⢿⠿⠋⢽⣶⠀⣀⠛⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⠿⣿⣿⢿⣿⣿⣿⠏⠿⠈⣛⠋⠀⠀⠀⠀⠀⡐⠀⢀⣾⠟⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠐⠠⠠⡤⣾⠋⠉⠉⠀⠀⠀⠉⠛⠿⠿⠿⠿⠛⠉⠉⠉⠀⠀⠀⠀⠈⠁⠐⠓⣩⠉⠤⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠲⠆⠀⠓⡀⠙⠀⠛⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
]],
       -- stylua: ignore
       ---@type snacks.dashboard.Item[]
       keys = {},
      },
    },
    picker = {
      sources = {
        files = {
          layout = { preset = "default" },
        },
        explorer = {
          actions = {
            bufadd = function(_, item)
              if vim.fn.bufexists(item.file) == 0 then
                local buf = vim.api.nvim_create_buf(true, false)
                vim.api.nvim_buf_set_name(buf, item.file)
                vim.api.nvim_buf_call(buf, vim.cmd.edit)
              end
            end,
            confirm_nofocus = function(picker, item)
              if item.dir then
                picker:action("confirm")
              else
                picker:action("bufadd")
              end
            end,
          },
          win = {
            list = {
              keys = {
                ["l"] = "confirm_nofocus",
                ["L"] = "confirm",
              },
            },
          },
          auto_close = true,
          layout = {
            cycle = true,
            preview = true, ---@diagnostic disable-line: assign-type-mismatch
            layout = {
              box = "horizontal",
              position = "float",
              height = 0.8,
              width = 0.85,
              border = "rounded",
              {
                box = "vertical",
                width = 40,
                min_width = 40,
                { win = "input", height = 1, title = "{title} {live} {flags}", border = "single" },
                { win = "list" },
              },
              { win = "preview", width = 0, border = "left" },
            },
          },
        },
      },
    },
  },
}
