#!/bin/bash
cd ../../../

export DECP_HOME=`pwd`

function test {
    file=$1

    echo "$file"
    $DECP_HOME/scripts/makeOCDS_json.sh $DECP_HOME/scripts/jq/ocds/tests/source/$file > result
    diff result $DECP_HOME/scripts/jq/ocds/tests/expectedResult/$file
}

export datetime=2019-01-01T01:01:01+02:00
export dataset_id="5d1a216e6f4441513e89b93e"
export package_uri="https://www.data.gouv.fr/fr/datasets/r/2a84ffc7-7121-48d2-a28f-85d835ed09a4"
export dataset_url="https://www.data.gouv.fr/fr/datasets/$dataset_id"
export ocid_prefix="ocds-78apv2"

echo ""

if [[ -f $DECP_HOME/scripts/jq/ocds/$1 ]]
then
    test=$(basename $1)
    test $test

else
    for test in `ls $DECP_HOME/scripts/jq/ocds/tests/source`
    do
        if [[ ! -d $test ]]
        then
            test $test
        fi
    done
fi
export datetime=
rm result
