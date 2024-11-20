{ lib, ... }:

with lib.hm.gvariant;
{
  dconf.settings = {
    "org/gnome/desktop/input-sources" = {
       current = mkUint32 0;
       mru-sources = [ (mkTuple [ "xkb" "us+alt-intl" ]) (mkTuple [ "xkb" "de" ]) ];
       per-window = false;
       sources = [ (mkTuple [ "xkb" "us+alt-intl" ]) (mkTuple [ "xkb" "de" ]) ];
       xkb-options = ["caps:swapescape" "lv3:ralt_switch"];
    };
  };
}
