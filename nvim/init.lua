require("plugins")

local opt = vim.opt

opt.relativenumber = true
opt.undofile = true
opt.writebackup = false
opt.modeline = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.expandtab = true
opt.autoindent = true


local umlauts_enabled = false

local function toggle_umlauts()
  umlauts_enabled = not umlauts_enabled

  local buf = 0 -- current buffer
  local opts = { buffer = buf }

  if umlauts_enabled then
    vim.keymap.set("i", [["a]], "ä", opts)
    vim.keymap.set("i", [["A]], "Ä", opts)
    vim.keymap.set("i", [["u]], "ü", opts)
    vim.keymap.set("i", [["U]], "Ü", opts)
    vim.keymap.set("i", [["o]], "ö", opts)
    vim.keymap.set("i", [["O]], "Ö", opts)
    vim.keymap.set("i", [["s]], "ß", opts)
  else
    vim.keymap.del("i", [["a]], { buffer = buf })
    vim.keymap.del("i", [["A]], { buffer = buf })
    vim.keymap.del("i", [["u]], { buffer = buf })
    vim.keymap.del("i", [["U]], { buffer = buf })
    vim.keymap.del("i", [["o]], { buffer = buf })
    vim.keymap.del("i", [["O]], { buffer = buf })
    vim.keymap.del("i", [["s]], { buffer = buf })
  end
end

vim.keymap.set("i", "<F2>", function()
  toggle_umlauts()
end, { desc = "Toggle umlaut insert mappings" })

opt.grepprg = "rg --vimgrep --no-heading --smart-case"

vim.keymap.set("n", "<leader>a",
  [[:silent lgrep "\b<C-r><C-w>\b"<CR><CR>:lopen<CR>]],
  { silent = true, desc = "Search word with lgrep and open location list" }
)
