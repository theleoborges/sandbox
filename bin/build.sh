current_dir=$(pwd)
script_dir=$(dirname $0)
bin_path="$current_dir/$script_dir"
rex "$bin_path/../lexer/lexer.rex" --stub
racc -o "$bin_path/../parser/parser.rb" "$bin_path/../parser/grammar.y"