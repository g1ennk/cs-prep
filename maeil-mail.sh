#!/usr/bin/env bash
# maeil-mail.sh
# Usage:
#   ./maeil-mail.sh -t "전략 패턴에 대해서 설명해주세요"

TITLE=""

while [[ $# -gt 0 ]]; do
  case $1 in
    -t|--title) TITLE="$2"; shift 2 ;;
    -h|--help)
      echo "Usage: $0 -t \"제목\""
      exit 0
      ;;
    *)
      echo "Unknown argument: $1"
      exit 1
      ;;
  esac
done

if [[ -z "$TITLE" ]]; then
  echo "❌ 제목을 입력하세요. 예: $0 -t \"전략 패턴에 대해서 설명해주세요\""
  exit 1
fi

# 저장할 경로
OUTPUT_DIR="/Users/glenn/cs-prep/maeil-mail"
OUTPUT_FILE="$OUTPUT_DIR/$TITLE.md"

# maeil-mail 폴더 없으면 생성
mkdir -p "$OUTPUT_DIR"

# 템플릿 출력 (헤더 1에 TITLE 반영)
cat <<TEMPLATE > "$OUTPUT_FILE"
# $TITLE

## 요약



## 발화

TEMPLATE

echo "✅ 파일 생성 완료: $OUTPUT_FILE"
