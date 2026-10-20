#!/usr/bin/env bash
# Lite bundle: pods, events, and describe/logs for pods that are not Running.
# Usage: triage.sh NAMESPACE [OUTPUT_DIR]
set -euo pipefail

usage() {
  echo "usage: triage.sh NAMESPACE [OUTPUT_DIR]" >&2
}

if [[ $# -lt 1 || "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  usage
  exit 2
fi

ns="$1"
stamp="$(date -u +%Y%m%dT%H%M%SZ)"
out="${2:-triage-${ns}-${stamp}}"
mkdir -p "$out"
kubectl_bin="${KUBECTL:-kubectl}"

capture() {
  dest="$1"
  shift
  if "$@" >"$dest" 2>"$dest.err"; then
    rm -f "$dest.err"
  else
    {
      printf 'command failed:'
      printf ' %q' "$@"
      printf '\n'
    } >>"$out/errors.txt"
  fi
}

{
  printf 'namespace=%s\n' "$ns"
  printf 'captured_at=%s\n' "$stamp"
} >"$out/meta.txt"

capture "$out/pods.txt" "$kubectl_bin" --namespace "$ns" get pods -o wide
capture "$out/events.txt" "$kubectl_bin" --namespace "$ns" get events --sort-by=.lastTimestamp

if [[ -f "$out/pods.txt" ]]; then
  while read -r name _ status _; do
    if [[ -z "${name:-}" || "$name" == "NAME" ]]; then
      continue
    fi
    case "${status:-}" in
      Running|Completed)
        continue
        ;;
    esac
    safe="${name//[^A-Za-z0-9._-]/_}"
    capture "$out/describe-${safe}.txt" "$kubectl_bin" --namespace "$ns" describe pod "$name"
    capture "$out/logs-${safe}.txt" "$kubectl_bin" --namespace "$ns" logs "$name" --all-containers --tail=80
  done <"$out/pods.txt"
fi

printf 'diagnostics written to %s\n' "$out"
