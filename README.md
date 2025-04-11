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

## Workaround

I'm including a `flatten-sourcemaps.sh` script that can be used to flatten the index sourcemap into a regular one, after which the debug id injection works:

```
$ ./flatten-sourcemaps.sh dist-example
Processed and replaced: demo.js.map
$ npm run demo:example

> shadow-maps@0.0.1 demo:example
> sentry-cli sourcemaps inject dist-example

> Searching dist-example
> Found 2 files
> Analyzing 2 sources
> Analyzing completed in 0.002s
> Injecting debug ids

Source Map Debug ID Injection Report
  Modified: The following source files have been modified to have debug ids
    efb8383c-6edd-555c-b698-ab3b08063f0d - dist-example/demo.js
  Modified: The following sourcemap files have been modified to have debug ids
    efb8383c-6edd-555c-b698-ab3b08063f0d - dist-example/demo.js.map
```