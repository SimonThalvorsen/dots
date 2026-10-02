function lint --wraps='cfengine lint (find ./masterfiles/ ./core -type d -name "*test*" -prune -o -type f -name "*.cf" -print) --strict=yes'
    cfengine lint (find $argv -type d -name "*test*" -prune -o -type f -name "*.cf" -print) --strict=yes
end
