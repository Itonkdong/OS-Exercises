#!/bin/bash
mkdir .even .odd

# $() = ``
# $(()) =`expr `

for file in `ls`
do
        if [ -d "$file" ]
        then
                continue
        fi
        if [ ! -r "$file" ]
        then
                continue
        fi

        character_count=`wc -c < "$file"`
        if [ $(("$character_count"%2)) -eq 0 ]
        then
          mv "$file" .even
        else
          mv "$file" .odd
         fi
done

mv .even even
mv .odd odd