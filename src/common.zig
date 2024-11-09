const std = @import("std");

const Conf = struct { input: ?[]const u8, output: ?[]const u8, format: u8, err: u8 };

pub fn parse_args(args: *std.process.ArgIterator) !Conf {
    var c = Conf{
        .input = null,
        .output = null,
        .format = 8,
        .err = 0,
    };
    while (args.next()) |arg| {
        if (std.mem.eql(u8, arg, "-o")) {
            if (args.next()) |o| {
                c.output = o;
            } else {
                std.debug.print("error: expected output", .{});
                c.err = 1;
                return c;
            }
        } else if (std.mem.eql(u8, arg, "-f")) {
            if (args.next()) |f| {
                const v = try std.fmt.parseInt(u8, f, 10);
                c.format = v;
            } else {
                std.debug.print("error: expected format size", .{});
                c.err = 1;
                return c;
            }
        } else {
            c.input = arg;
        }
    }
    if (c.input == null) {
        std.debug.print("error: missing input", .{});
        c.err = 1;
        return c;
    }
    return c;
}
