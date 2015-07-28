%% 1. Write a query that shows who is following a specified user.
follows(Followers, @u1).

%% 2. Write a query that shows all tweets posted by a specified user.
tweet(@u1, I, M).

%% 3. Write a query that shows how many users retweeted a specified tweet. 
numretweets(I, Num):-findall(I, retweet(U, I), Bag), len(Bag, Num).
len([], 0).
len([_|Tail], N):-len(Tail, M), N is M+1.

%% 4. Write a query that shows a particular user’s feed. Ensure that tweets of any users that the user follows are visible in the feed.
feed(@u1, R).

%% 5. Write a query that searches for a keyword in the universe of tweets.
search(tweet, U, M).

%% 7. Write a query that shows if a particular tweet is viral between the sender and a specified receiver.
isviral(@u1,t1,@u8).

%% 8. Write a query that shows if a particular tweet is viral between the sender and a specified receiver in no less than 3 levels of indirection.
isviral(@u1,t1,@u8,3).



