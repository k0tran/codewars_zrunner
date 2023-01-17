const std = @import("std");
const builtin = @import("builtin");

fn strip_dot(name: []const u8) []const u8 {
    var start: usize = 0;
    while (name[start] != '.') start += 1;
    return name[start + 1..];
}

pub fn main() void {
    // open stdout
    const stdout = std.io.getStdOut().writer();

    for (builtin.test_functions) |test_fn| {
        // Optional: strip 'test.'
        const name = strip_dot(test_fn.name);
        stdout.print("<IT>::>{s}\n", .{ name }) catch { return; };

        // async is not supported
        if (test_fn.async_frame_size) |_| {
            // print to stdout/stderr "Async is not supported"
            return;
        }

        // time clocking
        var timer = if (std.time.Timer.start()) |t| t else |_| {
            // print to stdout/stderr "Timer error"
            return;
        };

        const result = test_fn.func();
        const estimated = timer.read() / std.time.ns_per_ms;

        if (result) |_| {
            stdout.print("<PASSED::>{s}\n", .{ name }) catch {};
        } else |err| {
            stdout.print("<ERROR::>{s}\n", .{ @errorName(err) }) catch {};
        }
        stdout.print("<COMPLETEDIN::>{d}\n\n", .{ estimated }) catch {};
    }
}
