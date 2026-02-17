#!/bin/bash
set -e

mode=$(supergfxctl --get || echo "unknown mode")


if [ "$mode" = "Integrated" ]; then
  echo "found state as $mode, switching to Hybrid"
  powerprofilesctl set performance
  supergfxctl --mode Hybrid

elif [ "$mode" = "Hybrid" ]; then
  echo "found state as $mode, switching to Integrated"
  powerprofilesctl set power-saver
  supergfxctl --mode Integrated

else
  echo "supergfxctl --get returned unknown keyword $mode"
  exit 1
fi

echo "All done! stopping compositor now"
uwsm stop
