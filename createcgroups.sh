#!/bin/sh
# Copied from judgehost

JUDGEHOSTUSER=root
CGROUPBASE=/sys/fs/cgroup

print_cgroup_instruction () {
    echo ""
    echo "To fix this, please make the following changes:
    1. In /etc/default/grub, add 'cgroup_enable=memory swapaccount=1' to GRUB_CMDLINE_LINUX_DEFAULT.
       On modern distros (e.g. Debian bullseye and Ubuntu Jammy Jellyfish) which have cgroup v2 enabled by default,
       you need to add 'systemd.unified_cgroup_hierarchy=0' as well.
    2. Run update-grub
    3. Reboot" >&2
    exit 1
}

for i in cpuset memory; do
    mkdir -p $CGROUPBASE/$i
    if [ ! -d $CGROUPBASE/$i/ ]; then
        if ! mount -t cgroup -o$i $i $CGROUPBASE/$i/; then
            echo "Error: Can not mount $i cgroup. Probably cgroup support is missing from running kernel. Unable to continue."
            print_cgroup_instruction
        fi
    fi
    mkdir -p $CGROUPBASE/$i/domjudge
done

if [ ! -f $CGROUPBASE/memory/memory.limit_in_bytes ] || [ ! -f $CGROUPBASE/memory/memory.memsw.limit_in_bytes ]; then
    echo "Error: cgroup support missing memory features in running kernel. Unable to continue."
    print_cgroup_instruction
fi

chown -R $JUDGEHOSTUSER $CGROUPBASE/*/domjudge

cat $CGROUPBASE/cpuset/cpuset.cpus > $CGROUPBASE/cpuset/domjudge/cpuset.cpus
cat $CGROUPBASE/cpuset/cpuset.mems > $CGROUPBASE/cpuset/domjudge/cpuset.mems
