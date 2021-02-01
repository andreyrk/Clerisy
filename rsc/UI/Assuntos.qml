import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "Utilities"

Page {
    id: page
    property StackView stack: StackView.view
    property string pageAulas: "qrc:/UI/Aulas.qml"

    UrlRequest {
        id: file

        onStart: {
            url = stack.data.path
        }

        onFinish: {
            var obj = JSON.parse(response)
            var index = 0

            for (var item of obj.content)
            {
                item.index = index++
                item.content = JSON.stringify(item.content)

                listView.model.append(item)
            }

            page.title = obj.title
        }
    }

    ListView {
        id: listView
        anchors.fill: parent
        boundsBehavior: Flickable.StopAtBounds

        model: ListModel {}
        delegate: Column {
            width: page.width
            height: listParent.height + (listChildren.visible ? listChildren.height : 0)

            property var contentArray

            Component.onCompleted: {
                contentArray = JSON.parse(content)

                for (var item of contentArray) {
                    item.index = index
                }
            }

            Item {
                id: listParent
                width: page.width
                height: 40

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor

                    onClicked: {
                        if (listChildren.visible) {
                            listChildren.visible = false
                            icon.source = "qrc:/Icon/Expand-Less.svg"
                        } else {
                            listChildren.visible = true
                            icon.source = "qrc:/Icon/Expand-More.svg"
                        }
                    }
                }

                RowLayout {
                    Item {
                        width: 40
                        height: 40

                        Image {
                            id: icon
                            anchors.centerIn: parent

                            source: "qrc:/Icon/Expand-Less.svg"
                            sourceSize.width: 24
                            sourceSize.height: 24
                        }
                    }

                    Text {
                        id: text

                        text: title
                        font {
                            bold: false
                            pixelSize: 14
                            weight: Font.Thin
                        }
                        maximumLineCount: 1
                        elide: Text.ElideRight
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignVCenter

                        Layout.fillWidth: true
                        Layout.fillHeight: true
                    }
                }
            }

            Column {
                id: listChildren
                visible: false

                Repeater {
                    model: contentArray

                    Item {
                        width: page.width;
                        height: 40
                        x: 40
                        y: 40

                        Text {
                            anchors.fill: parent

                            text: modelData.title
                            font {
                                bold: false
                                pixelSize: 14
                                weight: Font.Thin
                            }
                            maximumLineCount: 1
                            elide: Text.ElideRight
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter

                            Layout.fillWidth: true
                            Layout.fillHeight: true
                        }

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor

                            onClicked: {
                                stack.data = modelData
                                stack.load(pageAulas)
                            }
                        }
                    }
                }
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
