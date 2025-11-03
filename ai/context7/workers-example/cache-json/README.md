 # Cloudflare Worker: cache-json

 Purpose

 - Proxy JSON GET requests and cache successful JSON responses for 5 minutes using Cloudflare's Cache API.

 Files

 - `worker.js` - the Worker script.
 - `wrangler.toml` - example Wrangler config.

 Notes

 - The worker only caches GET responses with `Content-Type: application/json` and status 200-299.
 - By default it proxies the same URL path; set `UPSTREAM_API` in `wrangler.toml` or as an environment variable to restrict/proxy to a specific upstream API.

 Local testing

 - Install Wrangler (npm i -g wrangler) and run `wrangler dev worker.js` in this folder.

 Deployment

 - `wrangler publish` from the `workers/cache-json` folder (ensure `name` and account details are configured in your global `~/.wrangler/config/defaults` or in the `wrangler.toml`).

 Context7

 - This repo contains `tools/ai/context7/README.md` which documents Context7 usage; no direct Context7 integration is required for the Worker itself.
