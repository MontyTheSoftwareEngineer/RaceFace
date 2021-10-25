import QtQuick 2.12

Rectangle {
    property string buttonText: "buttonText"
    property string buttonColor: "#A5CD50"
    property string buttonPressedColor: "#759139"
    property string buttonTextColor: "white"

    FontLoader {
        id: customFont
        source: "qrc:/ui/assets/Highman.ttf"
    }

    signal clicked()
    signal pressed()
    signal released()


    id: stylizedButton
    color: buttonColor
    radius: 10

    Text {
        font.pixelSize: 26 * ( parent.height / 75)
        color: buttonTextColor
        anchors.centerIn: parent
        font.family: customFont.name
        text: buttonText
    }
    MouseArea {
        anchors.fill: parent
        onPressed: {
            parent.color = buttonPressedColor
            stylizedButton.pressed()
        }
        onReleased: {
            parent.color = buttonColor
            stylizedButton.released()
        }
        onClicked: {
            stylizedButton.clicked()
        }
    }
}
