import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQml 2.12

ColumnLayout{

    Rectangle{

        Layout.fillWidth: true
        width: parent.width
        height: 60
        color: "#00000000"
        Text {
            x:10
            verticalAlignment: Text.AlignBottom
            text: qsTr("历史播放")
            font.family: window.mFONT_FAMILY
            font.pointSize: 25
        }
    }

    RowLayout{
        height: 80
        Item{
            width: 5
        }
        MusicTextButton{
            btnText: "刷新记录"
            btnHeight: 50
            btnWidth: 120
            onClicked: getHistory()
        }
        MusicTextButton{
            btnText: "清空记录"
            btnHeight: 50
            btnWidth: 120
            onClicked: clearHistory()
        }

    }

    MusicListView{
        id:historyListView
    }
    Component.onCompleted: {
        getHistory()
    }

    function getHistory(){
        historyListView.musicList = historySettings.value("history",[])
    }

    function clearHistory(){
        historySettings.setValue("history",[])
        getHistory()
    }

}
