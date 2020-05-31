import QtQuick 2.0
import Sailfish.Silica 1.0
import "../components"

Page {
    id: page
    allowedOrientations: Orientation.All

    SilicaFlickable {
        enabled: isPortrait
        anchors.fill: parent
        contentHeight: parent.height

        Rectangle {
            anchors.fill: parent
            color: 'black'
        }

        PullDownMenu {
            enabled: isPortrait
            visible: isPortrait
            MenuItem {
                text: qsTr("About")
                onClicked: pageStack.push(Qt.resolvedUrl("About.qml"))
            }
        }

        Timer {
            id: clockDrawTimer
            interval: 1000/25
            running: parent.visible
            repeat: true
            onTriggered: clock.requestPaint()
        }

        PageHeader {
            title: qsTr("Neon Clock")
            visible: isPortrait
        }


        NeonClock {
            id: clock
            width: isPortrait ? parent.width : parent.height
            height: width
            coverMode: false
            anchors.centerIn: parent
        }
    }
}
