const std = @import("std");
const mul = @import("mult.zig").multiply;

test "simple1" {
    try std.testing.expectEqual(mul(2, 5), 10);
}

test "simple2" {
    try std.testing.expectEqual(mul(3, 10), 30);
}

test "simple3" {
    try std.testing.expectEqual(mul(156, 234), 36504);
}
