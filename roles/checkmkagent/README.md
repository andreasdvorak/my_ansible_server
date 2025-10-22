# Configuration of the checkmk agent

Individual program call instead of agent access

ssh -p PORT monitoring@client_fqdn sudo check_mk_agent

Private ssh key ist here:

/omd/sites/sitename/.ssh

## Variables

put these variables e.g. in the file ../host_vars/FQDN-HOSTNAME or ../group_vars/all

    checkmk_version: ''
    checkmk_agent_user: ''
    checkmk_agent_public_key_source: '' # path and file name to local key file