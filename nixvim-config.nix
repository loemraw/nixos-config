{
  programs.nixvim = {
    enable = true;

    # Basic Vim settings (from your nice.lua)
    opts = {
      relativenumber = true;
      number = true;
      tabstop = 4;
      shiftwidth = 4;
      autoindent = true;
      ignorecase = true;
      smartcase = true;
      termguicolors = true;
      splitright = true;
      splitbelow = true;
      mouse = "";
      signcolumn = "yes";
      shortmess = "A";
    };

    # Leader keys
    globals = {
      mapleader = " ";
      maplocalleader = "\\";
    };

    # Key mappings (from your nice.lua)
    keymaps = [
      # Clipboard mappings
      {
        mode = [ "n" "v" ];
        key = "<leader>c";
        action = ''"+'';
        options = {
          noremap = true;
          silent = false;
        };
      }

      # jk escape
      {
        mode = "i";
        key = "jk";
        action = "<esc>";
        options = {
          noremap = true;
          silent = false;
        };
      }

      # Split mappings
      {
        mode = "n";
        key = "<leader>sv";
        action = ":vsplit<CR>";
      }
      {
        mode = "n";
        key = "<leader>sh";
        action = ":split<CR>";
      }
      {
        mode = "n";
        key = "<c-h>";
        action = "<c-w>h<CR>";
      }
      {
        mode = "n";
        key = "<c-j>";
        action = "<c-w>j<CR>";
      }
      {
        mode = "n";
        key = "<c-k>";
        action = "<c-w>k<CR>";
      }
      {
        mode = "n";
        key = "<c-l>";
        action = "<c-w>l<CR>";
      }

      # LSP keymaps (will be set up in LSP config)
      {
        mode = "n";
        key = "K";
        action = "<cmd>lua vim.lsp.buf.hover()<cr>";
        options = { desc = "Hover"; };
      }
      {
        mode = "n";
        key = "gd";
        action = "<cmd>FzfLua lsp_definitions<cr>";
        options = { desc = "Go to definition"; };
      }
      {
        mode = "n";
        key = "gD";
        action = "<cmd>FzfLua lsp_declarations<cr>";
        options = { desc = "Go to declaration"; };
      }
      {
        mode = "n";
        key = "gi";
        action = "<cmd>FzfLua lsp_implementations<cr>";
        options = { desc = "Go to implementation"; };
      }
      {
        mode = "n";
        key = "gr";
        action = "<cmd>FzfLua lsp_references<cr>";
        options = { desc = "Go to references"; };
      }
      {
        mode = "n";
        key = "gl";
        action = "<cmd>lua vim.diagnostic.open_float()<cr>";
        options = { desc = "Open diagnostic float"; };
      }
      {
        mode = "n";
        key = "gL";
        action = "<cmd>FzfLua lsp_document_diagnostics<cr>";
        options = { desc = "Document diagnostics"; };
      }
      {
        mode = "n";
        key = "gs";
        action = "<cmd>lua vim.lsp.buf.signature_help()<cr>";
        options = { desc = "Signature help"; };
      }
      {
        mode = "n";
        key = "<leader>rn";
        action = "<cmd>lua vim.lsp.buf.rename()<cr>";
        options = { desc = "Rename"; };
      }
      {
        mode = [ "n" "v" ];
        key = "<leader>fb";
        action = "<cmd>lua require('conform').format()<cr>";
        options = { desc = "Format buffer"; };
      }
      {
        mode = "n";
        key = "ca";
        action = "<cmd>lua vim.lsp.buf.code_action()<cr>";
        options = { desc = "Code action"; };
      }

      # mini.files
      {
        mode = "n";
        key = "<leader>ft";
        action =
          "<cmd>lua require('mini.files').open(vim.api.nvim_buf_get_name(0), true)<cr>";
        options = { desc = "Open mini.files (Directory of current file)"; };
      }
    ];

    # Plugins
    plugins = {
      # Treesitter
      treesitter = {
        enable = true;
        settings = {
          highlight.enable = true;
          indent.enable = true;
        };
      };

      # LSP
      lsp = {
        enable = true;
        servers = {
          lua_ls = { enable = true; };
          clangd = { enable = true; };
          bashls = { enable = true; };
          pyright = { enable = true; };
          rust_analyzer = {
            enable = true;
            installRustc = false;
            installCargo = false;
          };
          nil_ls.enable = true;
        };
      };

      # Completion with blink.cmp equivalent (using built-in cmp for now)
      cmp = {
        enable = true;
        settings = {
          snippet.expand =
            "function(args) require('luasnip').lsp_expand(args.body) end";
          mapping = {
            "<C-k>" = "cmp.mapping.select_prev_item()";
            "<C-j>" = "cmp.mapping.select_next_item()";
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-u>" = "cmp.mapping.scroll_docs(4)";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
          };
          sources = [
            { name = "nvim_lsp"; }
            { name = "luasnip"; }
            { name = "buffer"; }
            { name = "path"; }
          ];
        };
      };

      # Snippets
      luasnip = {
        enable = true;
        fromVscode = [{ paths = "./friendly-snippets"; }];
      };

      # Git integration
      gitsigns = { enable = true; };

      # File explorer equivalent to mini.files
      mini = {
        enable = true;
        modules = {
          ai.enable = true;
          files = {
            enable = true;
            windows = { preview = false; };
            options = { use_as_default_explorer = true; };
          };
        };
      };

      # Fuzzy finder (fzf-lua equivalent)
      telescope = {
        enable = true;
        keymaps = {
          "<leader>ff" = "find_files";
          "<leader>fg" = "live_grep";
          "<leader>fb" = "buffers";
          "<leader>fh" = "help_tags";
        };
      };

      # Which-key
      which-key = { enable = true; };

      # Code formatting
      conform-nvim = {
        enable = true;
        settings = {
          formatters_by_ft = {
            lua = [ "stylua" ];
            python = [ "black" ];
            rust = [ "rustfmt" ];
            c = [ "clang-format" ];
            cpp = [ "clang-format" ];
            sh = [ "shfmt" ];
            nix = [ "nixfmt" ];
          };
          format_on_save = {
            timeout_ms = 500;
            lsp_fallback = true;
          };
        };
      };
    };

    plugins.web-devicons.enable = true;

    # Clipboard configuration (OSC52 support)
    extraConfigVim = ''
      set shortmess=A
    '';

    extraConfigLua = ''
      -- OSC52 clipboard configuration
      local function paste()
        return {
          vim.fn.split(vim.fn.getreg(""), "\n"),
          vim.fn.getregtype(""),
        }
      end

      vim.g.clipboard = {
        name = "OSC 52",
        copy = {
          ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
          ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
        },
        paste = {
          ["+"] = paste,
          ["*"] = paste,
        },
      }
    '';
  };
}
