import QtQuick 2.2
import Sailfish.Silica 1.0
import "../components"

CoverBackground {
    id: cover
    anchors.fill: parent
    transparent: true

    Timer {
        id: coverClockTimer
        interval: 1000/15
        repeat: true
        running: cover.status == Cover.Active
        onTriggered: coverClock.requestPaint()
    }

    Rectangle {
        anchors.fill: parent
        color: 'black'
    }

    NeonClock {
        id: coverClock
        width: parent.width
        height: parent.width
        coverMode: true
        anchors.centerIn: parent
    }
}
