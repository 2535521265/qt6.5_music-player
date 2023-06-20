import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ColumnLayout{
    Rectangle {
        Layout.fillWidth: true
        width: parent.width
        height: 50
        color: "#00000000"
        Text {
            width: parent.width
            height: parent.height
            verticalAlignment: Text.AlignVCenter  //字体上下居中
            text: qsTr("历史音乐")
            font.family: "微软雅黑"
            font.pointSize: 20
        }
    }
    MusicListView{
        id:historyMusicListView
        Layout.topMargin: 10
    }
}
