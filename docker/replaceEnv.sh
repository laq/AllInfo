#!/bin/bash

# Adapter script to inject environment variables in parameters of a process call.
# Inteded to be used on a docker file replacing the java proces in this case
# cp replaceEnv.sh java
# export PATH=".:$PATH"


# export PASSWORD="YAAAS!"

echo "Overriding java command"

i=0
ARGS=( "$@" )

function checkVariables {
    # echo "Checking $1 ... vars:"
    # echo $(envsubst --variables "'$1'")
    for v in $(envsubst --variables "'$1'"); do
        if [ -z "${!v}" ]; then
            echo "  Variable: $v is NOT set or empty"
            # exit 1
        else
            echo " Found variable: $v"
        fi
    done
}

echo "Parameters received:"
for (( i=0; i<$#; i++ )); do
    echo "Parameter $i: ${ARGS[$i]}"
    checkVariables "${ARGS[$i]}"
    ARGS[$i]="$( envsubst < <(echo "${ARGS[$i]}") )" # Substitute variables in parameter with env value
done



echo "running command: /bin/java ${ARGS[@]}"
exec /bin/java "${ARGS[@]}" # Call java command with the replaced params. Use exec to replace bash process for the java process.
