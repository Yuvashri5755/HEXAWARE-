import configparser

def get_connection_string(config_file):
    config = configparser.ConfigParser()
    config.read(config_file)
    return config['database']['connection_string']