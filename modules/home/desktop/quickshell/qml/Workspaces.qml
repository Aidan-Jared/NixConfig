import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

// Mango (mangowc) tag/workspace indicator, driven by the `mmsg` IPC tool.
//
// Mango reports tag state per-monitor as:
//   { "monitors": [ { "name": ..., "active": bool,
//                      "tags": [ { "index": 1, "is_active": bool,
//                                  "is_urgent": bool, "client_count": n }, ... ],
//                      ... } ] }
// We watch the currently focused ("active") monitor and mirror its tags,
// which is the same "single global bar" behaviour the original Hyprland
// version had (it also just followed the globally focused workspace).
RowLayout {
  id: root
  Layout.fillWidth: false
  spacing: 4 * Config.paddingScale

  // tags of the currently focused monitor, as reported by mango
  property var tags: []

  function tagFor(idx) {
    for (let i = 0; i < tags.length; i++)
      if (tags[i].index === idx) return tags[i]
    return null
  }

  function applyMonitors(monitors) {
    if (!monitors || monitors.length === 0) return
    let mon = monitors.find(m => m.active) || monitors[0]
    root.tags = mon.tags || []
  }

  // one-shot query so the bar isn't empty before the first watch event
  Process {
    id: primeProc
    command: ["mmsg", "get", "all-monitors"]
    running: true
    stdout: StdioCollector {
      onStreamFinished: {
        try {
          const data = JSON.parse(this.text.trim())
          root.applyMonitors(data.monitors)
        } catch (e) { /* mango not ready yet, watcher below will catch up */ }
      }
    }
  }

  // live updates
  Process {
    id: watchProc
    command: ["mmsg", "watch", "all-monitors"]
    running: true
    stdout: SplitParser {
      splitMarker: "\n"
      onRead: line => {
        if (!line || line.trim() === "") return
        try {
          const data = JSON.parse(line)
          root.applyMonitors(data.monitors)
        } catch (e) { /* ignore malformed/partial lines */ }
      }
    }
  }

  Process { id: dispatchProc; running: false }

  function viewTag(idx) {
    dispatchProc.command = ["mmsg", "dispatch", "view," + idx]
    dispatchProc.running = false
    dispatchProc.running = true
  }

  Repeater {
    model: Config.maxWorkspaces // max workspace buttons/texts to show

    delegate: Rectangle {
      id: wsButton

      required property int index
      property var tag: root.tagFor(index + 1)
      property bool isActive: !!tag && tag.is_active
      property bool isUrgent: !!tag && tag.is_urgent
      property bool isOccupied: !!tag && tag.client_count > 0
      property string activeBg: "#4d5258"
      property string inactiveBg: "#393c41"
      property string urgentBg: "#ef5e5e"

      Layout.preferredWidth: 17.5 * Config.pillScale
      Layout.preferredHeight: Layout.preferredWidth
      radius: 8 * Config.pillScale
      color: isUrgent ? urgentBg : isActive ? activeBg : (isOccupied ? inactiveBg : "transparent")

      // animate color transition on workspace/tag switch
      Behavior on color { ColorAnimation { duration: 120 } }

      Text {
        anchors.centerIn: parent
        text: wsButton.index + 1
        color: (wsButton.isActive || wsButton.isUrgent) ? "#ffffff" : "#dae0ea"
        font {
          family: Theme.fontFamily
          pixelSize: 9 * Config.pillScale
          weight: 300
        }
      }

      // clickable text buttons
      MouseArea {
        anchors.fill: parent
        onClicked: root.viewTag(wsButton.index + 1)
        cursorShape: Qt.PointingHandCursor
      }
    }
  }
}
