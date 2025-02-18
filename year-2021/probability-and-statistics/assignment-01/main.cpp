#include <iostream>
#include <array>
#include <ctime>
#include <cstdlib>

class Card {
public:
    enum CardSuit {
        SUIT_CLUB,
        SUIT_DIAMOND,
        SUIT_HEART,
        SUIT_SPADE,
        MAX_SUITS
    };

    enum CardRank {
        RANK_2,
        RANK_3,
        RANK_4,
        RANK_5,
        RANK_6,
        RANK_7,
        RANK_8,
        RANK_9,
        RANK_10,
        RANK_JACK,
        RANK_QUEEN,
        RANK_KING,
        RANK_ACE,
        MAX_RANKS
    };

private:
    CardRank m_rank;
    CardSuit m_suit;

public:

    Card(CardRank rank = MAX_RANKS, CardSuit suit = MAX_SUITS) :
            m_rank(rank), m_suit(suit) {

    }

    int getCardSuit() {
        switch (m_suit) {
            case SUIT_CLUB:
                return 1;
            default:
                return 0;
        }
    }

    void printCard() const {
        switch (m_rank) {
            case RANK_2:
                std::cout << '2';
                break;
            case RANK_3:
                std::cout << '3';
                break;
            case RANK_4:
                std::cout << '4';
                break;
            case RANK_5:
                std::cout << '5';
                break;
            case RANK_6:
                std::cout << '6';
                break;
            case RANK_7:
                std::cout << '7';
                break;
            case RANK_8:
                std::cout << '8';
                break;
            case RANK_9:
                std::cout << '9';
                break;
            case RANK_10:
                std::cout << 'T';
                break;
            case RANK_JACK:
                std::cout << 'J';
                break;
            case RANK_QUEEN:
                std::cout << 'Q';
                break;
            case RANK_KING:
                std::cout << 'K';
                break;
            case RANK_ACE:
                std::cout << 'A';
                break;
        }

        switch (m_suit) {
            case SUIT_CLUB:
                std::cout << 'C';
                break;
            case SUIT_DIAMOND:
                std::cout << 'D';
                break;
            case SUIT_HEART:
                std::cout << 'H';
                break;
            case SUIT_SPADE:
                std::cout << 'S';
                break;
        }
    }

};

class Deck {
private:
    std::array<Card, 52> m_deck;

    static int getRandomNumber(int min, int max) {
        static const double fraction = 1.0 / (static_cast<double>(RAND_MAX) + 1.0);
        return static_cast<int>(rand() * fraction * (max - min + 1) + min);
    }

    static void swapCard(Card &a, Card &b) {
        Card temp = a;
        a = b;
        b = temp;
    }

public:
    Deck() {
        int card = 0;
        for (int suit = 0; suit < Card::MAX_SUITS; ++suit) {
            for (int rank = 0; rank < Card::MAX_RANKS; ++rank) {
                m_deck[card] = Card(static_cast<Card::CardRank>(rank),
                                    static_cast<Card::CardSuit>(suit));
                ++card;
            }
        }
    }

    void printDeck(int numberOfCard = 52) const {
        for (int i = 0; i < numberOfCard; ++i) {
            m_deck[i].printCard();
            std::cout << ' ';
        }
        std::cout << '\n';
    }

    void shuffleDeck() {
        for (auto &card: m_deck)
            swapCard(card, m_deck[getRandomNumber(0, 51)]);
    }

    int clubsFinder(int range = 3) {
        int counter = 0;
        for (int i = 0; i < range; ++i) {
            if (m_deck[i].getCardSuit() == 1) {
                ++counter;
            }
        }
        (counter > 0) ? std::cout << "Number of clubs is: " << counter << "\n" : std::cout << "No clubs!!\n";
        return counter;
    }

    int antiClubFinder() {
        int counter = 0;
        for (int i = 0; i < 3; ++i) {
            if (m_deck[i].getCardSuit() == 0) {
                ++counter;
            }
        }
        if (counter == 3) {
            return 1;
        } else {
            return 0;
        }
    }

};


int main() {
    // random set-up
    srand(static_cast<unsigned int>(time(0)));
    rand();

    // main
    Deck deck;
    //a
    std::cout << "=================== PODPUNK A ===================\n";
    std::cout << "Za ziarno(seed) generatora wziałem funkcje time()\n";
    // b
    std::cout << "=================== PODPUNK B ===================\n";
    deck.shuffleDeck();
    deck.printDeck(3);
    deck.clubsFinder(3);
    // c
    std::cout << "=================== PODPUNK C ===================\n";
    int counter(0), total(0), precision(0);
    double percantage(0);

    for (int i = 0; i < 1001; ++i) {
        while (true) {
            deck.shuffleDeck();
            if (deck.antiClubFinder() == 1) {
                ++counter;
            }

            // finds a 0,4
            percantage = (double) counter / total * 1000000;
            precision = (int) percantage / 100000 % 10;

            ++total;
            // if precision is 4, breaks the loop
            if (precision == 4) {
                break;
            }
        }
    }


    std::cout << "No clubs counter is: " << counter << "\n";
    std::cout << "Total re-spin number is: " << total << "\n";
    std::cout << "For 1000 cases my probability is " << (double) counter / total << "\n";

    return 0;
}