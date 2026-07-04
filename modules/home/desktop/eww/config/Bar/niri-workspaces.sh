#!/usr/bin/env bash

eww-niri-workspaces | jq --unbuffered --raw-output '
  .outputs["eDP-1"].workspaces | 
  sort_by(.index) | 
  map(
    . as $ws |
    "(eventbox :cursor \"hand\" (box :class \"ws-card " + (if $ws.is_active then "ws-active" else "ws-inactive" end) + "\" :space-evenly false :spacing 4 " +
    (if ($ws.columns | length) > 0 then
      ($ws.columns | map(
        "(box :class \"niri-col " + (if .has_focused_window then "col-focused" else "col-unfocused" end) + "\")"
      ) | join(" "))
     else
       "(box :class \"niri-col col-empty\")"
     end) +
    "))"
  ) | join(" ") | "(box :class \"workspaces-container\" :space-evenly false :spacing 10 " + . + ")"
'
