# PfsenseFauxapi - Shell Interface

A shell client for pfSense-FauxAPI - https://github.com/ndejong/pfsense_fauxapi

### Example
```bash
# import fauxapi client functions from pfsense-fauxapi.sh 
source "sources/pfsense-fauxapi.sh"

# setup some variables
fauxapi_host="<host-address>"
fauxapi_apikey="<fauxapi-apikey>"
fauxapi_apisecret="<fauxapi-apisecret>"

# generate an auth token to use
export fauxapi_auth=$(fauxapi_auth ${fauxapi_apikey} ${fauxapi_apisecret})

# make a pfSnese-FauxAPI call, in this example get the system configuration
system_config=$(fauxapi_config_get ${fauxapi_host})

# output in JSON pretty print using jq
echo "${system_config}" | jq . 
```

It is recommended to review the commented out samples in the provided 
`fauxapi-sample.sh` file that cover all possible FauxAPI calls to gain a better
idea on usage.

