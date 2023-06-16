import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import myhttp 1.0
import QtMultimedia
import Qt.labs.settings

//主界面
ApplicationWindow {

    property int w_width: 1300
    property int w_height: 800

    id:window
    width: w_width
    height: w_height
    visible: true
    title: qsTr("音乐播放器")

    Http{
        id:http
    }

    Settings{
        id:settings
        fileName: "conf/settings.ini"
    }

    ColumnLayout{
        anchors.fill: parent
        TopView{
            id:topView
        }
        spacing: 0  //取消ui的间隔

        HomeView{
            id:homeView

        }

        BottomView{
            id:bottomView

        }

    }

    MediaPlayer{
           id:mediaPlayer
           audioOutput: AudioOutput{}

           onPositionChanged: {    //音乐进度和进度条同步
               bottomView.setSlider(0,duration,mediaPlayer.position)
           }

           onPlaybackStateChanged: {     //辅助切换上一首，下一首
               if(playbackState===MediaPlayer.StoppedState&&bottomView.playBackStateChangeCallbackEnabled)
                   bottomView.playNext()

           }
       }

    //实现无边框
//    flags: Qt.Window|Qt.FramelessWindowHint

    //实现鼠标拖动窗口
//    DragHandler{
//        onActiveChanged: {
//            if(active){
//                window.startSystemMove()
//            }
//        }
//    }
}
