import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia

//底部工具栏
Rectangle{

    property var playList: []
    property int current: -1
     property int sliderValue: 0
    property int sliderFrom: 0
     property int sliderTo: 100
    property int currentPlayMode: 0
    property var playModeList: [{icon:"/single-repeat.png",name:"循环播放"},{icon:"/repeat.png",name:"顺序播放"},{icon:"/random.png",name:"随机播放"}]
    property bool playBackStateChangeCallbackEnabled: false
    property string musicCover: "qrc/player"
    property string musicName: "嘿嘿嘿"
    property string musicArtist: ""

    property int playingState: 0
    Layout.fillWidth: true
    height: 60
    color: "#00AAAA"



    RowLayout{
        anchors.fill: parent

        Item{
            Layout.preferredWidth: parent.width/10  //边距
            Layout.fillWidth: true
        }
        MusicIconButton{
            Layout.preferredWidth: 50   //大小
            icon.source: "qrc:/images/previous.png"
            toolTip: "上一首"
            onClicked: playPrevious()
        }
        MusicIconButton{
            Layout.preferredWidth: 50
            icon.source: playingState===0?"qrc:/images/stop.png":"qrc:/images/pause.png"
            toolTip: "暂停/播放"
            onClicked: {
                if(!mediaPlayer.source)return
                if(mediaPlayer.playbackState===MediaPlayer.PlayingState){
                    mediaPlayer.pause()
                }else if(mediaPlayer.playbackState===MediaPlayer.PausedState){
                    mediaPlayer.play()
                }
            }
        }
        MusicIconButton{
            Layout.preferredWidth: 50
            icon.source: "qrc:/images/next.png"
            toolTip: "下一首"
            onClicked:playNext('')
        }
        Item{   //进度条
            Layout.preferredWidth: parent.width/2
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.topMargin: 20


            Slider{
                id:slider
                width: parent.width
                Layout.fillWidth: true
                value: sliderValue
                from: sliderFrom
                to: sliderTo
                //拖动进度条跳转
                onMoved: {
                   mediaPlayer.position=value
                }

                height: 30
                background: Rectangle{
                    x:slider.leftPadding
                    y:slider.topPadding+(slider.availableHeight-height)/2
                    width: slider.availableWidth
                    height: 4
                    radius: 2
                    color: "#e9f4ff"
                    Rectangle{
                        width: slider.visualPosition*parent.width
                        height: parent.height
                        color: "red"
                        radius: 2
                    }
                }

                handle: Rectangle{
                    x:slider.leftPadding+(slider.availableWidth-width)*slider.visualPosition
                    y:slider.topPadding+(slider.availableHeight-height)/2
                    width: 15
                    height: 15
                    radius: 10
                    color: "#f0f0f0"
                    border.color: "red"
                    border.width: 0.5
                }
            }

            Text {
                text: musicName+"-"+musicArtist
                anchors.left: slider.left
                anchors.bottom: slider.top
                anchors.leftMargin: 5
                font.family: "微软雅黑"
                color: "white"
            }

            Text {
                id:timeTxet
                text: qsTr("00:00/.5:30")
                anchors.right: slider.right
                anchors.bottom: slider.top
                font.family: "微软雅黑"
                color: "white"
            }
        }
//        MusicIconButton{
//                    Layout.preferredWidth: 50
//                    text: "词"//找到图后补充上去就删除这行
//                    //icon.source: "qrc:/images/repeat.png"
//                    toolTip: "歌词"
//                }
      //词：图
        MusicBorderImage{
            width: 50
            height: 45
            imgSrc: musicCover
            MouseArea{
                cursorShape: Qt.PointingHandCursor //?
                anchors.fill: parent
                onPressed: {
                    musicCover.scale=0.9
                }
                onReleased: {
                    musicCover.scale=1.0
                }

                onClicked: {
                    pageDetailView.visible=!pageDetailView.visible
                    homeView.visible=!homeView.visible

                }
            }
        }

        MusicIconButton{
            Layout.preferredWidth: 50
            icon.source: "qrc:/images/favorite.png"
            toolTip: "我喜欢"
        }
        MusicIconButton{
            Layout.preferredWidth: 50
            icon.source: "qrc:/images"+playModeList[currentPlayMode].icon
            toolTip: playModeList[currentPlayMode].name
            onClicked: changePlayMode()
        }
        Item{
            Layout.preferredWidth: parent.width/10
            Layout.fillWidth: true
        }
    }


    Component.onCompleted: {
        //从配置文件中拿到currentPlayMode
         currentPlayMode=settings.value("currentPlayMode",0)
    }

    onCurrentChanged: {
        playBackStateChangeCallbackEnabled=false
        playMusic(current)
    }

    function playPrevious(){
        if(playList<1)return

        switch(currentPlayMode){
        case 0:
        case 1:
             current=(current+playList.length-1)%playList.length
            break
        case 2:{
            var random=parseInt(Math.random()*playList.length)
            current=current===random?random+1:random
            break
        }

        }
    }

    function playNext(type='natural'){
        if(playList<1)return
        switch(currentPlayMode){
        case 0:
            if(type==='natural')
                mediaPlayer.play()
                break

        case 1:
             current=(current+1)%playList.length
            break
        case 2:{
            var random=parseInt(Math.random()*playList.length)
            current=current===random?random+1:random
            break
        }
        }
    }

    function changePlayMode(){
        currentPlayMode=(currentPlayMode+1)%playModeList.length
        settings.setValue("currentPlayMode",currentPlayMode)
    }


    function playMusic(){//播放按钮
        if(current<0)return
        //获取播放链接
        getUrl()
    }

    function getUrl(){
        if(playList.length<current+1)return
        var id=playList[current].id

        if(!id)return
         //获取详情
        musicName=playList[current].name
        musicArtist=playList[current].artist

        function onReply(reply){
            http.onReplySignal.disconnect(onReply)

            var data=JSON.parse(reply).data[0]
            var url = data.url
            var time=data.time
            //设置Slider
            setSlider(0,time,0)

            if(!url)return
            //请求Cover
            var cover=playList[current].cover
            if(cover.length<1){
                getCover(id)
            }else{
                musicCover=cover
            }


            mediaPlayer.source=url
            mediaPlayer.play()

            playBackStateChangeCallbackEnabled=true
        }

        http.onReplySignal.connect(onReply)
        http.connet("song/url?id="+id)//接口
    }

    //设置进度条
    function setSlider(from=0,to=100,value=0){
        sliderFrom=from
        sliderTo=to
        sliderValue=value

        var fr_mm=parseInt(value/1000/60)+""
        fr_mm=fr_mm.length<2?"0"+fr_mm:fr_mm
        var fr_ss=parseInt(value/1000%60)+""
        fr_ss=fr_ss.length<2?"0"+fr_ss:fr_ss

        var to_mm=parseInt(to/1000/60)+""
        to_mm=to_mm.length<2?"0"+to_mm:to_mm
        var to_ss=parseInt(to/1000%60)+""
        to_ss=to_ss.length<2?"0"+to_ss:to_ss

        timeTxet.text=fr_mm+":"+fr_ss+"/"+to_mm+":"+to_ss
    }

    function getCover(id){
        function onReply(reply){
            http.onReplySignal.disconnect(onReply())

            //请求歌词
            getLyric(id)

            var song=JSON.parse(reply).songs[0]
            var cover=song.al.picUrl
            musicCover=cover
            if(musicName.length<1)musicName=song.name
            if(musicArtist.length<1)musicArtist=song.artist
        }

       http.onReplySignal.connect(onReply)
       http.connet("song/detail?ids="+id)//接口
    }

    //请求歌词
    function getLyric(id){
        function onReply(reply){
            http.onReplySignal.disconnect(onReply())

            var lyric=JSON.parse(reply).lrc.lyric
            console.log(lyric)//无法打印歌词还是说没有歌词

            if(lyric.length<1)return
            var lyrics=(lyric.replace(/\[.*\]/gi,"")).split("\n")
            if(lyrics.length>0)
                pageDetailView.lyrics=lyrics
            var times=[]
            lyric.replace(/\[.*\]/gi,function(match,index){
                //match:[00:00:00]
                if(match.length>2){
                    var time=match.substr(1,match.length-2) //第二位到倒数第二位
                    var arr=time.split(":")
                    var timeValue=arr.length>0?parseInt(arr[0])*60*1000:0
                    arr=arr.length>1?arr[1].split("."):[0,0]
                    timeValue+=arr.length>0?parseInt(arr[0])*1000:0
                    timeValue+=arr.length>1?parseInt(arr[1])*10:0
                    times.push(timeValue)
                }
            })
            mediaPlayer.times=times
        }

       http.onReplySignal.connect(onReply)
       http.connet("lyric?id="+id)//接口
    }
}
