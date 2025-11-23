#!/usr/bin/sh

arch_list="amd64 arm64"

for arch in $arch_list; do
    echo '---
File: DEP-11
Version: "1.0"
Origin: wcbing APT Repo' > "Components-$arch.yml"

    # 假设所有 yaml 都是符合标准的，结尾有空行
    find "components/$arch" -name "*.yaml" -exec cat {} >> Components-$arch.yml \;
done
