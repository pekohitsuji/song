#!/bin/bash
# -*- coding: utf-8-unix; mode: shell-script; sh-basic-offset: 2 -*-

### # 概要
###

out=README.md

cat > "${out}" << 'EOT'
<!-- coding: utf-8-unix; mode: markdown -->
# 曲の調査と報告

## ツール

| ツール | 結果 | 内容 |
|--------|:-----|:-----|
| [identify_ai.py](identify_ai.py) | [identify_ai.md](identify_ai.md) | どの AI で生成したか |

## 調査方法

下記に [instruction](<---instruction.md>) を入力する

| AI      | 入力箇所 | 1日最大 | 備考 |
|:--------|:---------|--------:|:-----|
| ChatGPT | プロジェクトの設定/指示 | 15 | 簡素、やや不安定、早い |
| Claude  | プロジェクト/手順 | 5 | 詳しい、安定 |
| Gemini  | Gem/編集/カスタム指示 | > 30 | 簡素、やや不安定、早い |


## 調査結果

AI による調査です。事実と異なることが含まれています。

EOT

for x in "$@" ; do
  echo "- [${x%.html}](<$x>)"
done >> "${out}"
