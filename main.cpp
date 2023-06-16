#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QIcon>
#include"http.h"
int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    app.setWindowIcon(QIcon(":/images/music.png"));

    qmlRegisterType<Http>("myhttp",1,0,"Http");

    QQmlApplicationEngine engine;
    const QUrl url(u"qrc:/music_player/Main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
        &app, []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
