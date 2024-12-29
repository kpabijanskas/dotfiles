local pn = require("plugin_names")

local function telescope_config()
  local telescope = require("telescope")
  local builtin = require("telescope.builtin")
  local wk = require("which-key")

  telescope.load_extension("fzf")
  telescope.load_extension("dap")
  telescope.load_extension("orgmode")
  telescope.load_extension("chezmoi")

  telescope.setup({
    extensions = {
      dap = {
        overwrite_pick_one = false,
      },
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
      orgmode = {
        max_parents = nil,
        parent_separator = ' LOL> '
      }
    },
  })

  local kb_table = {
    { "<leader>C",  builtin.commands,   desc = "Open command picker" },
    { "<leader>f",  builtin.find_files, desc = "Open file picker" },
    { "<leader>FF", builtin.git_files,  desc = "Open Git file picker" },
    {
      "<leader>b",
      function()
        builtin.buffers({ ignore_current_buffer = true })
      end,
      desc = "Open buffer picker",
    },
    { "<leader>j", builtin.jumplist,              desc = "Open jumplist picker" },
    { "<leader>s", builtin.lsp_document_symbols,  desc = "Open symbol picker" },
    { "<leader>S", builtin.lsp_workspace_symbols, desc = "Open workspace symbol picker" },
    {
      "<leader>d",
      function()
        builtin.diagnostics({ bufnr = 0 })
      end,
      desc = "Open diagnostics picker",
    },
    { "<leader>D",  builtin.diagnostics,                     desc = "Open workspace diagnostics picker" },
    { "<leader>'",  builtin.resume,                          desc = "Open last picker" },
    { "<leader>/",  builtin.live_grep,                       desc = "Global search" },
    { "<leader>h",  builtin.lsp_references,                  desc = "Show symbol references" },
    { "<leader>vf", builtin.filetypes,                       desc = "Pick filetype" },
    { "<leader>vh", builtin.help_tags,                       desc = "Search vim help" },
    { "<leader>vc", telescope.extensions.chezmoi.find_files, desc = "Edit chezmoi files" },
    { "<leader>v?", builtin.commands,                        desc = "List available vim/plugin commands" },
    { "gd",         builtin.lsp_definitions,                 desc = "Goto definition" },
    { "gy",         builtin.lsp_type_definitions,            desc = "Goto type definition" },
    { "gr",         builtin.lsp_references,                  desc = "Goto references" },
    { "gi",         builtin.lsp_implementations,             desc = "Goto implementation" },
  }

  wk.add({
    kb_table,
    { mode = "v", kb_table },
  })
end

return {
  {
    pn.telescope_fzf_native,
    build = "make",
  },
  {
    pn.telescope,
    tag = "0.1.5",
    dependencies = {
      pn.telescope_fzf_native,
      pn.plenary,
      pn.which_key,
      pn.telescope_orgmode,
      pn.chezmoi,
    },
    config = telescope_config,
  },
}
