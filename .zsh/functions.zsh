# Syntax-highlight JSON strings or files
# Usage: `json '{"foo":42}'` or `echo '{"foo":42}' | json`
function json() {
  if [ -t 0 ]; then # argument
    python -mjson.tool <<< "$*" | pygmentize -l javascript
  else # pipe
    python -mjson.tool | pygmentize -l javascript
  fi
}

# Syntax-highlight HTML strings or files
# Usage: `html '<h1>Hello</h1>'` or `echo '<h1>Hello</h1>' | html`
function html() {
  if [ -t 0 ]; then # argument
    pygmentize -f terminal "$0"
  else # pipe
    pygmentize -f terminal "$1"
  fi
}

# kill whatever is LISTENing on a given port, e.g. killport 9200. (killport 9200 -9 if you want to be ugly)
function killport() {
  local port=$1
  shift 1
  lsof -i :$port | grep LISTEN | awk '{print $2}' | xargs kill $@
}

# kill whatever is connected to a given port, servers, clients, whatever. (nukeport 9200 -9 if you want to be ugly)
function nukeport() {
  local port=$1
  shift 1
  lsof -i :$port -Fp | cut -dp -f2 | xargs kill $@
}
