{ lib
, config
, self
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

    customConfig =
      mkOption
        {
          type = types.nullOr types.path;
          example = "./config";
          default = null;
          description = ''
            Folder with chadrc.lua and other custom configuration
          '';
        };
  };

  config = mkIf cfg.enable {
    programs.neovim.enable = true;
    programs.neovim.defaultEditor = mkIf cfg.defaultEditor true;

    xdg.configFile."nvim/lua/custom" = mkIf (cfg.customConfig != null) {
      source = cfg.customConfig;
      recursive = true;
    };

    xdg.configFile."nvim/lua" = {
      source = "${NvChad}/lua";
      recursive = true;
    };

    xdg.configFile."nvim/init.lua" = {
      source = "${NvChad}/init.lua";
    };
  };
}