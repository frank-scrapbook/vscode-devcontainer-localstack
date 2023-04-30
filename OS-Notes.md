# OS Notes
## Details

### OS

In .devcontainer/devcontainer.json, using image:
```
"image": "mcr.microsoft.com/devcontainers/base:jammy",
```

OS Details (`uname -a`): 
```
Linux bc7f8f4c3cbb 5.15.49-linuxkit #1 SMP PREEMPT Tue Sep 13 07:51:32 UTC 2022 aarch64 aarch64 aarch64 GNU/Linux
```

OS Details (`uname -sm`):
```
Linux aarch64
```

From dev container build: 
```
[2043 ms] Start: Run in container: (cat /etc/os-release || cat /usr/lib/os-release) 2>/dev/null
[2044 ms] PRETTY_NAME="Ubuntu 22.04.1 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.1 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```