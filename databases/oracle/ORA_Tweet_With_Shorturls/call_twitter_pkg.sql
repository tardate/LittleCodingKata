SET SERVEROUTPUT ON

BEGIN

  IF ora_tweet.tweet
    (
      p_user => 'twitter_username',
      p_pwd => 'twitter_password',
      p_string => 'ora_tweet v1.1 is complete! Now with url shortening ... see http://database-geek.com/2009/03/15/ora_tweet-tweet-from-oracle-a-plsql-twitter-api/' )
  THEN
    dbms_output.put_line('Success!');
  ELSE
    dbms_output.put_line('Failure!');
  END IF;
  
END;
/

exit
