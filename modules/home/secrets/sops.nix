
{ inputs, self, ... }: {

  flake.nixosModules.sops = { pkgs, ... }: {
   	imports = [
  		inputs.sops-nix.nixosModules.sops
   	];

   	programs.sops = {
   	  defaultSopsFile = "./secrets.yaml";
   	  secrets = {};
   	};
  };
}
