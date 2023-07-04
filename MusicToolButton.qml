/*
 * 2021051205101tianfu
 * */
import QtQuick
import QtQuick.Controls

//TopView按钮图标美化
Button{
    property string iconSource: ""
    property string toolTip: ""
    property bool isCheckable:false
    property bool isChecked:false
    property int iconWidth: 32
    property int iconHeight: 32

    id:self

    icon.source:iconSource
    icon.height: iconHeight
    icon.width: iconWidth

    ToolTip.visible: hovered    //控制ToolTip组件是否可见，如果鼠标悬停在按钮上，则可见
    ToolTip.text: toolTip

    background: Rectangle{  //定义按钮的背景样式，颜色根据按钮状态不同而变化
        color: self.down||(isCheckable&&self.checked)?"#eeeeee":"#00000000"
    }
    icon.color: self.down||(isCheckable&&self.checked)?"#00000000":"#eeeeee"

    checkable: isCheckable
    checked: isChecked
}

