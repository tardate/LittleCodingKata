# #499 The Securing Rails Applications Guide

About the latest Securing Rails Guide, as of writing 8.0+ Edge merged on 2026-11-20. Also a review of what advice from previous versions that is now obsolete.

## Notes

Latest [Securing Rails Guide](https://edgeguides.rubyonrails.org/security.html)
(8.0+ edge) was
[merged on 2026-11-20](https://github.com/rails/rails/pull/58618).

The scope of the guide includes:

* How Rails secures data in cookies.
* The Rails Session and how it can be used as an attack vector.
* The security features implemented by the built-in authentication generator.
* Cross-Site Request Forgery (CSRF), Cross-Site Scripting (XSS) and similar attack strategies as well as the countermeasures Rails provides.
* How to safely store and deliver user-uploaded files.
* How to mask sensitive information from Rails logs.
* SQL injection and similar attack strategies and how to defend against them.
* HTTP security headers and browser-enforced security features.
* How to securely store secret credentials in Rails.

### What has Changed?

Unless this is the first version of the guide you have read, it is sometimes just as important to note what has changed or been removed.

The following advice and sections from previous versions of the guide have been dropped and are now considered obsolete:

#### Legacy Gems & Plugins

* The attachment_fu plugin. Previous guides referenced attachment_fu for handling file uploads, filename sanitization, and asynchronous processing. This has been replaced with modern guidance centered on Active Storage.
* The RedCloth gem (Textile Injection). The entire section on Textile markup injection and using RedCloth.new(..., [:filter_html]) has been removed.
* The in_place_editor plugin (Ajax Injection). Advice regarding escaping output specifically for the legacy Prototype-based in_place_editor plugin and old UJS string responses has been dropped.
* The reCAPTCHA plugin/gem. Specific instructions on integrating the recaptcha plugin (recaptcha_tags and verify_recaptcha) and building "negative CAPTCHAs" (honeypot fields with UTC timestamps) were removed. The updated guide only briefly mentions CAPTCHAs alongside rate limiting.

#### Outdated Architectural & Security Advice

* Tracking IP addresses and User-Agents to prevent session hijacking. Previous guides suggested storing remote_ip and user_agent in the session and invalidating the session if they changed mid-session. This advice was dropped due to modern mobile networks and proxies causing frequent false positives.
* Using nonces inside CookieStore sessions to prevent replay attacks. The old guide suggested storing single-use nonces in the session to prevent cookie replay attacks (while noting it defeated the purpose of CookieStore). The updated guide replaces this with storing a server-side revocable session token in the database.
* Manual directory traversal checks for send_file. The multi-line boilerplate using File.expand_path to manually verify directory boundaries before calling send_file was removed in favor of storing randomized file keys in the database via Active Storage.
* Dedicated "Intranet and Admin Security" section. The standalone chapter advising developers to isolate admin panels on separate subdomains (e.g., admin.application.com) with separate user management and IP allowlists has been removed.
* Manual ActionController::InvalidAuthenticityToken cookie clearing. The old guide recommended rescuing InvalidAuthenticityToken to manually sign out users and clear persistent cookies. This is largely mitigated by modern SameSite=Lax cookie defaults and Rails' built-in forgery protection options (:exception, :reset_session, :null_session).

#### Deprecated Headers, Protocols & Historical Context

* X-XSS-Protection header. The section documenting X-XSS-Protection => "0" in default_headers was removed, as modern browsers have completely retired legacy XSS auditors.
* HTTP Header Injection & Response Splitting (CRLF) workarounds. The detailed breakdown of %0d%0a CRLF injection and HTTP response splitting—which stemmed from bugs patched in Rails 2.0.5 and 2.1.2—has been removed.
* CSS Injection via JavaScript eval() and -moz-binding. The section detailing CSS-based XSS vectors (like background:url('javascript:...') and Gecko's -moz-binding) is gone, as modern browsers no longer execute JavaScript inside CSS properties.
* Unsafe Query Generation (perform_deep_munge). The entire chapter explaining CVE-2012-2660 and how deep_munge converts [nil] parameters to nil (along with instructions on how to disable it via perform_deep_munge = false) has been removed.
* Outdated browser and malware trivia. References to Internet Explorer 5.5/6, WebTV, Opera 9.5, Adobe Flash/Silverlight cross-domain policies, and mid-2000s attack case studies (such as the 2006 Samy/Yamanner worms and Mpack) were stripped out.

## Credits and References

* Latest Guide, 8.0+ Edge:
    * <https://edgeguides.rubyonrails.org/security.html>
    * <https://github.com/rails/rails/pull/58618>
* <https://guides.rubyonrails.org/security.html>
