import QtQuick 2.15

Item {
    property var response

    property string url
    property string responseType: "text"

    Component.onCompleted: {
        start()

        var req = new XMLHttpRequest();
        req.responseType = responseType

        req.onreadystatechange = function() {
            if (req.readyState === XMLHttpRequest.DONE) {
                response = req.response
                finish()
            }
        }

        req.open("GET", url);
        req.send()
    }

    signal start
    signal finish
}
