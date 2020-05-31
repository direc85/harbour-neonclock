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


# German translation is enabled as an example. If you aren't
# planning to localize your app, remember to comment out the
# following TRANSLATIONS line. And also do not forget to
# modify the localized app name in the the .desktop file.
TRANSLATIONS += translations/harbour-neonclock-de.ts
