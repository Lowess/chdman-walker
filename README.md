# chdman-walker

Alpine-based Docker image that **recursively walks** a directory and converts disc images to [CHD (Compressed Hunks of Data)](https://github.com/mamedev/mame/blob/master/docs/source/tools/chdman.rst) using `chdman` from [mame-tools](https://pkgs.alpinelinux.org/package/edge/community/x86_64/mame-tools).

## Features

- Recursively scans subdirectories — handles entire ROM library structures
- Skips files that already have a corresponding `.chd` (safe to re-run)
- Never modifies or deletes source files
- Multi-platform image (`linux/amd64`, `linux/arm64`)
- Minimal Alpine base

## Supported modes

| `CHDMAN_MODE` | Input | Output | Use case |
|---|---|---|---|
| `createcd` *(default)* | `.gdi`, `.cue`, `.iso` | `.chd` | PS1, Dreamcast, CD-based consoles |
| `createdvd` | `.iso` | `.chd` | PSP (UMD), PS2, DVD-based systems |
| `extractcd` | `.chd` | `.cue` + `.bin` | Extract CD CHD back to image |
| `extractdvd` | `.chd` | `.iso` | Extract DVD CHD back to ISO |

## Quick start

```bash
# Convert all GDI/CUE/ISO in a folder (and subfolders) to CHD
docker run --rm \
  -e CHDMAN_MODE=createcd \
  -v "/path/to/roms:/input" \
  lowess/chdman-walker

# PSP / PS2 — use createdvd
docker run --rm \
  -e CHDMAN_MODE=createdvd \
  -v "/path/to/roms:/input" \
  lowess/chdman-walker
```

## Environment variables

| Variable | Default | Description |
|---|---|---|
| `CHDMAN_MODE` | `createcd` | Conversion mode (see table above) |
| `INPUT_DIR` | `/input` | Directory to scan inside the container |

## Unraid

A community template is available at [Lowess/docker-templates-unraid](https://github.com/Lowess/docker-templates-unraid).
