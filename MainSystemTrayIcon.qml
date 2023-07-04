/*
 * 2021051205101tianfu
 * */
import Qt.labs.platform 1.0
import QtQuick.Controls

//缩小时的系统托盘
SystemTrayIcon {

    id:systemTray
    visible: true

    onActivated: {
        window.show()
        window.raise()
        window.requestActivate()
    }
    menu: Menu{
        id:menu
        MenuItem{
            text: "上一曲"
            onTriggered: BottomView.playPrevious()
        }
        MenuItem{
            text: layoutBottomView.playingState===0?"播放":"暂停"
            //onTriggered: BottomView.playOrPause()
        }
        MenuItem{
            text: "下一曲"
            onTriggered: BottomView.playNext()
        }
        MenuSeparator{}
        MenuItem{
            text: "显示"
            onTriggered: window.show()
        }
        MenuItem{
            text: "退出"
            onTriggered: Qt.quit()
        }
    }
}
