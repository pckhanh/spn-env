#!/bin/bash
#################################################
# Author: Khanh Pham                            #
# Date: 12 Sep 2020                             #
#################################################
#### Get AZURE_CLIENT_ID, AZURE_CLIENT_SECRET in KeyVaul and setup Local Environment.
### Prerequisite
# - Need to login to Azure Subscription which contains KeyVaul !!!
# - Need to allow your SPN to have permisison to retrive key in KeyVaul !!!

### Installation required packages #####
# - azure-cli
# - jq

## Get "Secret Identifier" URLs from your KeyVaul
CLIENT_ID_URL="https://KeyVaulName.vault.azure.net/secrets/AZURE_CLIENT_ID/xxxxxxxxxxxxxxxxx"
SECRET_ID_URL="https://KeyVaulName.vault.azure.net/secrets/AZURE_CLIENT_SECRET/xxxxxxxxxxxxxxxxx"
AZURE_TENANT_ID="https://KeyVaulName.vault.azure.net/secrets/AZURE_TENANT_ID/xxxxxxxxxxxxxxxxx"

AZURE_CLIENT_ID=`az keyvault secret show --id $CLIENT_ID_URL | jq -r '.value'`
AZURE_CLIENT_SECRET=`az keyvault secret show --id $SECRET_ID_URL | jq -r '.value'`
AZURE_TENANT_ID=`az keyvault secret show --id $AZURE_TENANT_ID | jq -r '.value'`

case $1 in
set)
  echo "Setting up SPN Environment"
  export AZURE_CLIENT_ID=$AZURE_CLIENT_ID
  export AZURE_CLIENT_SECRET=$AZURE_CLIENT_SECRET
  export AZURE_TENANT_ID=$AZURE_TENANT_ID
  ;;
unset)
  echo "Unsetting SPN Environment"
  unset AZURE_CLIENT_ID
  unset AZURE_CLIENT_SECRET
  unset AZURE_TENANT_ID
  ;;
*)
  echo "Usage: ./spn-env set"
	echo "Setting environment for AZURE_TENANT_ID, AZURE_CLIENT_ID, AZURE_CLIENT_SECRET"

  echo "Usage: ./spn-env unset"
  echo "Unsetting environment for AZURE_TENANT_ID, AZURE_CLIENT_ID, AZURE_CLIENT_SECRET"
  ;;
esac
