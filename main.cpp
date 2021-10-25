#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>

#include "Controllers/gamelogiccontroller.h"
#include "Controllers/gametimer.h"
#include "Controllers/gamesecuritycontroller.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));

    QQuickStyle::setStyle("Material");

    QGuiApplication app(argc, argv);

    qmlRegisterType< GameLogicController >("OKPUP", 1, 0, "GameLogicController" );
    qmlRegisterType< GameTimer >("OKPUP", 1, 0, "GameTimer" );
    qmlRegisterType< GameSecurityController >("OKPUP", 1, 0, "GameSecurity" );

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
