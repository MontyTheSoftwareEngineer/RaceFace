#include "gamelogiccontroller.h"
#include <random>
#include <QDebug>

GameLogicController::GameLogicController(QObject *parent)
    : QObject(parent)
    , m_seed( QString() )
    , m_problemDisplay( QString() )
    , m_currentProblemCount( 0 )
{

}


void GameLogicController::useCurrentSeed()
{
    std::random_device rd;
    setGameSeed( QString::number(rd()) );
}

void GameLogicController::setGameSeed(const QString &seed)
{
    if ( m_seed != seed )
    {
        m_seed = seed;
        qDebug() << "Seed: " << seed;
        emit gameSeedChanged();
    }
}

void GameLogicController::setProblemDisplay(const QString &text)
{
    if ( m_problemDisplay != text )
    {
        m_problemDisplay = text;
        emit problemDisplayChanged();
    }
}

void GameLogicController::setProgressDisplay(const QString & text )
{
    if ( m_progressDisplay != text )
    {
        m_progressDisplay = text;
        emit progressDisplayChanged();
    }
}

bool GameLogicController::checkAnswer(const QString &answer)
{
    int intAns = answer.toInt();
    QPair< int, int> currentProblem = m_gameProblemList.at( m_currentProblemCount );
    return ( intAns == ( currentProblem.first * currentProblem.second ) );
}

void GameLogicController::nextQuestion()
{
    if ( m_currentProblemCount < m_gameProblemList.count() - 1 )
    {
        m_currentProblemCount++;
        setProblemDisplay( problemDisplay() );
        setProgressDisplay( QString::number(m_currentProblemCount) + "/" + QString::number( m_gameProblemList.count()));
    }
    else
    {
        emit gameFinished();
    }
}

void GameLogicController::initList()
{
    m_gameProblemList.clear();
    m_currentProblemCount = 0;

    std::default_random_engine generator;
    generator.seed( m_seed.toUInt() );
    std::uniform_int_distribution<int> distribution(10,99);

    for ( int i = 0; i < 7; i++ )
    {
        QPair< int, int > newElement;
        newElement.first = distribution(generator);
        newElement.second = distribution(generator);

        m_gameProblemList.append( newElement );
    }

    setProgressDisplay( QString::number(m_currentProblemCount) + "/" + QString::number( m_gameProblemList.count()));

    setProblemDisplay( problemDisplay() );
}

QString GameLogicController::problemDisplay()
{
    QString ret;
    QPair<int,int> currentProblem = m_gameProblemList.at( m_currentProblemCount );
    ret.append( QString::number( currentProblem.first ) + " X " + QString::number( currentProblem.second ) );

    return ret;
}
