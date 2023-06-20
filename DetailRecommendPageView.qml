import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

//滚动视图
ScrollView{
    clip: true  //裁剪超出组件的元素，
    ColumnLayout {

        //        Text {
        //            text: qsTr("推荐内容")
        //            font.family: "微软雅黑"
        //            font.pointSize: 18
        //        }

        MusicBannerView{
            id:bannerView
            Layout.preferredWidth: window.width-200 //轮播图长度
            Layout.preferredHeight: (window.width-200)*0.3  //轮播图宽度
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
        Rectangle{
            Layout.fillWidth: true
            width: parent.width
            height: 60
            color: "#00000000"
            Text{
                x:10
                verticalAlignment: Text.AlignBottom
                text: qsTr("推荐歌单")
                font.family: "微软雅黑"
                font.pointSize: 25
            }
        }
        MusicGridView{
            id:musicView
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredHeight: (window.width-250)*0.2*4+30*4+20  //高度  刚好显示20个歌单
            Layout.bottomMargin: 20
        }

        Rectangle{

            Layout.fillWidth: true
            width: parent.width
            height: 60
            color: "#00000000"
            Text {
                x:10
                verticalAlignment: Text.AlignBottom
                text: qsTr("新歌推荐")
                font.family: "微软雅黑"
                font.pointSize: 25
            }
        }

        MusicGridLatestView{
            id:latestView
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredHeight: (window.width-230)*0.1*10+20
            Layout.bottomMargin: 20
        }
    }

    Component.onCompleted: {
        getBannerList()
    }

    function getBannerList(){

        function onReply(reply){
            http.onReplySignal.disconnect(onReply)
            var banners = JSON.parse(reply).banners //获取网页的图片数据
            bannerView.bannerList = banners
            getRecommendList()
        }

        http.onReplySignal.connect(onReply)
        http.connet("banner")
    }
    function getRecommendList(){
        function onReply(reply){
            http.onReplySignal.disconnect(onReply)
            var playlists = JSON.parse(reply).playlists
            musicView.list =playlists
            getLatestList()
        }
        http.onReplySignal.connect(onReply)
        http.connet("/top/playlist/highquality?limit=20") //显示20个歌单
    }

    function getLatestList(){
        function onReply(reply){
            http.onReplySignal.disconnect(onReply)
            var latestList = JSON.parse(reply).data
            latestView.list =latestList.slice(0,30)
        }

        http.onReplySignal.connect(onReply)
        http.connet("top/song")
    }

}
