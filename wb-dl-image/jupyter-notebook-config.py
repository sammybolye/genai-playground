c.ServerProxy.servers = {
    '/proxy/8888/': {
        'command': [
            'sh', '-c',
            '/opt/utilities/start-codeserver.sh'
        ],
        'port': 8888,  # The port Code Server is running
        'host': 'localhost',  # The IP address of the Code Server container
        'launcher_entry': {
            'enabled': True,
            'title': 'VS Code Server'
        },
    }
}
