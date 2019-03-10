# Task 3
## My implementation of Wumpus


## A few things, you need to know, before run code:
- If on this blank: breeze, agent doesn't go, try to not risk(but it is easy to correct, so this code just ignore breeze)
- If stench and exist arrow, agent pull arrow in direction in which he want to go
- If miss, no other opportunity to pull arrow(monitoring by 2 criteria, CR1 and CR2)
- You go to gold
- You are killed when you on pit on with wumpus in one blank

### TO START THIS GAME YOU NEED TO WRITE QUERY ?- Start(Path)

# Example of unsolvable problem(exist paths):

| 5 |  -    |  -  |  -   |  -  | -  |
| :-| :---: | :--:| :---: | :----: | ----:|
| 4 | pit   |  -   |   -   |  -   |  -  |
| 3 | pit   |   -  |   -   |    - |  -  |
| 2 | pit   | gold|wumpus|   -  |  -  |
| 1 | agent | pit | pit  |  -   |  -  |
| 0 | 1     | 2   |  3   |  4  |  5 |
 * no possibility of acting as exist pit around agent
 * you can not solve when before you and gold pits, or wumpus and you have not arrows.
 
 # Similar effect we can see if we will have:
 | 5 |  -    |  -  |  -   |  -  | -  |
| :-| :---: | :--:| :---: | :----: | ----:|
| 4 | pit   |  -   |   -   |  -   |  -  |
| 3 | pit   |   -  |   -   |    - |  -  |
| 2 |  breeze| gold|wumpus|   -  |  -  |
| 1 | agent | breeze | pit  |  -   |  -  |
| 0 | 1     | 2   |  3   |  4  |  5 |
* by rules we can not do risk steps so agent never can move to gold, try avoid risk.
* But this problem can begin solvable, if we omit breeze on code.

# Example of solvable problem( with killing wumpus paths):

| 5 |  -    |  -  |  -   |  -  | -  |
| :-| :---: | :--:| :---: | :----: | ----:|
| 4 | pit   |  pit  |   pit |  -   |  -  |
| 3 | breeze   |   breeze |   breeze  |    - |  -  |
| 2 | wumpus  | gold| breeze|   pit |  -  |
| 1 | agent | -  | breeze  |  pit |  -  |
| 0 | 1     | 2   |  3   |  4  |  5 |
* in this case we have 2 possible solutions:
Path = ['ARROW+Up: ', 'Right: ']
Path = ['ARROW+Right: ', 'Up: ']
false

* we can see, that to go Up agent use Arrow, so killing wumpus to go up.
* also this problem solvable( exist at least 2 ways to gold, we do not include paths with breeze ).
