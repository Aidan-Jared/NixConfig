{inputs, ...}: {
  perSystem = {pkgs, ...}: let
    islandBackendPlugin = pkgs.stdenv.mkDerivation {
      pname = "island-backend";
      version = "1.0.0";

      src = pkgs.lib.fileset.toSource {
        root = ./.;
        fileset = pkgs.lib.fileset.unions [ ./CMakeLists.txt ./backend ];
      };

      nativeBuildInputs = with pkgs; [ cmake ninja qt6.wrapQtAppsHook ];
      buildInputs = with pkgs.qt6; [ qtbase qtdeclarative ];

      cmakeFlags = [ "-GNinja" ];

      # qt_add_qml_module builds straight into the cmake build dir,
      # which is also the cwd during installPhase.
      installPhase = ''
        runHook preInstall
        mkdir -p $out/IslandBackend
        cp libIslandBackend.so libIslandBackendPlugin.so qmldir IslandBackend.qmltypes $out/IslandBackend/
        runHook postInstall
      '';
    };
  in {
    packages.islandBackendPlugin = islandBackendPlugin;

    packages.quickshellWrapped = inputs.wrappers.lib.wrapPackage {
      inherit pkgs;
      package = pkgs.quickshell;
      env = {
        # $out already matches the IslandBackend/ URI folder convention,
        # so it's added as-is to the QML import search path.
        QML_IMPORT_PATH = "$QML_IMPORT_PATH:${islandBackendPlugin}";
        LD_LIBRARY_PATH = "$LD_LIBRARY_PATH:${islandBackendPlugin}/IslandBackend";
      };
      flags = {
        "-p" = toString ./.;
      };
    };
  };
}
