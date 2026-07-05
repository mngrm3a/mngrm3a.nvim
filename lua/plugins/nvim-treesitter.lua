return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
        ensure_installed = {
            "bash",
            "nix",

            "go",
            "lua",
            "python",

            "vim",
            "vimdoc",

            "markdown",
            "markdown_inline",
            "json",
            "yaml",
            "toml",
        },
        auto_install = true,
    },
}
