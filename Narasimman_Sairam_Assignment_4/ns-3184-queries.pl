follows(Followers, @u1).

tweet(@u1, I, M).

numretweets(I, Num):-findall(I, retweet(U, I), Bag), len(Bag, Num).
len([], 0).
len([_|Tail], N):-len(Tail, M), N is M+1.

feed(@u1, R).