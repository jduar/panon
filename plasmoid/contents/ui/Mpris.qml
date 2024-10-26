import QtQuick
import QtQuick.Layouts

import org.kde.plasma.plasmoid
import org.kde.plasma.private.mpris as Mpris

Item {
    id: mprisItem
    Timer {
        interval: 500
        running: true
        repeat: true
        onTriggered: {
            if (loaded) {
                mpris2Model.currentPlayer.updatePosition();
            }
        }
    }

    readonly property bool loaded: {
        if (mpris2Model.currentPlayer == null) {
            return false;
        }
        return true;
    }

    readonly property string track: loaded ? mpris2Model.currentPlayer.track : ""
    readonly property string artist: loaded ? mpris2Model.currentPlayer.artist : ""
    readonly property bool isPlaying: loaded ? mpris2Model.currentPlayer.playbackStatus === Mpris.PlaybackStatus.Playing : false

    Mpris.Mpris2Model {
        id: mpris2Model

        onRowsInserted: (_, rowIndex) => {
            refreshSource();
        }

        onRowsRemoved: (_, rowIndex) => {
            refreshSource();
        }

        function refreshSource() {
            const CONTAINER_ROLE = Qt.UserRole + 1
            for (var idx = 1; idx < rowCount(); ++idx) {
                const player = data(index(idx, 0), CONTAINER_ROLE)
                if (player.objectName === "@multiplex") {
                    currentIndex = idx;
                    return;
                }
            }
            currentIndex = 0;
        }
    }
}
