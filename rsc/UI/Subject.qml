import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "Utilities"

Page {
    id: page
    title: "Matérias"

    DynamicGrid {
        id: grid

        preferredCellWidth: 150
        preferredCellHeight: 45

        margin: 10

        delegate: Rectangle {
            width: grid.cellWidth - grid.horizontalSpacing
            height: grid.cellHeight - grid.verticalSpacing

            radius: 4
            border.width: 1
            border.color: "#E0E0E0"

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor

                onClicked: {
                    Globals.currentSubject = {
                        "title": title,
                        "path": path
                    }

                    Globals.app.load(Globals.pageTopic)
                }
            }

            Label {
                id: label
                anchors.fill: parent
                padding: 6

                text: title
                maximumLineCount: 1
                elide: Text.ElideRight

                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }

        model: ListModel {
            ListElement {
                title: "Matemática Básica"
                path: "qrc:/Data/Matematica-Basica.json"
            }

            ListElement {
                title: "Matemática"
                path: "qrc:/Data/Matematica.json"
            }

            ListElement {
                title: "Física"
                path: "qrc:/Data/Fisica.json"
            }

            ListElement {
                title: "Química"
                path: "qrc:/Data/Quimica.json"
            }

            ListElement {
                title: "Biologia"
                path: "qrc:/Data/Biologia.json"
            }

            ListElement {
                title: "Português"
                path: "qrc:/Data/Portugues.json"
            }

            ListElement {
                title: "Redação"
                path: "qrc:/Data/Redacao.json"
            }

            ListElement {
                title: "Literatura"
                path: "qrc:/Data/Literatura.json"
            }

            ListElement {
                title: "Inglês"
                path: "qrc:/Data/Ingles.json"
            }

            ListElement {
                title: "Espanhol"
                path: "qrc:/Data/Espanhol.json"
            }

            ListElement {
                title: "Geografia"
                path: "qrc:/Data/Geografia.json"
            }

            ListElement {
                title: "História"
                path: "qrc:/Data/Historia.json"
            }

            ListElement {
                title: "Sociologia"
                path: "qrc:/Data/Sociologia.json"
            }

            ListElement {
                title: "Filosofia"
                path: "qrc:/Data/Filosofia.json"
            }

            ListElement {
                title: "Artes"
                path: "qrc:/Data/Artes.json"
            }

            ListElement {
                title: "Atualidades"
                path: "qrc:/Data/Atualidades.json"
            }
        }
    }
}
