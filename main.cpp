#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QIcon>
#include"http.h"
int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    app.setWindowIcon(QIcon(":/images/music.png"));//窗口左上角图标

    qmlRegisterType<Http>("myhttp",1,0,"Http");//网络连接

    QQmlApplicationEngine engine;
    const QUrl url(u"qrc:/music_player/Main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
        &app, []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
