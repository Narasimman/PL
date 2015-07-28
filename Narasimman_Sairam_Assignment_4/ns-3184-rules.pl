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
follows(@u2,@u1).
follows(@u2,@u5).
follows(@u2,@u6).
follows(@u3,@u7).
follows(@u3,@u8).
follows(@u8,@u4).
follows(@u4,@u3).
follows(@u4,@u5).
follows(@u4,@u2).

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
tweet(@u4,t11,[h3llo,@u1]).
tweet(@u8,t12,[@u1,viral,tweet]).

%% Defining retweet facts
retweet(@u2,t1).
retweet(@u3,t2).
retweet(@u3,t3).
retweet(@u4,t1).
retweet(@u5,t4).
retweet(@u6,t5).
retweet(@u7,t6).
retweet(@u8,t7).
retweet(@u8,t1).
retweet(@u8,t9).

%% feedhelper relation
feedhelper(U,F,M,I) :- (follows(U,F);follows(U,G)),(tweet(F,I,M);(tweet(F,I,M),retweet(G,I))).

%% feed relation that is given in the question.
feed(U,M) :- uniquefeed(U,O),remove_ident(O,M).
uniquefeed(U,R) :- setof([I,F|M],feedhelper(U,F,M,I),R).
remove_ident([],[]).
remove_ident([[_|Y]|T1],[H2|T2]) :- Y=H2,remove_ident(T1,T2).


%%% Search
recursive_search(_, []) :- fail. %% fail if empty list
recursive_search(K, [K | _]) :- !. %% cut and return if its exact match
recursive_search(K, [_ | Tail]) :- recursive_search(K, Tail). %% if it's not a match, recurse on the tail atoms.

search(K, U, M) :- tweet(U,_,M),recursive_search(K, M).

%% isviral
%% check if it is tweeted by the source and followed by someone
isviral(S, I, R) :- tweet(S, I, _), follows(R, S). 
%% check if it is retweeted and recursively call.
isviral(S, I, R) :- retweet(U2, I), follows(R, U2), isviral(S, I, U2).

%% isviral with inderection
isviral(S, I, R, M) :- tweet(S, I, _), follows(R, S), M =< 1.
isviral(S, I, R, M) :- retweet(U2, I), follows(R, U2), N is M-1, isviral(S, I, U2, N).
