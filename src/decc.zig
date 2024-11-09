const std = @import("std");
const com = @import("common.zig");
const allocator = std.heap.page_allocator;

pub fn main() !void {
    var args = std.process.args();
    const conf = try com.parse_args(&args);
    if (conf.err == 1) {
        return;
    }

    var inf = try std.fs.cwd().openFile(conf.input.?, .{});
    defer inf.close();
    const inf_size = try inf.getEndPos();

    var outf = try std.fs.cwd().createFile(conf.output.?, .{ .truncate = true });
    defer outf.close();

    const in_data = try inf.readToEndAlloc(allocator, inf_size);
    defer allocator.free(in_data);

    var tok = std.mem.tokenize(u8, in_data, "\n");
    while (tok.next()) |line| {
        std.debug.print("{s}\n", .{line});
        switch (conf.format) {
            8 => {
                const hex = try std.fmt.parseInt(u8, line, 10);
                try outf.writer().writeInt(u8, hex, std.builtin.Endian.little);
            },
            16 => {
                const hex = try std.fmt.parseInt(u16, line, 10);
                try outf.writer().writeInt(u16, hex, std.builtin.Endian.little);
            },
            32 => {
                const hex = try std.fmt.parseInt(u32, line, 10);
                try outf.writer().writeInt(u32, hex, std.builtin.Endian.little);
            },
            64 => {
                const hex = try std.fmt.parseInt(u64, line, 10);
                try outf.writer().writeInt(u64, hex, std.builtin.Endian.little);
            },
            else => {
                std.debug.print("error: unexpectd format", .{});
            },
        }
    }
}
