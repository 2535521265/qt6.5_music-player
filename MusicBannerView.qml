import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Frame{
    property int current: 0
    property alias bannerList : bannerView.model


    background: Rectangle{  //透明色去掉边框
        color: "#00000000"
    }
    PathView{
        id:bannerView
        width: parent.width
        height: parent.height

        clip: true //裁剪多出部分

        MouseArea{
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onEntered: {  //鼠标停在上面时，停止轮播图自动滚动。鼠标移开时，重新开始自动滚动
                bannerTimer.stop()
            }
            onExited: {
                bannerTimer.start()
            }
        }

        delegate: Item{
            id:delegateItem
            width:bannerView.width*0.7
            height: bannerView.height
            z:PathView.z?PathView.z:0  //用与解决跳转2格以上时的报错
            scale: PathView.scale?PathView.scale:1.0

            MusicRoundImage{
                id:image
                imgSrc:modelData.imageUrl  //获取数据源
                width: delegateItem.width
                height: delegateItem.height
            }

            MouseArea{
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor  //鼠标悬停时的光标形状为手型
                onClicked: { //点击实现切换轮播图
                    if(bannerView.currentIndex === index){

                    }else{
                        bannerView.currentIndex = index
                    }
                }
            }
        }

        pathItemCount: 3 //设置轮播图显示3个
        path:bannerPath
        preferredHighlightBegin: 0.5  //路径视图开始和结束高亮显示的位置
        preferredHighlightEnd: 0.5
    }

    Path{
        id:bannerPath
        startX: 0
        startY:bannerView.height/2-20

        PathAttribute{name:"z";value:0} //点击时切换高度，显示在上层
        PathAttribute{name:"scale";value:0.6}  //缩放比例

        PathLine{ //轮播图位置
            x:bannerView.width/2
            y:bannerView.height/2-20
        }

        PathAttribute{name:"z";value:2}
        PathAttribute{name:"scale";value:0.85}

        PathLine{
            x:bannerView.width
            y:bannerView.height/2-20
        }

        PathAttribute{name:"z";value:0}
        PathAttribute{name:"scale";value:0.6}
    }

    PageIndicator{ //分页指示器组件，显示当前选中项的索引以及总项数 （轮播图下面的ui）
        id:indicator
        anchors{
            top:bannerView.bottom
            horizontalCenter: parent.horizontalCenter
            topMargin: -20
        }
        count: bannerView.count
        currentIndex: bannerView.currentIndex
        spacing: 10
        delegate: Rectangle{
            width: 20
            height: 5
            radius: 5
            color: index===bannerView.currentIndex?"balck":"gray"
            Behavior on color{
                ColorAnimation {
                    duration: 200
                }
            }
            MouseArea{  //鼠标悬停记时
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onEntered: {
                    bannerTimer.stop()
                    bannerView.currentIndex = index
                }
                onExited: {
                    bannerTimer.start()
                }
            }
        }
    }

    Timer{ //计时器，自动下一张轮播图
        id:bannerTimer
        running: true
        repeat: true
        interval: 3000
        onTriggered: {
            if(bannerView.count>0)
                bannerView.currentIndex=(bannerView.currentIndex+1)%bannerView.count
        }
    }
}




