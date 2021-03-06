import QtQuick 2.2
import Sailfish.Silica 1.0
import "../components"

CoverBackground {
    id: cover
    anchors.fill: parent
    transparent: true

    Timer {
        id: coverClockTimer
        interval: coverClock.drawSeconds ? 1000/30 : 1000
        repeat: true
        running: cover.status == Cover.Active
        onTriggered: coverClock.requestPaint()
    }

    Rectangle {
        anchors.fill: parent
        color: 'black'
        opacity: 0.625
    }

    NeonClock {
        id: coverClock
        drawSeconds: drawSecondsGlobal
        width: parent.width * 0.9
        height: parent.width * 0.9
        coverMode: true
        anchors.centerIn: parent
    }
}
