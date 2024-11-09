const std = @import("std");

// Although this function looks imperative, note that its job is to
// declaratively construct a build graph that will be executed by an external
// runner.
pub fn build(b: *std.Build) void {
    // Standard target options allows the person running `zig build` to choose
    // what target to build for. Here we do not override the defaults, which
    // means any target is allowed, and the default is native. Other options
    // for restricting supported target set are available.
    const target = b.standardTargetOptions(.{});

    // Standard optimization options allow the person running `zig build` to select
    // between Debug, ReleaseSafe, ReleaseFast, and ReleaseSmall. Here we do not
    // set a preferred release mode, allowing the user to decide how to optimize.
    const optimize = b.standardOptimizeOption(.{});

    const common = b.addStaticLibrary(.{
        .name = "common",
        .root_source_file = b.path("src/common.zig"),
        .target = target,
        .optimize = optimize,
    });
    const binc = b.addExecutable(.{
        .name = "binc",
        .root_source_file = b.path("src/binc.zig"),
        .target = target,
        .optimize = optimize,
    });
    binc.linkLibrary(common);
    const decc = b.addExecutable(.{
        .name = "decc",
        .root_source_file = b.path("src/decc.zig"),
        .target = target,
        .optimize = optimize,
    });
    decc.linkLibrary(common);
    const hexc = b.addExecutable(.{
        .name = "hexc",
        .root_source_file = b.path("src/hexc.zig"),
        .target = target,
        .optimize = optimize,
    });
    hexc.linkLibrary(common);
    const octc = b.addExecutable(.{
        .name = "octc",
        .root_source_file = b.path("src/octc.zig"),
        .target = target,
        .optimize = optimize,
    });
    octc.linkLibrary(common);
    // This declares intent for the executable to be installed into the
    // standard location when the user invokes the "install" step (the default
    // step when running `zig build`).
    b.installArtifact(binc);
    b.installArtifact(decc);
    b.installArtifact(hexc);
    b.installArtifact(octc);
}
