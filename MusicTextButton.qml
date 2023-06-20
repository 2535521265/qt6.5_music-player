import QtQuick 2.12
import QtQuick.Controls 2.5

//本地音乐的按钮
Button{
    property alias btnText: self.text


    property alias isCheckable:self.checkable
    property alias isChecked:self.checked

    property alias btnWidth: self.width
    property alias btnHeight: self.height

    id:self

    text: "Button"

    font.family: "微软雅黑"
    font.pointSize: 14

    background: Rectangle{
        implicitHeight: self.height
        implicitWidth: self.width
        color: self.down||(self.checkable&&self.checked)?"#e2f0f8":"lightblue"
        radius: 3
    }
    width: 50
    height: 50
    checkable: false
    checked: false
}
