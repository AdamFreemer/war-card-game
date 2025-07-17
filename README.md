# War Card Game

- A command-line implementation of the classic War card game in Ruby.
- Written to balance readability, compactness and abstractness.

## How to Run

### Local Setup
1. Make sure you have Ruby installed on your system
2. Clone or download this repository
3. Navigate to the project directory
4. Run the game:

```bash
$ ruby war.rb
```

### GitHub Codespaces
1. Click the green "Code" button / dropdown on the repository page.
2. Click the green button "Create codespace on master" and create a new codespace.
3. Once the codespace loads, open / navigate to the terminal.
4. Run the game:

```bash
$ ruby war.rb
```

## Game Rules

- The game supports 2 or 4 players.
- A standard 52-card deck is divided evenly among all players.
- Players simultaneously play their top card each round.
- The player with the highest card wins all cards in play.
- In case of a tie, players go to "war" by placing 3 cards face down and 1 face up.
- The game continues until one player has all 52 cards.
- Aces are high, followed by King, Queen, Jack, 10, 9, etc.
