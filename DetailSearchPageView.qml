import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ColumnLayout{
     Layout.fillWidth: true
     Layout.fillHeight: true
    Rectangle {
        Layout.fillWidth: true
        width: parent.width
        height: 60
        color:"#00000000"
        Text {
            x:10
            verticalAlignment: Text.AlignBottom
            text: qsTr("搜索音乐")
            font.family: "微软雅黑"
            font.pointSize: 25
        }
    }

    RowLayout{
           id:cen
           width: 520
//           anchors.centerIn:top //类型不对
           Layout.fillWidth: true
           TextField{
               id:searchInput
               font.family: "微软雅黑"
               font.pointSize: 12
               selectByMouse: true
               selectionColor: "#999999"
               placeholderText: "请输入搜索关键词"
//               color: "#000000"
               background:Rectangle{
                   color: "#000000"
                   border.color: "black"
                   border.width: 1
                   opacity: 0.5
                   implicitHeight: 40
                   implicitWidth: 400
                   radius: 10
               }
               focus: true
               Keys.onPressed: if(event.key===Qt.Key_Enter||event.key===Qt.Key_Return)doSearch()//快捷键
           }
           MusicIconButton{
               iconSource:"qrc:/images/search"
               toolTip: "搜索"
               onClicked:doSearch()
           }
       }
    MusicListView{
        id:musicListView
        onLoadMore: doSearch(offset,current)
        Layout.topMargin: 10
    }
    function doSearch(offset=0,current=0){
//         console.log(offset)
        var keywords=searchInput.text
        if(keywords.length<1)return
        function onReply(reply){
            http.onReplySignal.disconnect(onReply)
            var result=JSON.parse(reply).result
            musicListView.current=current
            var songsListCount=result.songCount
            console.log(reply)
            var songsList = result.songs
            musicListView.all=songsListCount
            musicListView.musicList = songsList.map(item=>{  //js遍历
                                                      return{
                                                            id:item.id,
                                                            name:item.name,
                                                            artist:item.artists[0].name,
                                                            album:item.album.name,
                                                            cover:""
                                                        }
                                                    })
        }
        http.onReplySignal.connect(onReply)
        http.connet("search?keywords="+keywords+"&offset="+offset+"&limit=60")
    }
}


