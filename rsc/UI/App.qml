import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "Utilities"

ApplicationWindow {
    id: app
    width: 800
    height: 450
    visible: true
    title: "Catalyst"

    Component.onCompleted: {
        Globals.app = this
    }

    header: ToolBar {
        height: 40

        contentItem: Rectangle {
            color: "#E0E0E0"
        }

        Border {
            leftWidth: 0
            rightWidth: 0
            topWidth: 0
            bottomWidth: Style.borderWidth

            color: Style.borderColor
        }

        Item {
            width: header.height
            height: header.height

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor

                onClicked: {
                    if (stack.depth > 1) {
                        stack.pop()
                    } else {
                        drawer.open()
                    }
                }
            }

            Image {
                anchors.centerIn: parent

                source: stack.depth > 1 ? Globals.icon_ChevronLeft : Globals.icon_Menu
                sourceSize.width: 24
                sourceSize.height: 24
            }
        }

        Label {
            anchors.centerIn: parent
            width: parent.width - 80

            text: stack.currentItem ? stack.currentItem.title : ""
            font {
                pixelSize: 15
            }
            maximumLineCount: 1
            elide: Text.ElideRight
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    Drawer {
        id: drawer
        width: implicitWidth * 2
        height: app.height

        ColumnLayout {
            spacing: 0
            width: parent.width

            ItemDelegate {
                background: Item {}
                text: "Matérias"
                Layout.fillWidth: true
                Layout.preferredHeight: header.height

                onClicked: {
                    drawer.close()
                    stack.clear()
                    app.load(Globals.pageSubject)
                }
            }

            ItemDelegate {
                background: Item {}
                text: "Opções"
                Layout.fillWidth: true
                Layout.preferredHeight: header.height

                onClicked: {
                    drawer.close()
                    stack.clear()
                    app.load(Globals.pageOptions)
                }
            }
        }

        background: Rectangle {
            color: "#FFFFFF"

            Border {
                leftWidth: 0
                rightWidth: Style.borderWidth
                topWidth: 0
                bottomWidth: 0

                color: Style.borderColor
            }
        }
    }

    StackView {
        id: stack
        anchors.fill: parent
        initialItem: Globals.pageSubject
    }

    function load(page) {
        stack.push(page)
    }
}
