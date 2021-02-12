import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "Utilities"

ApplicationWindow {
    id: app
    width: 800
    height: 450
    visible: true
    title: "Clerisy"

    Component.onCompleted: {
        Globals.app = this
    }

    header: ToolBar {
        id: header
        height: 40

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
            width: parent.width - 1

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
