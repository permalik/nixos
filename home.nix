{ config, pkgs, ... }:

{
  home.username = "permalik";
  home.homeDirectory = "/home/permalik";

  home.packages = with pkgs; [
    lsof
    zip
    unzip
    ripgrep
    fzf
    jq
    tmux
    neovim
  ];

  home.file.".ssh/allowed_signers".text = "* ${builtins.readFile ./id_ed25519.pub}";

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -al";
      nv = "vim";
      update = "sudo nixos-rebuild switch";
    };

    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
  };

  programs.git = {
    enable = true;
    userName = "permalik";
    userEmail = "permalik@protonmail.com";
    extraConfig = {
      commit.gpgsign = true;
      gpg.format = "ssh";
      gpg.ssh.allowedSignersFile = "~/.ssh/allowed_signers";
      user.signingkey = "~/.ssh/id_ed25519.pub";
    };
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
      line_break.disabled = false;
    };
  };

  programs.wezterm = {
    enable = true;
    # extraConfig = builtins.readFile ./dotfiles/wezterm/wezterm.lua;
  };

  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
}
