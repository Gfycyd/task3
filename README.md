# task3
## My implementation of wumpus


## A few things, you need to know, before run code:
- If on this blank: breeze, agent doesn't go, try to not risk(but it is easy to correct, so this code just ignore breeze)
- If stench and exist arrow, agent pull arrow in direction in which he want to go
- If miss, no other opportunity to pull arrow(monitoring by 2 criteria, CR1 and CR2)

#TO START THIS GAME YOU NEED TO WRITE  ## Start(Path)

# example of unsolvable problem(exist paths)

| 5 |  -    |  -  |  -   |  -  | -  |
| :-| :---: | :--:| :---: | :----: | ----:|
| 4 | pit   |  -   |   -   |  -   |  -  |
| 3 | pit   |   -  |   -   |    - |  -  |
| 2 | pit   | gold|wumpus|   -  |  -  |
| 1 | agent | pit | pit  |  -   |  -  |
| 0 | 1     | 2   |  3   |  4  |  5 |
