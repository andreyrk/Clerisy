#include <QIcon>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QSysInfo>

int main(int argc, char *argv[])
{
    qputenv("QML_XHR_ALLOW_FILE_READ", QByteArray(1, 1));

    QGuiApplication app(argc, argv);
    app.setWindowIcon(QIcon(":/Icon/App.png"));

    QQmlApplicationEngine engine;
    engine.load("qrc:/UI/App.qml");

    return app.exec();
}
