# NvChad Nix/NixOS support
This flake aims to support the Nix Package manager and the NixOS system.

# Want to test NvChad out?
Just use this command on flakes enabled system:

``` bash
nix run "github:NvChad/nix"
```

## How to use it 
Add the url of the repo to your `inputs`

``` nix
{
	inputs = {
		NvChad.url = "github:NvChad/nix";
	...
}
```

Then expose your inputs with `@inputs`, then pass your inputs to home-manager with `extraSpecialArgs`.
``` nix
outputs = { nvchad, ...}@inputs: {
	...
	home-manager = {
		extraSpecialArgs = { inherit inputs; };
		...
	};
	...
}
```

Finally, import the home-manager module and enable NvChad

``` nix
{ inputs, pkgs, ...}: {
	imports = [
		inputs.NvChad.homeManagerModules.default
	];
	
	programs.NvChad.enable = true;
}
```

Now you just need to rebuild your system.

## Available options 
### `programs.NvChad.enable`
Enables NvChad

### `defaultEditor`
Sets your `$EDITOR` variable to be NvChad

### `otherConfigs`
Folder with other configuration files that you wish to be added to `lua/custom`

### `chadrcContents` and `initLuaContents`
Define the content of `charc.lua` and/or `init.lua`. This can either be lines, or you can import your files into the lines with `${builtins.readFile ./some-path}`

