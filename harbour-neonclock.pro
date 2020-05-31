TARGET = harbour-neonclock

CONFIG += sailfishapp_qml

DISTFILES += qml/harbour-neonclock.qml \
    qml/cover/CoverPage.qml \
    rpm/harbour-neonclock.spec \
    rpm/harbour-neonclock.yaml \
    harbour-neonclock.desktop \
    qml/components/NeonClock.qml \
    qml/pages/MainPage.qml \
    qml/pages/About.qml \
    rpm/harbour-neonclock.changes

SAILFISHAPP_ICONS = 86x86 108x108 128x128 172x172

images.files = images
images.path = /usr/share/$${TARGET}

INSTALLS += images
