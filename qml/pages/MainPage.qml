import QtQuick 2.0
import Sailfish.Silica 1.0
import "../components"

Page {
    id: page
    allowedOrientations: Orientation.All
    property real newOpacity: 1.0

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: parent.height

        Rectangle {
            anchors.fill: parent
            color: 'black'
        }

        PullDownMenu {
            enabled: opacity > 0.0
            opacity: newOpacity
            Behavior on opacity {
                NumberAnimation {}
            }

            MenuItem {
                text: clock.drawPendulum ? qsTr("Hide pendulum") : qsTr("Show pendulum")
                onClicked: clock.drawPendulum = !clock.drawPendulum
            }
            MenuItem {
                text: clock.drawSeconds ? qsTr("Hide seconds") : qsTr("Show seconds")
                onClicked: drawSecondsGlobal = !drawSecondsGlobal
            }
            MenuItem {
                text: qsTr("About")
                onClicked: pageStack.push(Qt.resolvedUrl("About.qml"))
            }
        }

        Timer {
            id: clockDrawTimer
            interval: (clock.drawSeconds || clock.drawPendulum) ? 1000/30 : 1000
            running: parent.visible
            repeat: true
            onTriggered: clock.requestPaint()
            onIntervalChanged: clock.requestPaint()
        }

        PageHeader {
            title: qsTr("Neon Clock")
            visible: opacity > 0.0
            opacity: newOpacity
            Behavior on opacity {
                NumberAnimation {}
            }
        }


        NeonClock {
            id: clock
            width: isPortrait ? parent.width : parent.height
            height: width
            coverMode: false
            drawSeconds: drawSecondsGlobal
            anchors.centerIn: parent
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if(newOpacity === 1.0)
                        newOpacity = 0.0
                    else
                        newOpacity = 1.0
                }
            }
        }
    }
}
