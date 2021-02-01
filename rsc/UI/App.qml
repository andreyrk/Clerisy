import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    id: app
    width: 450
    height: 800
    visible: true
    title: "Prototype"

    property string pageMaterias: "qrc:/UI/Materias.qml"
    property string pageOpcoes: "qrc:/UI/Opcoes.qml"

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

                source: stack.depth > 1 ? "qrc:/Icon/Chevron-Left.svg" : "qrc:/Icon/Menu.svg"
                sourceSize.width: 24
                sourceSize.height: 24
            }
        }

        Label {
            anchors.centerIn: parent
            anchors.leftMargin: 40
            anchors.rightMargin: 40

            text: stack.currentItem ? stack.currentItem.title : ""
            font {
                pixelSize: 15
            }
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
                text: "Matérias"
                Layout.fillWidth: true
                Layout.preferredHeight: header.height

                onClicked: {
                    drawer.close()
                    stack.clear()
                    stack.load(pageMaterias)
                }
            }

            ItemDelegate {
                text: "Opções"
                Layout.fillWidth: true
                Layout.preferredHeight: header.height

                onClicked: {
                    drawer.close()
                    stack.clear()
                    stack.load(pageOpcoes)
                }
            }
        }
    }

    StackView {
        id: stack
        anchors.fill: parent
        initialItem: pageMaterias

        property var data: ({})

        function load(page) {
            push(page)
        }
    }
}
