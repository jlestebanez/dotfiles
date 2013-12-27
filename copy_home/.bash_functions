# Create a new directory and enter it
function md() {
        mkdir -p "$@" && cd "$@"
}

# find shorthand
function f() {
    find . -name "$1"
}

# cd into whatever is the forefront Finder window.
function cdf() {  # short for cdfinder
  cd "`osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)'`"
}

# Start an HTTP server from a directory, optionally specifying the port
function server() {
        local port="${1:-8000}"
        open "http://localhost:${port}/"
        # Set the default Content-Type to `text/plain` instead of `application/octet-stream`
        # And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
        python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port"
}


# Copy w/ progress
function cp_p () {
  rsync -WavP --human-readable --progress $1 $2
}

# Extract archives - use: extract <file>
# Based on http://dotfiles.org/~pseup/.bashrc
function extract() {
        if [ -f "$1" ] ; then
                local filename=$(basename "$1")
                local foldername="${filename%%.*}"
                local fullpath=`perl -e 'use Cwd "abs_path";print abs_path(shift)' "$1"`
                local didfolderexist=false
                if [ -d "$foldername" ]; then
                        didfolderexist=true
                        read -p "$foldername already exists, do you want to overwrite it? (y/n) " -n 1
                        echo
                        if [[ $REPLY =~ ^[Nn]$ ]]; then
                                return
                        fi
                fi
                mkdir -p "$foldername" && cd "$foldername"
                case $1 in
                        *.tar.bz2) tar xjf "$fullpath" ;;
                        *.tar.gz) tar xzf "$fullpath" ;;
                        *.tar.xz) tar Jxvf "$fullpath" ;;
                        *.tar.Z) tar xzf "$fullpath" ;;
                        *.tar) tar xf "$fullpath" ;;
                        *.taz) tar xzf "$fullpath" ;;
                        *.tb2) tar xjf "$fullpath" ;;
                        *.tbz) tar xjf "$fullpath" ;;
                        *.tbz2) tar xjf "$fullpath" ;;
                        *.tgz) tar xzf "$fullpath" ;;
                        *.txz) tar Jxvf "$fullpath" ;;
                        *.zip) unzip "$fullpath" ;;
                        *) echo "'$1' cannot be extracted via extract()" && cd .. && ! $didfolderexist && rm -r "$foldername" ;;
                esac
        else
                echo "'$1' is not a valid file"
        fi
}
################
# GIT WORKFLOW #
################


