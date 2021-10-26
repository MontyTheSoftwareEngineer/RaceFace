#ifndef GAMETIMER_H
#define GAMETIMER_H

#include <QObject>
#include <QWidget>
#include <QTimer>

class GameTimer : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString gameTimeDisplay READ gameTimeDisplay WRITE setGameTimeDisplay NOTIFY gameTimeDisplayChanged)
public:
    explicit GameTimer(QObject *parent = nullptr);
    ~GameTimer();
    QString gameTimeDisplay() { return m_gameTimeDisplay; }
    Q_INVOKABLE void startTimer();
    Q_INVOKABLE void stopTimer();
    Q_INVOKABLE void clearTimer();

    Q_INVOKABLE void pauseGame();

public slots:
    void setGameTimeDisplay( const QString & time );
    void gameTimerTick();

signals:
    void gameTimeDisplayChanged();
    void gamePaused();

private:
    QString m_gameTimeDisplay;
    QTimer * m_gameTimer;

    int m_MSec;
    int m_Sec;
    int m_Min;
    int m_Hour;
};

#endif // GAMETIMER_H
