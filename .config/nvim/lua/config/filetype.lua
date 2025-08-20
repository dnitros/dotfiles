vim.filetype.add({
  extension = {
    zsh = "sh",
    sh = "sh", -- force sh-files with zsh-shebang to still get sh as filetype
  },
  filename = {
    [".aliases"] = "sh",
    [".shellrc"] = "sh",
    [".zprofile"] = "sh",
    [".zshenv"] = "sh",
    [".zshrc"] = "sh",
  },
})
