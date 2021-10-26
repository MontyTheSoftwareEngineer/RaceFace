#include "gametimer.h"

GameTimer::GameTimer(QObject *parent)
    : QObject(parent)
    , m_gameTimeDisplay("00:00:00.0")
    , m_MSec(0)
    , m_Sec(0)
    , m_Min(0)
    , m_Hour(0)
{
    m_gameTimer = new QTimer( this );
    m_gameTimer->setInterval(100);
    connect( m_gameTimer, &QTimer::timeout, this, &GameTimer::gameTimerTick );
}

GameTimer::~GameTimer()
{
    m_gameTimer->deleteLater();
}

void GameTimer::startTimer()
{
    m_gameTimer->start();
}

void GameTimer::stopTimer()
{
    m_gameTimer->stop();
}

void GameTimer::clearTimer()
{
    m_MSec = 0;
    m_Sec = 0;
    m_Min = 0;
    m_Hour = 0;

    setGameTimeDisplay("00:00:00.0");
}

void GameTimer::pauseGame()
{
    m_gameTimer->stop();
    emit gamePaused();
}

void GameTimer::setGameTimeDisplay(const QString &time)
{
    if ( m_gameTimeDisplay != time )
    {
        m_gameTimeDisplay = time;
        emit gameTimeDisplayChanged();
    }
}

void GameTimer::gameTimerTick()
{
    m_MSec++;
    if ( m_MSec >= 10 )
    {
        m_Sec++;
        m_MSec = 0;
    }

    if ( m_Sec >= 60 )
    {
        m_Min++;
        m_Sec = 0;
    }

    if ( m_Min >= 60 )
    {
        m_Hour++;
        m_Min = 0;
    }

    QString newGameTimeDisplay;
    if ( m_Hour < 10 )
        newGameTimeDisplay.append("0");
    newGameTimeDisplay.append( QString::number( m_Hour) );
    newGameTimeDisplay.append( ":" );

    if ( m_Min < 10 )
        newGameTimeDisplay.append("0");
    newGameTimeDisplay.append( QString::number( m_Min) );
    newGameTimeDisplay.append( ":" );

    if ( m_Sec < 10 )
        newGameTimeDisplay.append("0");
    newGameTimeDisplay.append( QString::number( m_Sec ) );
    newGameTimeDisplay.append( "." );
    newGameTimeDisplay.append( QString::number( m_MSec ) );

    setGameTimeDisplay( newGameTimeDisplay );
}
