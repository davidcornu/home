#!/usr/bin/env bash

set -e

if [[ -z "$1" ]]; then
  echo "Please specify a SHA"
  exit 1
fi

INITIAL_COMMIT="$1"

restore_name_status() {
  local operation="$(echo "$1" | cut -c1)"
  local filename="$(echo "$1" | cut -d$'\t' -f2)"
  if [[ "$operation" == "A" ]]; then
    git rm -- "$filename"
  elif [[ "$operation" == "M" ]] || [[ "$operation" == "D" ]]; then
    git checkout "$INITIAL_COMMIT" -- "$filename"
    echo "co '$filename'"
  fi
}

ensure_diff_empty() {
  local changed_files="$(git diff "$INITIAL_COMMIT" | wc -l | tr -d '[:space:]')"
  if [[ "$changed_files" == "0" ]]; then
    echo "Revert to $INITIAL_COMMIT completed successfully"
  else
    echo "Could not successfully revert to $INITIAL_COMMIT"
    exit 1
  fi
}

while read -r name_status; do
  restore_name_status "$name_status"
done < <(git diff --name-status "$INITIAL_COMMIT..HEAD")

ensure_diff_empty
