// Cloudflare Worker: cache-json
// Proxies requests to a JSON API and caches responses for 5 minutes (300 seconds).

addEventListener('fetch', event => {
  event.respondWith(handleRequest(event))
})

const CACHE_TTL_SECONDS = 300 // 5 minutes

// If set via `wrangler.toml` [vars], UPSTREAM_API should be an absolute origin
// e.g. "https://api.example.com". When present, requests are proxied to that origin
// preserving path and query string.
const UPSTREAM = typeof UPSTREAM_API !== 'undefined' ? UPSTREAM_API : null

async function handleRequest(event) {
  const request = event.request

  // Only cache GET requests and JSON responses
  if (request.method !== 'GET') {
    return fetch(request)
  }

  const cache = caches.default
  const cacheKey = new Request(request.url, request)

  // Try cache first
  const cached = await cache.match(cacheKey)
  if (cached) return cached.clone()

  // Not in cache: fetch from origin or upstream (if configured)
  let fetchReq = request
  if (UPSTREAM) {
    const url = new URL(request.url)
    const target = UPSTREAM.replace(/\/$/, '') + url.pathname + url.search
    fetchReq = new Request(target, request)
  }

  const fetchResp = await fetch(fetchReq)

  // Only cache successful JSON responses
  const contentType = fetchResp.headers.get('content-type') || ''
  if (fetchResp.ok && contentType.includes('application/json')) {
    // Clone response so we can put one in cache and return the other
    const responseToCache = fetchResp.clone()

    // Create a new response with an explicit `Cache-Control` max-age so Cloudflare honors TTL
    const headers = new Headers(responseToCache.headers)
    headers.set('Cache-Control', `public, max-age=${CACHE_TTL_SECONDS}`)

    const body = await responseToCache.arrayBuffer()
    const cacheResponse = new Response(body, {
      status: responseToCache.status,
      statusText: responseToCache.statusText,
      headers,
    })

    // Use event.waitUntil so cache.put can complete asynchronously
    event.waitUntil(cache.put(cacheKey, cacheResponse).catch(() => {}))

    // Return original fetch response
    return fetchResp
  }

  // Non-cacheable: just pass-through
  return fetchResp
}
