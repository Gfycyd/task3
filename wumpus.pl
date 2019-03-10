% write initial data
wumpus(1, 3).
gold(4, 3).
agent(1,1,1,1).
pit(3, 1).%pits should be 5, as mention in book with p = 0.2

%stench by Wumpus
stench(X,Y):-
	( X1 is X-1, wumpus(X1,Y));
    ( Y1 is Y-1, wumpus(X,Y1));
    ( Y1 is Y+1, wumpus(X,Y1));
    ( X1 is X+1, wumpus(X1,Y)).

%breeze by existing Pits
breeze(X,Y):-
    ( X1 is X-1, pit(X1,Y));
    ( Y1 is Y-1, pit(X,Y1));
    ( Y1 is Y+1, pit(X,Y1));
    ( X1 is X+1, pit(X1,Y)).


%=================================GAME START===============================


start(Path):-
    getAllPaths(Path).

getAllPaths(L) :-
    agent(X, Y,CR1,CR2),
    getAllPathsRec(CR1,CR2,X, Y, [],[], L).

% Positions, Visited list, and Path list
getAllPathsRec(_, _, X, Y, _V, NL, L) :-
    gold(X, Y),
    reverse(NL,L).

% Positions, Visited list, and Path list
getAllPathsRec(CR1, CR2,X, Y, V, CL,L) :-
    \+member((X, Y,CR1,CR2), V),
    move(CR1, CR2, X, Y, CL, NX, NY, NL,C1,C2),
    
    % No need to use append to build the list of visited nodes
    getAllPathsRec(C1, C2, NX, NY, [(X,Y,CR1,CR2) | V], NL,L).
% Up moving
move(CR1, CR2, X, Y, L, X, NY,NL,C1,C2) :-
    Y < 5, NY is Y + 1, not(breeze(X,Y)), not(pit(X,Y)), ( CR1 = 1, CR2 = 1,  NL = ['ARROW+Up: '|L],stench(X,Y), not(wumpus(X,Y)),arrow(X,NY,CR1,CR2,C1,C2) 
                                     ; CR1 = 1, CR2 = 0, not(wumpus(X,Y)), C1 is 1, C2 is 0, NL = ['Up: '|L] ; 
                                      CR1 = 1, CR2 = 1, not(wumpus(X,Y)), NL = ['Up: '|L] , not(stench(X,Y)), C1 is 1, C2 is 1;
                                     CR1 = 0, C1 is 0, C2 is 0, NL = ['Up: '|L] ).

% Right moving
move(CR1, CR2, X, Y, L, NX, Y,NL,C1, C2) :-
    X < 5,NX is X + 1, not(breeze(X,Y)),not(pit(X,Y)), ( CR1 = 1, CR2 = 1, stench(X,Y),NL =  ['ARROW+Right: '|L],not(wumpus(X,Y)), arrow(NX,Y,CR1,CR2,C1,C2) 
                                     ; CR1 = 1, CR2 = 0, not(wumpus(X,Y)), NL =  ['Right: '|L] , C1 is 1, C2 is 0; 
                                      CR1 = 1, CR2 = 1, not(wumpus(X,Y)), not(stench(X,Y)), NL = ['Right: '|L], C1 is 1, C2 is 1;
                                     CR1 = 0, C1 is 0, C2 is 0, NL = ['Right: '|L]).

% Down moving
move(CR1, CR2, X, Y, L, X, NY, NL ,C1,C2) :-
    Y > 1, NY is Y - 1,not(breeze(X,Y)),not(pit(X,Y)), ( CR1 = 1, CR2 = 1, stench(X,Y), NL = ['ARROW+Down: '|L], not(wumpus(X,Y)), arrow(X,NY,CR1,CR2,C1,C2) 
                                     ; CR1 = 1, CR2 = 0, not(wumpus(X,Y)),NL = ['Down: '|L], C1 is 1, C2 is 0; 
                                      CR1 = 1, CR2 = 1, not(wumpus(X,Y)),NL = ['Down: '|L], not(stench(X,Y)), C1 is 1, C2 is 1;
                                     CR1 = 0, C1 is 0, C2 is 0, NL = ['Down: '|L]).



% Left moving
move(CR1, CR2, X, Y, L, NX, Y,NL,C1,C2) :-
    X > 1,NX is X - 1, not(breeze(X,Y)), not(pit(X,Y)),  ( CR1 = 1, CR2 = 1, stench(X,Y),NL = ['ARROW+Left: '|L], not(wumpus(X,Y)), arrow(NX,Y,CR1,CR2,C1,C2) 
                                     ; CR1 = 1, CR2 = 0, not(wumpus(X,Y)),NL =  ['Left: '|L], C1 is 1, C2 is 0; 
                                      CR1 = 1, CR2 = 1, not(wumpus(X,Y)), NL =  ['Left: '|L],not(stench(X,Y)), C1 is 1, C2 is 1 ;
                                     CR1 = 0, C1 is 0, C2 is 0,NL = ['Left: '|L]).

%arrow code, pif-pafff
arrow(X,Y,A,B,CR1,CR2):-
    wumpus(X,Y),A >0, B > 0,CR1 is A - 1, CR2 is B - 1.
arrow(X,Y,A,B,CR1,CR2):-
    not(wumpus(X,Y)),A>0, B>0, CR2 is B - 1, CR1 is 1.
