Testing and deploying the cache-json Worker

Quick test (local with Wrangler)

1. Install Wrangler: `npm i -g wrangler`
2. From this folder run: `wrangler dev worker.js`
3. Make GET requests to the dev URL. Only JSON GET responses will be cached for 5 minutes.

Notes on environment

- To proxy to a specific upstream API set `UPSTREAM_API` in `wrangler.toml` or as an env var in Wrangler.
- If you need Context7 access from code/tests, set `CONTEXT7_API_KEY` in `wrangler.toml` or in your environment.

Deploy

- `wrangler publish` from this folder.
