import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

Window {
  width: 640
  height: 480
  visible: true
  title: qsTr("Hello World")

  ImageButton {
    width: 100
    height: 100

    source: "/random.png"
  }
}
