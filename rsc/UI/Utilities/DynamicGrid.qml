import QtQuick 2.15
import QtQuick.Layouts 1.15

GridView {
    anchors.fill: parent

    Component.onCompleted: {
        refresh()
    }
    onWidthChanged: refresh()

    topMargin: 5
    leftMargin: 5
    bottomMargin: topMargin - verticalSpacing
    rightMargin: leftMargin - horizontalSpacing

    property bool keepAspectRatio: false

    property int preferredCellWidth: 100
    property int preferredCellHeight: 100
    property int horizontalSpacing: 5
    property int verticalSpacing: 5

    cellWidth: preferredCellWidth
    cellHeight: preferredCellHeight

    function refresh() {
        let bounds = {
            width: width - leftMargin - rightMargin,
            height: height - topMargin - bottomMargin
        }

        if (preferredCellWidth * count < bounds.width)
        {
            cellWidth = preferredCellWidth
        }
        else if (preferredCellWidth * 1.5 <= bounds.width)
        {
            if (bounds.width % preferredCellWidth >= 0)
            {
                cellWidth = Math.floor(bounds.width / Math.floor(bounds.width / preferredCellWidth))
            } else {
                cellWidth = bounds.width
            }
        }
        else if (preferredCellWidth * 1.5 > bounds.width)
        {
            cellWidth = bounds.width
        }

        if (keepAspectRatio) {
            cellHeight = cellWidth * preferredCellHeight/preferredCellWidth
        } else {
            cellHeight = preferredCellHeight
        }
    }

    boundsBehavior: Flickable.StopAtBounds
}
