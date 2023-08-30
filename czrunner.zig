//! Codewars Zig test Runner
const std = @import("std");
const builtin = @import("builtin");

// Remove "test." prefix
fn fmt_test(test_name: []const u8) []const u8 {
    var i: usize = 0;
    while (test_name[i] != '.')
        i += 1;
    return test_name[i + 1 ..];
}

// Using simplified main version for proof-of-concept
pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    for (builtin.test_functions) |test_fn| {
        try stdout.print("<IT::>{s}\n\n", .{fmt_test(test_fn.name)});

        const result = test_fn.func();

        if (result) |_| {
            try stdout.print("<PASSED::>\n\n", .{});
        } else |err| {
            try stdout.print("<FAILED::>{s}\n\n", .{@errorName(err)});
        }

        // try stdout.print("<COMPLETEDIN::>\n\n", .{});
    }
}
