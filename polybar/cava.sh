#! /bin/zsh

bar="▁▂▃▄▅▆▇█"
dict="s/;//g;"

# creating "dictionary" to replace char with bar
i=0
while [ $i -lt ${#bar} ]
do
    dict="${dict}s/$i/${bar:$i:1}/g;"
    i=$((i=i+1))
done

# write cava config
config_file="/tmp/polybar_cava_config"
echo "
[input]
method = pipewire
source = $(pactl list sources | grep -C 4 -e ": Monitor of Built-in Audio Analog Stereo" | rg '(Source #)(.*)' -or '$2')
 
[general]
bars = 70
overshoot = 100

[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = 7 
" > $config_file

# read stdout from cava
cava -p $config_file | while read -r line; do
    echo $line | sed $dict
done

