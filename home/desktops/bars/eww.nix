
{ pkgs, ... }:
{
  programs.eww = {
    enable = true;
    systemd.enable = true;

    yuckConfig = ''
      ;; ── Variables ─────────────────────────────────────────────────────
      (defpoll workspaces :interval "1s"
        :initial "[]"
        `niri msg -j workspaces`)

      (defpoll active-window :interval "1s"
        :initial ""
        `niri msg -j focused-window | ${pkgs.jq}/bin/jq -r '.title // ""'`)

      (deflisten workspaces-listen
        `niri msg -j event-stream | ${pkgs.jq}/bin/jq --unbuffered -r 'select(.WorkspacesChanged) | .WorkspacesChanged.workspaces'`)

      ;; ── Widgets ───────────────────────────────────────────────────────
      (defwidget workspaces []
        (box :class "workspaces" :orientation "h" :space-evenly false
          (for ws in workspaces
            (button
              :class {ws.is_focused ? "workspace active" : "workspace"}
              :onclick "niri msg action focus-workspace ${ws.idx}"
              {ws.idx}))))

      (defwidget clock []
        (box :class "clock"
          (label :text {formattime(EWW_TIME, "%H:%M  %a %d %b")})))

      (defwidget cpu []
        (box :class "cpu"
          (label :text {"  " + round(EWW_CPU.avg, 0) + "%"})))

      (defwidget memory []
        (box :class "memory"
          (label :text {"  " + round(EWW_RAM.used_mem_perc, 0) + "%"})))

      (defwidget network []
        (box :class "network"
          (label :text {EWW_NET.wlan0.NET_UP > 0 ? "  connected" : "⚠ disconnected"})))

      (defwidget volume []
        (box :class "volume"
          (label :text {"  " + volume + "%"})))

      (defwidget tray []
        (box :class "tray" :orientation "h" :space-evenly false
          (systray :spacing 8)))

      (defwidget top-left []
        (box :orientation "h" :space-evenly false :halign "start"
          (workspaces)
          (label :class "active-window" :text active-window :limit-width 60)))

      (defwidget top-center []
        (box :orientation "h" :halign "center"
          (clock)))

      (defwidget top-right []
        (box :orientation "h" :space-evenly false :halign "end"
          (cpu)
          (memory)
          (network)
          (tray)))

      (defwidget bottom-left []
        (box :orientation "h" :space-evenly false :halign "start"
          (label :text "niri")))

      (defwidget bottom-center []
        (box :orientation "h" :halign "center"
          (label :text "")))

      (defwidget bottom-right []
        (box :orientation "h" :space-evenly false :halign "end"
          (label :text {formattime(EWW_TIME, "%Y-%m-%d")})))

      ;; ── Windows ───────────────────────────────────────────────────────
      (defwindow top-bar
        :monitor 0
        :geometry (geometry :x "0%"
                            :y "0px"
                            :width "100%"
                            :height "30px"
                            :anchor "top center")
        :stacking "fg"
        :reserve (struts :distance "30px" :side "top")
        :windowtype "dock"
        :wm-ignore false
        (box :orientation "h" :class "bar top"
          (top-left)
          (top-center)
          (top-right)))

      (defwindow bottom-bar
        :monitor 0
        :geometry (geometry :x "0%"
                            :y "0px"
                            :width "100%"
                            :height "30px"
                            :anchor "bottom center")
        :stacking "fg"
        :reserve (struts :distance "30px" :side "bottom")
        :windowtype "dock"
        :wm-ignore false
        (box :orientation "h" :class "bar bottom"
          (bottom-left)
          (bottom-center)
          (bottom-right)))
    '';

    scssConfig = ''
      * {
        font-family: "JetBrainsMono Nerd Font", monospace;
        font-size: 13px;
      }

      .bar {
        background: rgba(30, 30, 46, 0.9);
        color: #cdd6f4;
        padding: 0 8px;
      }

      .workspaces {
        .workspace {
          padding: 0 6px;
          color: #6c7086;
          background: transparent;
          border: none;

          &.active {
            color: #89b4fa;
            border-bottom: 2px solid #89b4fa;
          }

          &:hover {
            color: #cdd6f4;
            background: rgba(255,255,255,0.05);
          }
        }
      }

      .active-window {
        color: #cdd6f4;
        margin-left: 8px;
      }

      .clock  { color: #a6e3a1; }
      .cpu    { color: #fab387; margin: 0 4px; }
      .memory { color: #f38ba8; margin: 0 4px; }
      .network { color: #89dceb; margin: 0 4px; }
      .volume  { color: #cba6f7; margin: 0 4px; }
    '';
  };

  # auto-open both bars
  systemd.user.services.eww-bars = {
    Unit = {
      Description = "EWW bars";
      After = [ "eww.service" "graphical-session.target" ];
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.eww}/bin/eww open-many top-bar bottom-bar";
      RemainAfterExit = true;
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
}
