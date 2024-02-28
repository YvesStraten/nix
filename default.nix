{ lib
, config
, pkgs
, ...
}:
let
  inherit (lib) mkOption types mkIf;
  cfg = config.programs.NvChad;
  NvChad = pkgs.callPackage ./package.nix { };
in
{
  options.programs.NvChad = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Enable Nvchad
      '';
    };
    defaultEditor = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Sets Nvchad as your default editor
      '';
    };

    otherConfigs =
      mkOption
        {
          type = types.nullOr types.path;
          example = "./config";
          default = null;
          description = ''
            Folder with other configuration files that you wish to be added to `lua/custom`
          '';
        };

    chadrcContents = mkOption {
      type = types.nullOr types.lines;
      default = null;
      description = ''
        Contents to go into the chadrc.lua file
      '';
    };

    initLuaContents = mkOption {
      type = types.nullOr types.lines;
      default = null;
      description = ''
        Contents to go into the init.lua file
      '';
    };
  };

  config = mkIf cfg.enable {
    programs.neovim.enable = true;
    programs.neovim.defaultEditor = mkIf cfg.defaultEditor true;

    xdg.configFile."nvim/lua/custom" = mkIf (cfg.otherConfigs != null) {
      source = cfg.otherConfigs;
      recursive = true;
    };

    xdg.configFile."nvim/lua/custom/chadrc.lua" = mkIf (cfg.chadrcContents != null) {
      text = cfg.chadrcContents;
    };

    xdg.configFile."nvim/lua/custom/init.lua" = mkIf (cfg.initLuaContents != null) {
      text = cfg.initLuaContents;
    };

    xdg.configFile."nvim/lua" = {
      source = "${NvChad}/.config/nvim/lua";
      recursive = true;
    };

    xdg.configFile."nvim/init.lua" = {
      source = "${NvChad}/.config/nvim/init.lua";
    };
  };
}
