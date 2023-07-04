/*
 * 2021051615038gongqin
 * */
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ColumnLayout{
    Layout.fillWidth: true
    Layout.fillHeight: true
    Rectangle {
        Layout.fillWidth: true
        width: parent.width
        height: 50
        color: "#00000000"

        Text {
            width: parent.width
            height: parent.height
            verticalAlignment: Text.AlignBottom //垂直居中

            text: qsTr("搜索音乐")
            font.family: "微软雅黑"
            font.pointSize: 20
        }
    }

    RowLayout{
        id:cen
        width: 520
        Layout.fillWidth: true
        TextField{ //搜索框
            id:searchInput
            font.family: "微软雅黑"
            font.pointSize: 12
            selectByMouse: true //可以选中
            selectionColor: "#999999" //搜索框内文字选中时的颜色
            placeholderText: "请输入搜索关键词"  //搜索框内提示词
            color: "black" //输入的字的颜色
            background:Rectangle{
                color: "#000000"  //搜索框背景颜色
                border.color: "black"
                border.width: 1
                opacity: 0.3
                implicitHeight: 40 //默认高度
                implicitWidth: 400 //默认宽度
                radius: 5
            }
            focus: true
            Keys.onPressed: if(event.key===Qt.Key_Enter||event.key===Qt.Key_Return)doSearch()//快捷键
        }
        MusicIconButton{ //搜索按钮设置
            iconSource:"qrc:/images/search"
            toolTip: "搜索"
            background: Rectangle{
                color:"lightblue"
                radius: 5
                implicitHeight: 40
                implicitWidth: 40
            }

            onClicked:doSearch()
        }
    }
    MusicListView{
        id:musicListView
        onLoadMore: doSearch(offset,current)
        Layout.topMargin: 10
    }
    function doSearch(offset=0,current=0){//current=0,每次搜索返回第一页
        var keywords=searchInput.text
        if(keywords.length<1)return
        function onReply(reply){
            http.onReplySignal.disconnect(onReply)
            var result=JSON.parse(reply).result
            musicListView.current=current
            var songsListCount=result.songCount
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


