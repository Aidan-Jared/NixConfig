
{ inputs, self, ... }: {

  flake.nixosModules.sops = { pkgs, ... }: {
   	imports = [
  		inputs.sops-nix.nixosModules.sops
   	];

   	home.packages = [
   	  pkgs.age
   	];

   	programs.sops = {
   	  defaultSopsFile = "./secrets.yaml";
   	  secrets = {};
   	};
  };
}
