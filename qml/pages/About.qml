import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: aboutPage
    allowedOrientations: Orientation.Portrait

    SilicaFlickable {
        id: aboutFlickable
        contentHeight: aboutColumn.y + aboutColumn.height

        VerticalScrollDecorator {
            flickable: aboutFlickable
        }

        anchors.fill: parent

        Column {
            id: aboutColumn
            width: parent.width - 2*Theme.paddingLarge
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: Theme.paddingMedium

            PageHeader {
                id: aboutHeader
                title: "About Neon Clock"
            }

            SectionHeader {
                text: "Credits"
            }

            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                wrapMode: Text.WordWrap
                text: "Neon Clock by direc85"
            }

            Item {
                width: parent.width
                height: Theme.iconSizeExtraLarge

                Rectangle {
                    id: gitRect
                    width: Theme.iconSizeLarge
                    height: Theme.iconSizeLarge
                    anchors.bottom: parent.bottom
                    x: parent.width/2 - width/2
                    color: "#696969"
                    opacity: 0.5
                    radius: width * 0.1
                }
                IconButton {
                    width: Theme.iconSizeMedium
                    height: Theme.iconSizeMedium
                    anchors.centerIn: gitRect
                    icon.source: "image://theme/icon-m-cloud-download"
                    onClicked: Qt.openUrlExternally("https://github.com/direc85/harbour-neonclock");
                }
            }

            SectionHeader {
                text: "Inspiration"
            }

            Label {
                width: parent.width
                wrapMode: Text.WordWrap
                text: "I got inspiration for this clock from Daniel Shiffman, who runs The Coding Train YouTube channel. "
                      + "The specific video was \"Coding Challenge #74: Clock with p5.js\". "
                      + "It turned out p5.js really makes your life easier..."
            }

            Item {
                width: parent.width
                height: Theme.iconSizeExtraLarge

                Rectangle {
                    id: leftRect
                    width: Theme.iconSizeLarge
                    height: Theme.iconSizeLarge
                    anchors.bottom: parent.bottom
                    x: parent.width/2 - 1.5*width
                    color: "#696969"
                    opacity: 0.5
                    radius: width * 0.1
                }
                IconButton {
                    width: Theme.iconSizeMedium
                    height: Theme.iconSizeMedium
                    anchors.centerIn: leftRect
                    icon.source: "image://theme/icon-m-file-video"
                    onClicked: Qt.openUrlExternally("https://youtu.be/E4RyStef-gY");
                }

                Rectangle {
                    id: rightRect
                    width: Theme.iconSizeLarge
                    height: Theme.iconSizeLarge
                    anchors.bottom: parent.bottom
                    x: parent.width/2 + 0.5*width
                    color: "#696969"
                    opacity: 0.5
                    radius: width * 0.1
                }
                IconButton {
                    width: Theme.iconSizeMedium
                    height: Theme.iconSizeMedium
                    anchors.centerIn: rightRect
                    icon.source: "image://theme/icon-m-train"
                    onClicked: Qt.openUrlExternally("http://codingtra.in");
                }
            }

            Label {
                width: parent.width
                wrapMode: Text.WordWrap
                text: "This is just a silly clock made for practicing QML Canvas, but if you really, really like it, you can buy me a coffee!"
            }

            BackgroundItem {
                anchors.horizontalCenter: parent.horizontalCenter
                width: Theme.iconSizeExtraLarge
                height: Theme.iconSizeExtraLarge
                onClicked: Qt.openUrlExternally("https://ko-fi.com/direc85")
                contentItem.radius: Theme.paddingSmall

                Image {
                    anchors.centerIn: parent
                    source: Qt.resolvedUrl("/usr/share/harbour-neonclock/images/Ko-fi_Icon_RGB_rounded.png")
                    width: Theme.iconSizeExtraLarge
                    height: Theme.iconSizeExtraLarge
                    smooth: true
                    asynchronous: true
                }
            }

            Item {
                width: parent.width
                height: Theme.paddingLarge
            }
        }
    }
}
