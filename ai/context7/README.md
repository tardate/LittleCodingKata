# #373 Context7

Using Context7 MCP Server with VSCode and GitHub Copilot to improve code generation quality.

## Notes

LLMs are notorious for generating code using obsolete libraries and APIs, because that's what is in their training data.

Context7 is an MCP Server that pulls up-to-date, version-specific documentation and code examples directly from the source,
and makes these available to Cursor, Claude, or any LLM. This should result in more accurate code generation.

Context7 is available in a few forms:

* hosted free plan. Public repos only
* hosted paid or enterprise plans. Private repos, teams, SSO
* self-hosted

The hosted service currently includes the docs for 47,978 Libraries.

### Testing the API

Search for libraries:

```sh
$ curl -X GET "https://context7.com/api/v1/search?query=ruby+openai" -H "Authorization: Bearer ${CONTEXT7_API_KEY}" | jq
{
  "results": [
    {
      "id": "/alexrudall/ruby-openai",
      "title": "Ruby OpenAI",
      "description": "A Ruby gem to interact with the OpenAI API, supporting features like chat streaming, audio transcription, image generation, and more.",
      "branch": "main",
      "lastUpdateDate": "2025-08-13T10:09:20.851Z",
      "state": "finalized",
      "totalTokens": 16149,
      "totalSnippets": 94,
      "totalPages": 8,
      "stars": 3053,
      "trustScore": 9.4,
      "versions": []
    },
    {
      "id": "/openai/openai-ruby",
      "title": "OpenAI Ruby",
      "description": "The OpenAI Ruby library provides convenient access to the OpenAI REST API from any Ruby 3.2.0+ application, supporting features like streaming, pagination, file uploads, and webhook verification.",
      "branch": "main",
      "lastUpdateDate": "2025-06-20T02:26:16.686Z",
      "state": "finalized",
      "totalTokens": 3585,
      "totalSnippets": 32,
      "totalPages": 3,
      "stars": 236,
      "trustScore": 9.1,
      "versions": []
    },
...
}
```

To get documentation, e.g. regarding pagination using the `openai/openai-ruby` library discovered above..

```sh
$ curl -X GET "https://context7.com/api/v1/openai/openai-ruby?type=txt&topic=pagination&tokens=1000" -H "Authorization: Bearer ${CONTEXT7_API_KEY}"
### Manually Control OpenAI Pagination

Source: https://github.com/openai/openai-ruby/blob/main/README.md

This snippet illustrates how to manually control pagination using `next_page?` and `next_page` methods. It allows for more granular control over fetching successive pages of list responses.

if page.next_page?
  new_page = page.next_page
  puts(new_page.data[0].id)
end

...(a few more pages)...
```

### Using VSCode with Hosted Context7

To manually enable the MCP Service in just this workspace,
I added the following to `./.vscode/mcp.json`.
This is enough to have it appear in the Extensions "MCP Servers - Installed" list as a "Workspace MCP Server"

```json
{
  "servers": {
    "context7": {
      "type": "http",
      "url": "https://mcp.context7.com/mcp",
      "headers": {
        "CONTEXT7_API_KEY": "YOUR_API_KEY"
      }
    }
  }
}
```

To enable globally, I could add this under the `mcp` key of my user settings file.
or add the [Context7 MCP Server](https://marketplace.visualstudio.com/items?itemName=Upstash.context7-mcp) from the extensions page.

### Using GitHub Copilot

Here's a quick example of using the context7 MCP Server to assist GitHub Copilot to perform a task within vscode:

* Open the Chat window
* Switch to agent mode
* Model: GPT-5-mini
* Click tools and verify context7 MCP server is enabled

Then give it the prompt:

```text
Configure a Cloudflare Worker script to cache JSON API responses for five minutes. use context7
```

It proceeded to generate a worker configuration, which I have moved as an example here:

* [workers-example/cache-json/README.md](https://github.com/tardate/LittleCodingKata/tree/main/tools/ai/context7/workers-example/cache-json/README.md)
* [workers-example/cache-json/USAGE.md](https://github.com/tardate/LittleCodingKata/tree/main/tools/ai/context7/workers-example/cache-json/USAGE.md)
* [workers-example/cache-json/worker.js](https://github.com/tardate/LittleCodingKata/tree/main/tools/ai/context7/workers-example/cache-json/worker.js)
* [workers-example/cache-json/wrangler.toml](https://github.com/tardate/LittleCodingKata/tree/main/tools/ai/context7/workers-example/cache-json/wrangler.toml)

### Adding Libraries to Context7

Can manually add a library via the [web interface](https://context7.com/add-library?tab=github).

Library authors can fine tune how Context7 parses and presents the library
by adding a [context7.json](https://github.com/upstash/context7/blob/master/docs/adding-projects.md#advanced-configuration-with-context7json) definition.

## Credits and References

* <https://context7.com/>
* <https://github.com/upstash/context7>
* <https://code.visualstudio.com/docs/copilot/customization/mcp-servers>
