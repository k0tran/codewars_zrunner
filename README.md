# About

This repository used as zig and codewars integration playground ([codewars test report format](https://github.com/codewars/runner/blob/main/docs/messages.md) for zig test)

## Current state

[Coderunner issue](https://github.com/codewars/runner/issues/136)

Until [zig#14245](https://github.com/ziglang/zig/issues/14245) is fixed there is no way to output test fail messages in format required by codewars. This happens because functions `std.testing.*` are printing error message (via `std.debug.print`) BEFORE function returns error. So it's impossible to print custom prefix (because test is not guaranteed fail) nor configure message output.  

Maybe something will be possible when [zig#5738](https://github.com/ziglang/zig/issues/5738) arrive. We might be able to filter test fail messages and then print them out with the desired format through custom `log` implementation.

## Examples

In [mult.zig](examples/mult.zig) there is simple multiplication function which is tested in:
- [passed.zig](examples/passed.zig) - 3 passing tests
- [failed.zig](examples/failed.zig) - 2 passing tests and 1 failing

Those tests can be run:
```shell
zig test examples/passed.zig
# or
zig test examples/failed.zig
```

## Runners

Current [experimental implementation](czrunner.zig) does not support printing test fail messages but it can produce test pass-fail base info (reading what printed to stderr by test function doesn't work):

```shell
$ zig test --test-runner czrunner.zig examples/failed.zig 2> /dev/null 
<IT::>simple1

<PASSED::>

<IT::>simple2

<PASSED::>>

<IT::>not simple

<FAILED::>TestExpectedEqual
```

```shell
$ zig test --test-runner czrunner.zig examples/passed.zig 2> /dev/null
<IT::>simple1

<PASSED::>

<IT::>simple2

<PASSED::>

<IT::>simple3

<PASSED::>
```
