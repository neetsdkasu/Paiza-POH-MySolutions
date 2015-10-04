declare -a w
declare -i i

mapfile w

for ((i=${w[0]}; i; i--)) do
    echo "${w[$i]}";
done
