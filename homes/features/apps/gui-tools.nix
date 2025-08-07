{ unstable, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      blender = prev.blender.overrideAttrs (old: {
        pythonPath = (old.pythonPath or []) ++ [unstable.python313Packages.py-slvs];
      });
    })
  ];

  home.packages = with unstable; [
    blender
    chromium
    gimp
    inkscape
    obsidian
    orca-slicer
    qtpass
  ];
}
