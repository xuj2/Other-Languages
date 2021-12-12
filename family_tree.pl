% load family tree
:- consult('royal.pl').

% enables piping in tests
portray(Term) :- atom(Term), format("~s", Term).



% your code here...
mother(M,C):- parent(M,C), female(M).
father(F,C):- parent(F,C), male(F).
spouse(S,X):- married(S,X); married(X,S).
child(C,P):- parent(P,C).
son(S,P):- parent(P,S), male(S).
daughter(D,P):- parent(P,D), female(D).
sibling(S,X):- mother(M,S), mother(M,X), father(F,S), father(F,X), S\=X.
brother(B,X):- sibling(B,X), male(B).
sister(S,X):- sibling(S,X), female(S).

uncle(U,X):- brother(U,P), parent(P,X).
uncle(U,X):- married(U,A), sibling(A,P), parent(P,X).

aunt(A,X):- sister(A,P), parent(P,X).
aunt(A,X):- married(U,A), sibling(U,P), parent(P,X).

grandparent(G,X):- parent(P,X), parent(G,P).
grandfather(G,X):- grandparent(G,X), male(G).
grandmother(G,X):- grandparent(G,X), female(G).
grandchild(G,X):- grandparent(X,G).
ancestor(X,Y):- parent(X,Y).
ancestor(X,Y):- parent(X,Z), ancestor(Z,Y).
descendant(X,Y):- child(X,Y).
descendant(X,Y):- child(X,Z), descendant(Z,Y).
older(O,X):- born(O,A), born(X,B), A<B.
younger(Y,X):- born(Y,A), born(X,B), A>B.
regentWhenBorn(X,Y):- reigned(X,B,D), born(Y,Z), B<Z, D>Z.

cousin(X,Y):- uncle(U,Y), child(X,U).
cousin(X,Y):- aunt(A,Y), child(X,A).
cousin(X,Y):- grandparent(P,X), grandparent(P,Y).