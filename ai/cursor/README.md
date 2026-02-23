# #414 Cursor

A quick introduction to Cursor, an AI-powered code editor.

## Notes

[Cursor](https://www.cursor.com/) is an AI-powered code editor developed by **AnySphere**, a startup founded by MIT graduates in 2022. It's built as a fork of Visual Studio Code, combining the familiar VS Code interface with deeply integrated AI capabilities that go far beyond simple autocomplete.

There is a Hobby (Free) plan, with limited daily completions.

### Product Architecture

* Local IDE & CLI
    * Agent mode: Complex features, refactoring; Autonomous exploration, multi-file edits; All tools enabled.
    * Ask mode: Learning, planning, questions; Read-only exploration, no automatic changes; Search tools only.
    * Plan mode: Complex features requiring planning; Creates detailed plans before execution, asks clarifying questions; All tools enabled.
    * Debug mode: Tricky bugs, regressions; Hypothesis generation, log instrumentation, runtime analysis; All tools + debug server
* Web-based UI for cloud agents - only paid plans

### Where Cursor Excels

* Large-Scale Refactoring
    * Rename functions across entire repos, update imports, and apply changes consistently
    * Example: "Rename `generateCartTotal` to `calculateCartTotal` across all files"
* Complex, Multi-File Projects
    * Navigate and modify interdependent codebases
    * Better context awareness than Copilot for monorepos
* AI-Driven Development ("Vibe Coding")
    * Natural language to working code: describe features, let the agent implement
    * End-to-end task automation from planning to PR creation
* Codebase Exploration & Onboarding
    * Ask questions about unfamiliar codebases
    * Get instant explanations with referenced source locations
* Teams Needing Model Flexibility
    * Switch between models based on task requirements
    * Compare outputs from multiple models in parallel

### Less Suitable For

* Simple, single-file scripts where basic autocomplete suffices
* Developers deeply embedded in GitHub-centric workflows who prefer minimal disruption
* Budget-conscious individual users

### Standout Features

* Project-Wide Context Awareness
    * Automatically indexes your entire codebase when you open a project
    * Understands cross-file relationships and dependencies
    * Enables multi-file refactoring with natural language commands
* AI Code Completion (Tab)
    * Suggests multi-line code blocks and entire functions
    * Predicts your next edit location
    * Auto-imports symbols for TypeScript/Python
* Local, Workspace and Cloud Agents
    * Complete end-to-end coding tasks without supervision
    * Can write code, commit changes, and create pull requests autonomously
* Multi-Model Support
    * Choose from GPT-4o, o1, Claude 3.5/4.5 Sonnet, Gemini 2.5 Pro, Grok Code, and custom models
    * Parallel agents: Run multiple models simultaneously on the same prompt, each in separate Git worktrees
* Advanced Tooling
    * MCP (Model Context Protocol) servers: Connect to external systems (Google Drive, Notion, etc.)
    * Subagents: Spawn specialized agents for complex tasks
    * Plan Mode: Generates detailed `.MD` plans with "Build" buttons to spawn new agents
* Privacy Mode
    * Zero data retention—code isn't stored or used for model training
    * Local file indexing until you initiate queries
    * Enabled by default for team plans

## Credits and References

* <https://www.cursor.com/>
