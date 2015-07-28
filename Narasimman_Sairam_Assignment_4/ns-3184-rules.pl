%% Defining User facts
user(@u1).
user(@u2).
user(@u3).
user(@u4).
user(@u5).
user(@u6).
user(@u7).
user(@u8).

%% Defining  follows facts
follows(@u1,@u2).
follows(@u1,@u3).
follows(@u1,@u4).
follows(@u2,@u5).
follows(@u2,@u6).
follows(@u2,@u7).
follows(@u3,@u8).
follows(@u3,@u1).
follows(@u4,@u2).
follows(@u4,@u3).
follows(@u4,@u5).

%% Defining tweet facts
tweet(@u1,t1,[first,tweet]).
tweet(@u1,t2,[second,tweet]).
tweet(@u1,t3,[third,tweet]).
tweet(@u1,t4,[fourth,tweet]).
tweet(@u2,t5,[fifth,tweet]).
tweet(@u2,t6,[hi,@u1]).
tweet(@u2,t7,[hello,@u2]).
tweet(@u2,t8,[prolog,is,cool]).
tweet(@u2,t9,[@u1,@u2,how,are,you]).
tweet(@u2,t10,[final,tweet]).

%% Defining retweet facts
retweet(@u2,t1).
retweet(@u2,t1).
retweet(@u3,t2).
retweet(@u3,t3).
retweet(@u4,t1).
retweet(@u5,t4).
retweet(@u6,t5).
retweet(@u7,t6).
retweet(@u8,t7).
retweet(@u8,t8).
retweet(@u8,t9).

%% feedhelper relation
feedhelper(U,F,M,I) :- follows(U,F),(tweet(F,I,M);retweet(F,I)).

%% feed relation that is given in the question.
feed(U,M) :- uniquefeed(U,O),remove_ident(O,M).
uniquefeed(U,R) :- setof([I,F|M],feedhelper(U,F,M,I),R).
remove_ident([],[]).
remove_ident([[_|Y]|T1],[H2|T2]) :- Y=H2,remove_ident(T1,T2).


%%% Search
recursive_search(_, []) :- fail. %% fail if empty list
%% recursive_search(K, [K | _]) :- !. %% cut and return if its exact
%% match
% %recursive_search(K, [_ | Tail]) :- recursive_search(K, Tail). %% if
% it's not a match, recurse on the tail atoms.

recursive_search(K, [Head | Tail]) :- K == Head, !,recursive_search(K, Tail).

search(K, U, M) :- tweet(U,_,M),recursive_search(K, M).






%%	More prolog questions
foo(ashwin).
foo(roberta).
hello(brock).
hello(roberta).
hello(john).
world(ashwin).
world(roberta).
goal(X) :- sub1(X),sub2(X).
sub1(X) :- foo(X).
sub2(X) :- hello(X),world(X).


