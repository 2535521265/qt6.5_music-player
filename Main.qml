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
    Settings{
            id:historySettings
            fileName: "conf/history.ini"
        }
    Settings{
            id:favoriteSettings
            fileName: "conf/favorite.ini"
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

        PageDetailView{
            id:pageDetailView
            visible: false
        }

        BottomView{
            id:bottomView

        }

    }

    MediaPlayer{
           id:mediaPlayer
           property var title:[]
           property var artist:[]
           property var album:[]
           audioOutput: AudioOutput{volume: bottomView.voice.value} //音量绑定滑动条

           property var times: []
           onPositionChanged: {    //音乐进度和进度条同步
               bottomView.setSlider(0,duration,mediaPlayer.position)
               //歌词滚动
               if(times.length>0){
                   var count=times.filter(time=>time<position).length
                   pageDetailView.current=(count===0)?0:count-1
               }
           }
           onPlaybackStateChanged: {     //辅助切换上一首，下一首
               bottomView.playingState=playbackState===MediaPlayer.PlayingState?1:0
               if(playbackState===MediaPlayer.StoppedState&&bottomView.playBackStateChangeCallbackEnabled)
                   bottomView.playNext()
           }


           onMetaDataChanged: {
                title = metaData.stringValue(0)
                artist = metaData.stringValue(20)
                album = metaData.stringValue(18)

               console.log("Title:", title)
               console.log("Artist:", artist)
               console.log("Album:", album)
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
