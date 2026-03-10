# Processing sketch runner
# Add this to your ~/.zshrc by running:
#   echo 'source /path/to/processing.zsh' >> ~/.zshrc
#
# Usage:
#   processing <file.pde>              — run a sketch
#   processing <file.pde> --app        — export standalone app next to the sketch
#   processing <file.pde> --app=<path> — export standalone app to a relative path

processing() {
    # ─── Locate processing-java ──────────────────────────────────────────────
    local PROC_JAVA
    PROC_JAVA="$(which processing-java 2>/dev/null)"

    if [[ -z "$PROC_JAVA" ]]; then
        # Try the default Homebrew cask location
        local DEFAULT="/Applications/Processing.app/Contents/MacOS/processing-java"
        if [[ -x "$DEFAULT" ]]; then
            PROC_JAVA="$DEFAULT"
        else
            echo "processing-java not found in PATH or at $DEFAULT."
            echo -n "Enter the full path to processing-java: "
            read PROC_JAVA
            if [[ ! -x "$PROC_JAVA" ]]; then
                echo "Error: '${PROC_JAVA}' is not executable or does not exist."
                return 1
            fi
            echo ""
            echo "Tip: add this to your ~/.zshrc to avoid this prompt in the future:"
            echo "  export PATH=\"\$PATH:$(dirname "$PROC_JAVA")\""
            echo "  or: alias processing-java=\"${PROC_JAVA}\""
        fi
    fi

    # ─── Parse arguments ─────────────────────────────────────────────────────
    local PDE_FILE=""
    local APP_FLAG=0
    local APP_OUTPUT=""

    for arg in "$@"; do
        if [[ "$arg" == --app=* ]]; then
            APP_FLAG=1
            # Extract the path after --app=, resolve relative to CWD
            APP_OUTPUT="$(pwd)/${arg#--app=}"
        elif [[ "$arg" == "--app" ]]; then
            APP_FLAG=1
        elif [[ "$arg" == --* ]]; then
            echo "Unknown option: $arg"
            return 1
        else
            PDE_FILE="$arg"
        fi
    done

    # ─── Validate .pde file ──────────────────────────────────────────────────
    if [[ -z "$PDE_FILE" ]]; then
        echo "Usage: processing <file.pde> [--app[=<output_path>]]"
        return 1
    fi

    if [[ ! -f "$PDE_FILE" ]]; then
        echo "Error: file '${PDE_FILE}' not found."
        return 1
    fi

    # Resolve the .pde to an absolute path
    local ABS_PDE
    ABS_PDE="$(cd "$(dirname "$PDE_FILE")" && pwd)/$(basename "$PDE_FILE")"

    local SKETCH_NAME
    SKETCH_NAME="$(basename "$ABS_PDE" .pde)"

    local SKETCH_DIR
    SKETCH_DIR="$(dirname "$ABS_PDE")"

    # Processing requires the sketch folder to have the same name as the .pde file.
    # If the parent folder name doesn't match, create a temp wrapper folder.
    local PARENT_DIR_NAME
    PARENT_DIR_NAME="$(basename "$SKETCH_DIR")"

    local EFFECTIVE_SKETCH_DIR
    if [[ "$PARENT_DIR_NAME" != "$SKETCH_NAME" ]]; then
        # Create a temp dir with the correct name and symlink the .pde inside it
        local TMPDIR_BASE
        TMPDIR_BASE="$(mktemp -d)"
        EFFECTIVE_SKETCH_DIR="${TMPDIR_BASE}/${SKETCH_NAME}"
        mkdir -p "$EFFECTIVE_SKETCH_DIR"
        ln -s "$ABS_PDE" "${EFFECTIVE_SKETCH_DIR}/${SKETCH_NAME}.pde"
        # Also symlink any sibling .pde files (multi-tab sketches)
        for f in "${SKETCH_DIR}"/*.pde; do
            local fname
            fname="$(basename "$f")"
            if [[ "$fname" != "$(basename "$ABS_PDE")" ]]; then
                ln -s "$f" "${EFFECTIVE_SKETCH_DIR}/${fname}"
            fi
        done
        # Cleanup temp dir on exit (only for this invocation)
        trap "rm -rf '${TMPDIR_BASE}'" EXIT
    else
        EFFECTIVE_SKETCH_DIR="$SKETCH_DIR"
    fi

    # ─── Run or Export ───────────────────────────────────────────────────────
    if [[ $APP_FLAG -eq 0 ]]; then
        # Normal run — just launch the sketch window
        "$PROC_JAVA" \
            --sketch="$EFFECTIVE_SKETCH_DIR" \
            --run
    else
        # Export as standalone app
        if [[ -z "$APP_OUTPUT" ]]; then
            # No path given: export next to the sketch folder
            APP_OUTPUT="${SKETCH_DIR}/${SKETCH_NAME}-app"
        fi

        echo "Exporting standalone app to: ${APP_OUTPUT}"

        "$PROC_JAVA" \
            --sketch="$EFFECTIVE_SKETCH_DIR" \
            --output="$APP_OUTPUT" \
            --export \
            --force

        if [[ $? -eq 0 ]]; then
            echo "Done! App exported to: ${APP_OUTPUT}"
        else
            echo "Export failed."
            return 1
        fi
    fi
}
