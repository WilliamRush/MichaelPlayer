import QtQuick
import QtQuick.Window

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")


    Rectangle{
        id:background
        anchors.fill:  parent
        color: "red"
    }
}
