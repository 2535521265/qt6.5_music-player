import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    Layout.fillWidth: true
    width: parent.width
    height: 50
    color: "#00000000"

    Text {
        width: parent.width
        height: parent.height
        verticalAlignment: Text.AlignVCenter  //字体上下居中
        horizontalAlignment: Text.AlignHCenter  //字体左右居中

        text: qsTr("本地音乐")
        font.family: "微软雅黑"
        font.pointSize: 20
    }
}
