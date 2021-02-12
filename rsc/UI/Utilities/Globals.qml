pragma Singleton

import QtQuick 2.15

QtObject {
    property var app

    property var currentSubject: ({})
    property var currentTopic: ({})
    property var currentSubtopic: ({})

    property string pageTopic: "qrc:/UI/Topic.qml"
    property string pageSubtopic: "qrc:/UI/Subtopic.qml"
    property string pageSubject: "qrc:/UI/Subject.qml"
    property string pageOptions: "qrc:/UI/Options.qml"

    property string icon_Menu: "qrc:/Icon/Menu.svg"
    property string icon_PlayArrow: "qrc:/Icon/Play-Arrow.svg"
    property string icon_ExpandLess: "qrc:/Icon/Expand-Less.svg"
    property string icon_ExpandMore: "qrc:/Icon/Expand-More.svg"
    property string icon_ChevronLeft: "qrc:/Icon/Chevron-Left.svg"
    property string icon_ChevronRight: "qrc:/Icon/Chevron-Right.svg"
}
