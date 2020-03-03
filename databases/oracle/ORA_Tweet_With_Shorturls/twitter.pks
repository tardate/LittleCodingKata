CREATE OR REPLACE PACKAGE ora_tweet
AS

  /*  ORA_TWEET
      Author:  Lewis Cunningham
      Date:  Marchish, 2009
      Email:  lewisc@rocketmail.com
      Twitter: oracle_ace
      Web: http://database-geek.com
      License:  Free Use
      Version: 1.1
      
  */

  FUNCTION tweet
    ( 
      p_user IN VARCHAR2,
      p_pwd IN VARCHAR2,
      p_string IN VARCHAR2,
      p_proxy_url IN VARCHAR2 DEFAULT NULL,
      p_no_domains IN VARCHAR2 DEFAULT NULL )
    RETURN BOOLEAN;

END ora_tweet;
/

sho err

exit