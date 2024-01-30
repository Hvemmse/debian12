import PySimpleGUI as sg
import subprocess

def install_samba():
    subprocess.run(['sudo', 'apt', 'update'])
    subprocess.run(['sudo', 'apt', 'install', '-y', 'samba'])

def backup_samba_config():
    subprocess.run(['sudo', 'cp', '/etc/samba/smb.conf', '/etc/samba/smb.conf.bak'])

def configure_samba(share_name, share_path, samba_username):
    config_lines = f'''
[{share_name}]
    path = {share_path}
    read only = no
    browseable = yes
    guest ok = yes
'''

    subprocess.run(['sudo', 'bash', '-c', f'echo \'{config_lines}\' >> /etc/samba/smb.conf'])

def restart_samba():
    subprocess.run(['sudo', 'service', 'smbd', 'restart'])

def add_samba_user(samba_username):
    subprocess.run(['sudo', 'smbpasswd', '-a', samba_username])

def main():
    sg.theme('DarkBlue3')

    layout = [
        [sg.Text('Enter your share name:'), sg.InputText(key='share_name')],
        [sg.Text('Enter the path to your shared folder:'), sg.InputText(key='share_path')],
        [sg.Text('Enter the Samba username:'), sg.InputText(key='samba_username')],
        [sg.Button('Setup Samba'), sg.Button('Exit')]
    ]

    window = sg.Window('Samba Setup', layout)

    while True:
        event, values = window.read()

        if event == sg.WIN_CLOSED or event == 'Exit':
            break
        elif event == 'Setup Samba':
            install_samba()
            backup_samba_config()
            configure_samba(values['share_name'], values['share_path'], values['samba_username'])
            restart_samba()
            add_samba_user(values['samba_username'])
            sg.popup('Samba setup completed.', f'Your share is accessible at smb://{subprocess.getoutput("hostname")}/{values["share_name"]}')

    window.close()

if __name__ == '__main__':
    main()
