#!/usr/bin/env bash
set -euo pipefail

# Adjust these for your OS if needed
PROFILE_ID=${PROFILE_ID:-"xccdf_org.ssgproject.content_profile_stig"}
CONTENT=${CONTENT:-"/usr/share/xml/scap/ssg/content/ssg-rhel9-ds.xml"}
OUT_DIR=${OUT_DIR:-"./openscap-output"}

mkdir -p "$OUT_DIR"
cd "$OUT_DIR"

echo "[OpenSCAP] Using profile: $PROFILE_ID"
echo "[OpenSCAP] Using content: $CONTENT"

# Clean old results
rm -f results-arf.xml report.html || true

oscap xccdf eval \
  --profile "$PROFILE_ID" \
  --results-arf results-arf.xml \
  --report report.html \
  "$CONTENT"

RC=$?
echo "[OpenSCAP] oscap exit code: $RC"
exit $RC

