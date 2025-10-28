# #381 Conventional Commits

A specification for adding human and machine readable meaning to commit messages.

## Notes

The [Conventional Commits](https://www.conventionalcommits.org/) specification is a lightweight convention on top of commit messages. It provides an easy set of rules for creating an explicit commit history; which makes it easier to write automated tools on top of. This convention dovetails with [Semantic Versioning](https://semver.org/), by describing the features, fixes, and breaking changes made in commit messages.

The commit message should be structured as follows:

```text
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

Where for example:

* `type` could be: fix, feat etc
* `optional scope` could be `(api)`, `(css)` etc

It aligns with semantic versioning (Semantic Versioning / SemVer) by mapping commit types to version bump semantics:

* feat: new feature → MINOR bump
* fix: bug fix → PATCH bump
* BREAKING CHANGE: (or ! after type) → incompatible API change → MAJOR bump

Status?

* the idea has been adopted or at least considered by many teams
* It has spurred an ecosystem of tooling: linters (e.g., commitlint), commit message generators (e.g., commitizen), changelog generators, release-automation tools and more.

See also: [LCK#380 Conventional Comments](../conventionalcomments/)

## Credits and References

* <https://www.conventionalcommits.org/>
* <https://semver.org/>
* [LCK#380 Conventional Comments](../conventionalcomments/)
