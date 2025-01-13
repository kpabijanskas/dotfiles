local pn = require("plugin_names")

local function dap_config()
  local dap = require("dap")
  local widgets = require("dap.ui.widgets")
  local dvt = require("nvim-dap-virtual-text")
  local dap_go = require("dap-go")
  local telescope = require("telescope")

  dvt.setup()
  dap_go.setup()

  local wk = require("which-key")
  local kb_table = {
    {
      "<leader>gr",
      dap.run_last,
      desc = "Restart last debugging session",
    },
    { "<leader>gb", dap.toggle_breakpoint, desc = "Toggle breakpoint" },
    { "<leader>gc", dap.continue,          desc = "Continue" },
    { "<leader>gi", dap.step_into,         desc = "Step Into" },
    { "<leader>go", dap.step_out,          desc = "Step out" },
    { "<leader>gn", dap.step_over,         desc = "Step over" },
    {
      "<leader>gl",
      function()
        telescope.extensions.dap.list_breakpoints()
      end,
      desc = "List breakpoints",
    },
    {
      "<leader>gr",
      function()
        telescope.extensions.dap.configurations()
      end,
      desc = "Configurations",
    },
    {
      "<leader>gv",
      function()
        widgets.centered_float(widgets.scopes)
      end,
      desc = "Show scopes",
    },
    { "<leader>gt", dap.terminate, desc = "Terminate session" },
    {
      "<leader>gf",
      function()
        widgets.centered_float(widgets.frames)
      end,
      desc = "Show Frames",
    },
    { "<leader>ge", dap.repl.open, desc = "Open repl" },
    { "<leader>gh", widgets.hover, desc = "Hover" },
    {
      "<leader>ga",
      function()
        widgets.centered_float(widgets.threads)
      end,
      desc = "Show threads",
    },
  }
  wk.add({
    { mode = "n", kb_table },
    { mode = "v", kb_table },
  })

  -- dapui_breakpoints
  -- dapui_stacks
  -- dapui_watches
  -- dapui_scopes
  -- dapui_repl
  -- dapui_console
end

return {
  pn.dap,
  dependencies = {
    pn.dap_virtual_text,
    pn.dap_go,
    pn.telescope_dap,
    pn.telescope,
  },
  config = dap_config,
}
