#include "gamelogiccontroller.h"
#include <random>
#include <QDebug>

GameLogicController::GameLogicController(QObject *parent)
    : QObject(parent)
    , m_inputNormal( true )
    , m_seed( QString() )
    , m_problemDisplay( QString() )
    , m_currentProblemCount( 0 )
    , m_problemType( 0 )
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

void GameLogicController::setInputNormal(const bool &val)
{
    if ( m_inputNormal != val )
    {
        m_inputNormal = val;
        emit inputNormalChanged();
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

QString GameLogicController::getQuestionList()
{
    QString ret;
    for ( int i = 0; i < m_gameProblemList.count(); i++)
    {
        QPair<int,int> current = m_gameProblemList.at(i);
        ret.append( QString::number( current.first) + " X " + QString::number( current.second ) + " = " + QString::number( current.first * current.second) + "\n" );
    }

    return ret;
}

void GameLogicController::setProblemType(const int &index)
{
    m_problemType = index;
}

void GameLogicController::initList()
{
    m_gameProblemList.clear();
    m_currentProblemCount = 0;

    std::default_random_engine generator;
    generator.seed( m_seed.toUInt() );
    std::uniform_int_distribution<int> twoDigit(10,99);
    std::uniform_int_distribution<int> threeDigit(100,999);
    std::uniform_int_distribution<int> typeSel(1,3);

    for ( int i = 0; i < 7; i++ )
    {
        QPair< int, int > newElement;
        int mode = m_problemType;
        if ( m_problemType == 0 )
        {
            mode = typeSel( generator );
        }
        //int mode = typeSel( generator );
        switch( mode )
        {
        //two digits
        case 1: {
            newElement.first = twoDigit( generator );
            newElement.second = twoDigit( generator );
            break;
        }
        //mixed
        case 2: {
            newElement.first = threeDigit( generator );
            newElement.second = twoDigit( generator );
            break;
        }
        case 3: {
            newElement.first = threeDigit( generator );
            newElement.second = twoDigit( generator );
            break;

        }
        }

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
