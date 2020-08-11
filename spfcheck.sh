#!/bin/sh
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'
#echo  "I ${GREEN}love${BLUE} Stack ${NC}You\n"


usage()
{
    echo "Pour vérifier le spf d'un domaine ou un ensemble de domaine regroupé dans un fichier"
    echo ""
    echo "./spfcheck.sh"
    echo "		-h ou  --help pour afficher ce message"
    echo "		-d ou --domain domain.bj"
    echo "		-f ou --file /chemin/du/fichier"
    echo ""

}

checkd() {

	dig $1  +short TXT
}

printhead(){
         echo
#	 echo "${BLUE}Domain${NC}\t\t\t\t\t${GREEN}SPF records${NC}"
	printf '\e[1;34m%-30s\e[m \e[1;32m%-30s\e[m' "Domain" "SPF records"
	echo
}

printSpf(){
	SPF=`checkd $1 | grep "v="`
#	echo "$1\t\t\t\t$SPF"
	printf "%-30s   %-60s\n" "$1" "$SPF"
}

printFileSpf(){
	while IFS= read -r line
	do
	  printSpf $line
	done < "$1"
}

if [ "$1" = "" ]
then
	usage
	exit
else
#while [ "$1" != "" ]; do
#    echo "1 est $1 et 2 est $2"
#    exit
printhead
    case $1 in
        -h | --help)
           usage
            exit
            ;;
        -f | --file)
            printFileSpf $2
            ;;
        -d | --domain)
	    printSpf $2
	    exit 0
            ;;

        *)
            echo "Option  \"$PARAM\" inconnu"
            usage
            exit 1
            ;;
    esac
    shift
fi
#done
