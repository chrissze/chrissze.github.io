#!/usr/bin/env python3

"""
1. A full path nix command mgiht call other short path nix commands, like  ~/.nix-profile/bin/nix-env might call other non full path nix-env commands, so I have to expand PATH variable so that subprocess can locate those triggered commands. $HOME does not work in the PATH variable in this module, I have to use ~.


"""


from ansible.module_utils.basic import AnsibleModule
import subprocess
import os


def get_full_path(nix_cmd: str) -> str:
    
    if os.path.exists(os.path.expanduser(f"~/.nix-profile/bin/{nix_cmd}")):
        return os.path.expanduser(f"~/.nix-profile/bin/{nix_cmd}")
    
    if os.path.exists(f"/nix/var/nix/profiles/default/bin/{nix_cmd}"):
        return f"/nix/var/nix/profiles/default/bin/{nix_cmd}"
    
    return nix_cmd



def run_module():
    module_args = dict(
        allow_unfree=dict(type='bool', default=False),

        update_cache=dict(type='bool', default=False),
        
        upgrade=dict(type='bool', default=False),
        
        name=dict(type='list', elements='str', default=[]),
        state=dict(type='str', default='present', choices=['present', 'absent']),
        repo=dict(type='str', default='nixpkgs'),
        
        collect_garbage=dict(type='bool', default=False),
        
        list_packages=dict(type='bool', default=False),
        
        list_generations=dict(type='bool', default=False),

    )

    module = AnsibleModule(argument_spec=module_args, supports_check_mode=True)


    # FIELDS

    allow_unfree = module.params['allow_unfree']
    
    update_cache = module.params['update_cache']
    
    upgrade = module.params['upgrade']

    names = module.params['name']
    if isinstance(names, str):
        names = [names]
    state = module.params['state']
    repo = module.params['repo']

    collect_garbage = module.params['collect_garbage']

    list_packages = module.params['list_packages']

    list_generations = module.params['list_generations']

    # VARIABLES

    changed = False
    
    all_stdout = []
    
    all_stderr = []

    nix_channel_cmd: str = get_full_path('nix-channel')

    nix_env_cmd: str = get_full_path('nix-env')

    nix_collect_garbage_cmd: str = get_full_path('nix-collect-garbage')

    # Use ~, do not use $HOME
    env = os.environ.copy()
    env["PATH"] = "/nix/var/nix/profiles/default/bin:~/.nix-profile/bin:" + env.get("PATH", "")


    # Enable allowUnfree BEFORE names for loop.
    if allow_unfree:
        env['NIXPKGS_ALLOW_UNFREE'] = '1'


    # Update cache if requested, place this BEFORE upgrade and names.
    if update_cache or upgrade:
        try:
            update_command = [nix_channel_cmd, '--update']
            result = subprocess.run(update_command, check=True, capture_output=True, text=True)
            all_stdout.append(result.stdout)
            all_stderr.append(result.stderr)
        except subprocess.CalledProcessError as e:
            module.fail_json(msg=f"Cache update failed: {e}", stdout=e.stdout, stderr=e.stderr)


    if upgrade:
        try:
            command = [nix_env_cmd, '-u']
            result = subprocess.run(command, check=True, capture_output=True, text=True, env=env)
            changed = True
            all_stdout.append(result.stdout)
            all_stderr.append(result.stderr)
        except subprocess.CalledProcessError as e:
            module.fail_json(msg=f"Failed to upgrade packages: {e}", stdout=e.stdout, stderr=e.stderr)


    for name in names:
        if state == 'present':
            command = [nix_env_cmd, '-iA', f'{repo}.{name}']
        elif state == 'absent':
            command = [nix_env_cmd, '-e', name]

        try:
            result = subprocess.run(command, check=True, capture_output=True, text=True, env=env)
            changed = True
            all_stdout.append(result.stdout)
            all_stderr.append(result.stderr)
        except subprocess.CalledProcessError as e:
            module.fail_json(msg=f"Failed to manage package {name}: {e}", stdout=e.stdout, stderr=e.stderr)


    if collect_garbage:
        try:
            command = [nix_collect_garbage_cmd, '-d']
            result = subprocess.run(command, check=True, capture_output=True, text=True, env=env)
            all_stdout.append(result.stdout)
            all_stderr.append(result.stderr)
        except subprocess.CalledProcessError as e:
            module.fail_json(msg=f"Failed to list packages: {e}", stdout=e.stdout, stderr=e.stderr)


    if list_packages:
        try:
            command = [nix_env_cmd, '-q']
            result = subprocess.run(command, check=True, capture_output=True, text=True, env=env)
            all_stdout.append(result.stdout)
            all_stderr.append(result.stderr)
        except subprocess.CalledProcessError as e:
            module.fail_json(msg=f"Failed to list packages: {e}", stdout=e.stdout, stderr=e.stderr)


    if list_generations:
        try:
            command = [nix_env_cmd, '--list-generations']
            result = subprocess.run(command, check=True, capture_output=True, text=True, env=env)
            all_stdout.append(result.stdout)
            all_stderr.append(result.stderr)
        except subprocess.CalledProcessError as e:
            module.fail_json(msg=f"Failed to list packages: {e}", stdout=e.stdout, stderr=e.stderr)



    # Put the exit at the very end.
    module.exit_json(changed=changed, stdout='\n'.join(all_stdout), stderr='\n'.join(all_stderr))


def main():
    run_module()

if __name__ == '__main__':
    main()
