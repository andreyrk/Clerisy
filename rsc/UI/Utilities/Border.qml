import QtQuick 2.15

Rectangle
{
    property int leftWidth : 0
    property int rightWidth: 0
    property int topWidth: 0
    property int bottomWidth: 0

    z : -1
    anchors
    {
        left: parent.left
        right: parent.right
        top: parent.top
        bottom: parent.bottom

        leftMargin   : -leftWidth
        rightMargin  : -rightWidth
        topMargin    : -topWidth
        bottomMargin : -bottomWidth
    }
}
