/*
 * 2021051205101tianfu
 * 2021051615038gongqin
 * 2021051615042dengyuexin
 * */
import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts
import QtQml

RowLayout{

    spacing: 0 //取消元素间的间隔
    property int defaultIndex: 0
    property var qmlList: [
        {icon:"recommend-white",value:"推荐内容",qml:"DetailRecommendPageView",menu:true},
        {icon:"cloud-white",value:"搜索音乐",qml:"DetailSearchPageView",menu:true},
        {icon:"local-white",value:"本地音乐",qml:"DetailLocalPageView",menu:true},
        {icon:"history-white",value:"播放历史",qml:"DetailHistoryPageView",menu:true},
        {icon:"favorite-big-white",value:"我喜欢的",qml:"DetailFavoritePageView",menu:true},
        {icon:"",value:"专辑/歌单",qml:"DetailPlayListPageView",menu:false}
    ]


    //左边框
    Frame{

        Layout.preferredWidth: 200
        Layout.fillHeight: true
        background: Rectangle{ //左边框背景颜色
            color: "#AA00AAAA"
        }

        padding: 0 //取消元素内间隔


        ColumnLayout{
            anchors.fill: parent

            Item{
                Layout.fillWidth: true
                Layout.preferredHeight: 180
                MusicBorderImage{
                    anchors.centerIn:parent  //放在中心
                    height: 130
                    width:130
                    borderRadius: 100
                }
            }

            ListView{
                id:menuView
                height: parent.height
                Layout.fillHeight: true
                Layout.fillWidth: true
                model:ListModel{
                    id:menuViewModel
                }
                delegate:menuViewDelegate
                highlight:Rectangle{ //首模块默认颜色
                    color: "#aa73a7db"
                }
                highlightMoveDuration: 500    //鼠标移动高亮持续时间
                highlightResizeDuration: 0  //高亮持续时间
            }
        }

        Component{
            id:menuViewDelegate
            Rectangle{
                id:menuViewDelegateItem
                height: 50
                width: 200
                color: "#AA00AAAA"//初始默认颜色
                RowLayout{
                    anchors.fill: parent
                    anchors.centerIn: parent
                    spacing:15
                    Item{ //占位 使字体居中
                        width: 30
                    }

                    Image{//图标大小
                        source: "qrc:/images/"+icon
                        Layout.preferredHeight: 20
                        Layout.preferredWidth: 20
                    }

                    Text{//左侧字体
                        text:value
                        Layout.fillWidth: true
                        height:50
                        font.family: "微软雅黑"
                        font.pointSize: 12
                        color: "#ffffff"
                    }
                }
                TapHandler{
                    onTapped:{
                        hidePlayList()
                        repeater.itemAt(menuViewDelegateItem.ListView.view.currentIndex).visible =false
                        menuViewDelegateItem.ListView.view.currentIndex = index
                        var loader = repeater.itemAt(menuViewDelegateItem.ListView.view.currentIndex)
                        loader.visible=true
                        loader.source = qmlList[index].qml+".qml"
                    }
                }
            }
        }

        Component.onCompleted: {
            menuViewModel.append(qmlList.filter(item=>item.menu))
            var loader = repeater.itemAt(0)
            loader.visible=true
            loader.source = qmlList[0].qml+".qml"
        }
    }

    Repeater{
        id:repeater
        model: qmlList.length
        Loader{
            visible: false
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }

    function showPlayList(targetId="",targetType="10"){
        repeater.itemAt(menuView.currentIndex).visible = false
        var loader = repeater.itemAt(5)
        loader.visible = true
        loader.source = qmlList[5].qml+".qml"
        loader.item.targetType=targetType
        loader.item.targetId=targetId
    }

    function hidePlayList(){
        repeater.itemAt(menuView.currentIndex).visible = true
        var loader = repeater.itemAt(5)
        loader.visible = false
    }

}

