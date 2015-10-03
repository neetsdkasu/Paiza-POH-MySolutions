

for x in `sort`; do
    if [[ "$x" == +([a-z]) ]]; then
        echo $x;
    fi;
done
