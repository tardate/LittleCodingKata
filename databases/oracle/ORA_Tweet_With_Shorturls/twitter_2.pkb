CREATE OR REPLACE PACKAGE BODY ora_tweet
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
  
  
  twit_host VARCHAR2(255) := 'twitter.com';
  twit_protocol VARCHAR2(10) := 'http://';
  
  -- URL for status updates
  tweet_url VARCHAR2(255) := '/statuses/update.xml';
  
  FUNCTION tweet
    (
      p_user IN VARCHAR2,
      p_pwd IN VARCHAR2,
      p_string IN VARCHAR2,
      p_proxy_url IN VARCHAR2 DEFAULT NULL,
      p_no_domains IN VARCHAR2 DEFAULT NULL )
    RETURN BOOLEAN
  AS
    v_req   UTL_HTTP.REQ;  -- HTTP request ID
    v_resp  UTL_HTTP.RESP;  -- HTTP response ID
    v_value VARCHAR2(1024); -- HTTP response data
    v_status VARCHAR2(160);   -- Status of the request
    v_call VARCHAR2(2000);  -- The request URL
  BEGIN

    -- Twitter update url
    v_call := twit_protocol ||
              twit_host ||
              tweet_url;
					  
    -- encoded status tring                  
    v_status := utl_url.escape(
      url => 'status=' || SUBSTR( short_url.encode_text(p_string) ,1,140));
      
    -- Authenticate via proxy
    -- Proxy string looks like 'http://username:password@proxy.com'  
    -- p_no_domains is a list of domains not to use the proxy for
    -- These settings override the defaults that are configured at the database level
    IF p_proxy_url IS NOT NULL
    THEN
      Utl_Http.set_proxy (
        proxy                 => p_proxy_url,
        no_proxy_domains      => p_no_domains
        );
    END IF;
                  
    -- Has to be a POST for status update              
    v_req := UTL_HTTP.BEGIN_REQUEST(
	  url => v_call, 
      method =>'POST');
    
    -- Pretend we're a moz browser
    UTL_HTTP.SET_HEADER(
      r => v_req, 
      name => 'User-Agent', 
      value => 'Mozilla/4.0');
  
    -- Pretend we're coming from an html form
    UTL_HTTP.SET_HEADER(
      r => v_req, 
      name => 'Content-Type',   
      value => 'application/x-www-form-urlencoded'); 

    -- Set the length of the input
    UTL_HTTP.SET_HEADER(
      r => v_req, 
      name => 'Content-Length', 
      value => length(v_status));
                    
    -- authenticate with twitter user/pass                
    UTL_HTTP.SET_AUTHENTICATION(
      r => v_req,
      username => p_user,
      password => p_pwd );
    
    -- Send the update
    UTL_HTTP.WRITE_TEXT(
      r => v_req, 
      data => v_status );
   
    -- Get twitter's update
    v_resp := UTL_HTTP.GET_RESPONSE(
      r => v_req);

    -- Get the update and display it, 
    -- only useful for debugging really
    LOOP
      UTL_HTTP.READ_LINE(
        r => v_resp, 
        data => v_value, 
        remove_crlf => TRUE);
        
      DBMS_OUTPUT.PUT_LINE(v_value);
    END LOOP;

    -- Close out the http call
    UTL_HTTP.END_RESPONSE(
      r => v_resp);
 
    RETURN TRUE;
  
  EXCEPTION
    -- normal exception when reading the response
    WHEN UTL_HTTP.END_OF_BODY THEN
      UTL_HTTP.END_RESPONSE(
        r => v_resp);
	  RETURN TRUE;
      
    -- Anything else and send false
    WHEN OTHERS THEN
      UTL_HTTP.END_RESPONSE(
        r => v_resp);
      Dbms_Output.Put_Line ( 'Request_Failed: ' || Utl_Http.Get_Detailed_Sqlerrm );
      Dbms_Output.Put_Line ( 'Ora: ' || Sqlerrm );
	 RETURN FALSE;

  END;

END ora_tweet;
/

sho err

exit

