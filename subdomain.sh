#!/bin/sh


FILE_PATH="mail"

usage ()
{
    echo "Pour lister les sous domain \"mail.\" ou \"webmail.\" des .bj d'un fichier"
    echo ""
    echo "./subdomain.sh"
    echo "		-h --help pour afficher ce message"
    echo "		--file=/chemin/du/fichier"
    echo ""

}


if [ "$1" = "" ]
then
	usage
	exit
fi

while [ "$1" != "" ]; do
    PARAM=`echo $1 | awk -F= '{print $1}'`
    VALUE=`echo $1 | awk -F= '{print $2}'`
    case $PARAM in
        -h | --help)
            usage
            exit
            ;;
        -f | --file)
            FILE_PATH=$VALUE
            ;;
        *)
            echo "Option  \"$PARAM\" inconnu"
            usage
            exit 1
            ;;
    esac
    shift
done

echo "Les sous domaine commancant par mail."
echo ""
echo ""

grep "://mail"  $FILE_PATH | awk -F: '{ print $2 }' | sed 's/\/\///'


echo ""
echo ""
echo ""
echo ""
echo ""
echo "Les sous domaines commencant par webmail."
grep "://webmail" $FILE_PATH | awk -F: '{ print $2 }' | sed 's/\/\///'
