#!/usr/bin/env python3


from ansible.module_utils.basic import AnsibleModule
import subprocess
import os


def run_module():
    module_args = dict(
        name=dict(type='list', elements='str', default=[]),
        repo=dict(type='str', default='nixpkgs'),
        state=dict(type='str', default='present', choices=['present', 'absent']),
        update_cache=dict(type='bool', default=False),
        allow_unfree=dict(type='bool', default=False),
        upgrade=dict(type='bool', default=False),
        list_packages=dict(type='bool', default=False)

    )

    module = AnsibleModule(argument_spec=module_args, supports_check_mode=True)

    names = module.params['name']
    if isinstance(names, str):
        names = [names]

    repo = module.params['repo']
    state = module.params['state']
    update_cache = module.params['update_cache']
    allow_unfree = module.params['allow_unfree']
    upgrade = module.params['upgrade']
    list_packages = module.params['list_packages']

    changed = False
    all_stdout = []
    all_stderr = []
    env = os.environ.copy()

    # Enable allowUnfree BEFORE names for loop.
    if allow_unfree:
        try:
            env['NIXPKGS_ALLOW_UNFREE'] = '1'
        except subprocess.CalledProcessError as e:
            module.fail_json(msg=f"Failed to set allowUnfree: {e}", stdout=e.stdout, stderr=e.stderr)


    # Update cache if requested, place this BEFORE upgrade and names.
    if update_cache or upgrade:
        try:
            update_command = ['nix-channel', '--update']
            result = subprocess.run(update_command, check=True, capture_output=True, text=True)
            all_stdout.append(result.stdout)
            all_stderr.append(result.stderr)
        except subprocess.CalledProcessError as e:
            module.fail_json(msg=f"Cache update failed: {e}", stdout=e.stdout, stderr=e.stderr)


    if upgrade:
        try:
            command = ['nix-env', '-u']
            result = subprocess.run(command, check=True, capture_output=True, text=True, env=env)
            changed = True
            all_stdout.append(result.stdout)
            all_stderr.append(result.stderr)
        except subprocess.CalledProcessError as e:
            module.fail_json(msg=f"Failed to upgrade packages: {e}", stdout=e.stdout, stderr=e.stderr)


    for name in names:
        if state == 'present':
            command = ['nix-env', '-iA', f'{repo}.{name}']
        elif state == 'absent':
            command = ['nix-env', '-e', name]

        try:
            result = subprocess.run(command, check=True, capture_output=True, text=True, env=env)
            changed = True
            all_stdout.append(result.stdout)
            all_stderr.append(result.stderr)
        except subprocess.CalledProcessError as e:
            module.fail_json(msg=f"Failed to manage package {name}: {e}", stdout=e.stdout, stderr=e.stderr)


    if list_packages:
        try:
            command = ['nix-env', '-q']
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
