# WARNING

Currently, because zig testing lib doesn't support "quiet mode" (always prints errors) \
[Zig issue](https://github.com/ziglang/zig/issues/14245). \
[Coderunner issue](https://github.com/codewars/runner/issues/136).

## Example 
```shell
$ zig test --test-runner codewars_runner.zig examples/failed.zig
<IT>::>simple1
<PASSED::>simple1
<COMPLETEDIN::>0

<IT>::>simple2
<PASSED::>simple2
<COMPLETEDIN::>0

<IT>::>not simple
expected 36504, found 100
<ERROR::>TestExpectedEqual
<COMPLETEDIN::>0

```

Here you can see `expected 36504, found 100`. It is printed directly from `std.testing.expectEqual` via `std.debug.print`.

The only solution I can see (except fixing stdlib) - abandon error descriptions, stderr and use stdout only. This is implemented in [here]:(noerrmes_runner.zig)
```shell
$ zig test --test-runner noerrmes_runner.zig examples/failed.zig 2> /dev/null
<IT>::>simple1
<PASSED::>simple1
<COMPLETEDIN::>0

<IT>::>simple2
<PASSED::>simple2
<COMPLETEDIN::>0

<IT>::>not simple
<ERROR::>TestExpectedEqual
<COMPLETEDIN::>0
```

# Zig test runner for codewars

This is test runner implementation for codewars coderunner.

## Motivation

As mentioned in codewars [zig issue](https://github.com/codewars/runner/issues/136) zig 0.11.0 supports custom coderunner.

So I've took my time and implemented one, according to [codewars format](https://github.com/codewars/runner/blob/main/docs/messages.md)

## How to build/test?

To run any zig tests with this runnner you need to specify it with `--test-runner` flag:
```shell
zig test --test-runner codewars_runner.zig examples/test_multiply.zig
```

## Project structure

For testing I chose trivial task - product of two numbers

`test_runner.zig` - actual codewars test runner \
`examples/` - directory with several example test-files:
- `main.zig` - testing function;
- `passed.zig` - three correct tests;
- `failed.zig` - two correct and one failed tests.
