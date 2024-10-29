-- Terminal

return {
  {
    "akinsho/nvim-toggleterm.lua",
    version = "*",
    vscode = true,
    opts = {
      direction = "float",
      float_opts = {
        border = "double",
      },
      size = function(term)
        if term.direction == "horizontal" then
            return 30
        elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
        end
      end,
    },
    config = function(_, opts)
      require("toggleterm").setup(opts)
      vim.keymap.set("n", "<Leader>tt", ":ToggleTerm<CR>", { desc = "Toggle terminal" })
      vim.keymap.set("n", "<Leader>t1", ":1ToggleTerm<CR>", { desc = "Toggle terminal 1" })
      vim.keymap.set("n", "<Leader>t2", ":2ToggleTerm<CR>", { desc = "Toggle terminal 2" })
      vim.keymap.set("n", "<Leader>t3", ":3ToggleTerm<CR>", { desc = "Toggle terminal 3" })
      vim.keymap.set("n", "<Leader>t4", ":4ToggleTerm<CR>", { desc = "Toggle terminal 4" })
      vim.keymap.set("n", "<Leader>t5", ":5ToggleTerm<CR>", { desc = "Toggle terminal 5" })
    end,
  },
  {
    "willothy/flatten.nvim",
    opts = {
      window = {
        open = "alternate",
      },
      callbacks = {
        should_block = function(argv)
          -- Note that argv contains all the parts of the CLI command, including
          -- Neovim's path, commands, options and files.
          -- See: :help v:argv

          -- In this case, we would block if we find the `-b` flag
          -- This allows you to use `nvim -b file1` instead of `nvim --cmd 'let g:flatten_wait=1' file1`
          return vim.tbl_contains(argv, "-b")

          -- Alternatively, we can block if we find the diff-mode option
          -- return vim.tbl_contains(argv, "-d")
        end,
        post_open = function(bufnr, winnr, ft, is_blocking)
          if is_blocking then
            -- Hide the terminal while it's blocking
            require("toggleterm").toggle()
          else
            -- If it's a normal file, just switch to its window
            vim.api.nvim_set_current_win(winnr)
          end

          -- If the file is a git commit, create one-shot autocmd to delete its buffer on write
          -- If you just want the toggleable terminal integration, ignore this bit
          if ft == "gitcommit" then
            vim.api.nvim_create_autocmd("BufWritePost", {
              buffer = bufnr,
              once = true,
              callback = function()
                -- This is a bit of a hack, but if you run bufdelete immediately
                -- the shell can occasionally freeze
                vim.defer_fn(function()
                  vim.api.nvim_buf_delete(bufnr, {})
                end, 50)
              end,
            })
          end
        end,
        block_end = function()
          -- After blocking ends (for a git commit, etc), reopen the terminal
          require("toggleterm").toggle()
        end,
      },
    },
  },
}
