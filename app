#!/bin/bash

## Tarniceriu, Luca, 8
## Albu, David, 2



PS3='Enter your option: '
options=("List older files", "Move files", "Delete files")

select opt in "List older files" "Move files" "Delete files"; do

    case $opt in
        "List older files")
            echo "Find files created before: "
            read date
            
            if [[ "$date" =~ ^(0[1-9])|1[012]/(0[1-9])|([1-3][0-9])/[0-9]{4}$ ]]; then 
                parsed_date=$(date -d "$date" +"%d/%m/%Y")
            elif [[ "$date" =~ ^[0-9]*[[:space:]](zile|luni|ani|saptamani|days|months|years|weeks)$ ]]; then
                echo "am gasit"
            else
                echo "nu am gasit"
            fi
            
#            [ echo $date | grep -E '[1-9]' ] && echo "intre 1 si 9" || echo "altceva"
            ;;
       
#        
#            echo "implement listing of files older than given date"
#            echo "date format can be number of days, weeks, months, years or specific date"
#            echo "date should be parsed using regex"
            
        "Move files")
            echo "implement local file movement, and cloud file movement using git"
            ;;
            
        "Delete files")
            echo "delete files older than 60 days from specific path, every monday at 8pm"
            ;;
        *)
            ;;
    esac    
done
