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
            text: qsTr("我喜欢的")
            font.family: "微软雅黑"
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
            onClicked: getFavorite()
        }
        MusicTextButton{
            btnText: "清空记录"
            btnHeight: 50
            btnWidth: 120
            onClicked: clearFavorite()
        }

    }

    MusicListView{
        id:favoriteListView
    }
    Component.onCompleted: {
        getFavorite()
    }

    function getFavorite(){
        favoriteListView.musicList = favoriteSettings.value("favorite",[])
    }

    function clearFavorite(){
        favoriteSettings.setValue("favorite",[])
        getFavorite()
    }

}
