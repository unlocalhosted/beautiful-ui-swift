#!/usr/bin/env bash

set -euo pipefail

repository_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
input_directory="${1:-${repository_root}/Artifacts}"
output_directory="${repository_root}/Media/Previews"

command -v ffmpeg >/dev/null || {
    echo "ffmpeg is required to generate GitHub previews." >&2
    exit 1
}

mkdir -p "${output_directory}"

for input_path in "${input_directory}"/[0-9][0-9]-*.mp4; do
    [[ -f "${input_path}" ]] || continue

    filename="$(basename "${input_path}" .mp4)"
    output_path="${output_directory}/${filename}.gif"

    ffmpeg -hide_banner -loglevel error -y -i "${input_path}" \
        -filter_complex "fps=8,scale=360:-2:flags=lanczos,split[a][b];[a]palettegen=max_colors=96:stats_mode=diff[p];[b][p]paletteuse=dither=bayer:bayer_scale=3" \
        -loop 0 "${output_path}"
done
