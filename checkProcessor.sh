arch_name="$(uname -m)"
 
if [ "${arch_name}" = "x86_64" ]; then
    if [ "$(sysctl -in sysctl.proc_translated)" = "1" ]; then
        echo "Running on Rosetta 2"
    else
        pod install
    fi
elif [ "${arch_name}" = "arm64" ]; then
    arch -x86_64 pod update  --repo-update
else
    echo "Unknown architecture: ${arch_name}"
fi
