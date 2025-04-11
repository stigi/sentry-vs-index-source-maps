# Sentry vs Index Source Maps


This repo is a demonstration of an issue that prevents the use of [shadow-cljs](https://github.com/thheller/shadow-cljs) sourcemaps with sentry. Shadow-cljs produces _index_ source maps, with sections.
Running `sentry-cli sourcemaps inject` on such sourcemaps results in error though.

This repo contains such an example inside [dist-example](./dist-example). Alternatively one can recompile the example by running `npm run build`.

This repo provides a quick reproduction of the issue by running `npm run demo:example`:

```
$ npm run demo:example

> shadow-maps@0.0.1 demo:example
> sentry-cli sourcemaps inject dist-example

> Searching dist-example
> Found 2 files
> Analyzing 2 sources
> Analyzing completed in 0.001s
> Injecting debug ids
error: Invalid sourcemap at dist-example/demo.js.map

Caused by:
    encountered incompatible sourcemap format

Add --log-level=[info|debug] or export SENTRY_LOG_LEVEL=[info|debug] to see more output.
Please attach the full debug log to all bug reports.
```
