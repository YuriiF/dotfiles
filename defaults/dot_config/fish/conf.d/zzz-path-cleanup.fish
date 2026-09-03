# Deduplicate and prune PATH (runs after all other conf.d files).
# Keep required toolchain directories even when their entries were inherited
# before env.fish ran or were removed by another startup hook.
set -l clean
for p in $PATH
    if test -d "$p"; and not contains -- "$p" $clean
        set -a clean "$p"
    end
end
for p in /opt/rocm/bin /opt/rocm/lib/llvm/bin
    test -d "$p"; and not contains -- "$p" $clean; and set -a clean "$p"
end
set -gx PATH $clean
