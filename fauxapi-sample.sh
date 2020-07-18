#!/bin/bash
# 
# Copyright 2017-2020 Nicholas de Jong  <contact[at]nicholasdejong.com>
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# 

# path to "sources" include path
fauxapi_sources="$(realpath $(dirname ${0}))/sources"

# include source library
source "${fauxapi_sources}/pfsense-fauxapi.sh"

# check args exist
if [ -z ${1} ] || [ -z ${2} ] || [ -z ${3} ]; then
    echo ''
    echo 'usage: '$(basename ${0})' <host> <apikey> <apisecret>'
    echo ''
    echo 'Use together with jq for easy pretty print output:-'
    echo '  '$(basename ${0})' <host> <apikey> <apisecret> | jq .'
    echo ''
    echo ''
    exit 1
fi

# config
fauxapi_host=${1}
fauxapi_apikey=${2}
fauxapi_apisecret=${3}

# establish the debug and auth then export
export fauxapi_debug=FALSE
export fauxapi_auth=$(fauxapi_auth ${fauxapi_apikey} ${fauxapi_apisecret})


# config_get
system_config=$(fauxapi_config_get ${fauxapi_host})

# make the output look pretty if jq is available on this system
if [[ $(which jq | wc -l) -gt 0 ]]; then
    echo "${system_config}" | jq .data.config
else
    echo "${system_config}"
fi

# config_get - and write the config to file /tmp/pfsense-fauxapi.json
# NB: must have the 'jq' binary to process the JSON response easily!
#fauxapi_config_get ${fauxapi_host} | jq .data.config > /tmp/pfsense-fauxapi.json

# config_set - set the config from file /tmp/pfsense-fauxapi.json
#fauxapi_config_set ${fauxapi_host} /tmp/pfsense-fauxapi.json

# config_reload
#fauxapi_config_reload ${fauxapi_host}

# config_backup
#fauxapi_config_backup ${fauxapi_host}

# config_backup_list
#fauxapi_config_backup_list ${fauxapi_host}

# config_restore
#fauxapi_config_restore ${fauxapi_host} /cf/conf/backup/config-1503920085.xml

# fauxapi_system_stats
#fauxapi_system_stats ${fauxapi_host}

# fauxapi_interface_stats - NB: the real interface name, not an alias such as "wan"
#fauxapi_interface_stats ${fauxapi_host} em0

# gateway_status
#fauxapi_gateway_status ${fauxapi_host}

# send_event - filter reload
#fauxapi_send_event ${fauxapi_host} '["filter reload"]'

# send_event - interface all reload
#fauxapi_send_event ${fauxapi_host} '["interface all reload"]'

# rule_get - get all rules
#fauxapi_rule_get ${fauxapi_host}

# rule_get - get rule number 5
#fauxapi_rule_get ${fauxapi_host} 5

# alias_update_urltables - reload all urltables
#fauxapi_alias_update_urltables ${fauxapi_host}

# system_reboot - reboot the system
#fauxapi_system_reboot ${fauxapi_host}

# function_call - examples
#fauxapi_function_call ${fauxapi_host} '{"function": "return_gateways_status", "args": [false]}'
#fauxapi_function_call ${fauxapi_host} '{"function": "discover_last_backup"}'
#fauxapi_function_call ${fauxapi_host} '{"function": "return_gateways_status", "includes": ["gwlb.inc"]}'
#fauxapi_function_call ${fauxapi_host} '{"function": "return_gateways_status_text", "args": [true, false]}'
#fauxapi_function_call ${fauxapi_host} '{"function": "get_carp_status"}'
#fauxapi_function_call ${fauxapi_host} '{"function": "get_dns_servers"}'
#fauxapi_function_call ${fauxapi_host} '{"function": "get_system_pkg_version"}'
#fauxapi_function_call ${fauxapi_host} '{"function": "pkg_list_repos"}'
#fauxapi_function_call ${fauxapi_host} '{"function": "get_services"}'
#fauxapi_function_call ${fauxapi_host} '{"function": "get_service_status", "args": ["ntpd"]}'
#fauxapi_function_call ${fauxapi_host} '{"function": "is_service_enabled", "args": ["ntpd"]}'
#fauxapi_function_call ${fauxapi_host} '{"function": "is_service_running", "args": ["ntpd"]}'
