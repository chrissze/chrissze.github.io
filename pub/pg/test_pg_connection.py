"""
This script has no dependency, socket is from the standard library. 
"""


import socket

HOST = "localhost"        # "localhost" / "1.2.3.4" / "sub.domain.com"

PORT = 5432 

def check_postgresql_connection(host, port):
    try:
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
            s.settimeout(5)  
            s.connect((host, port))
            print(f"Successfully connected to PostgreSQL on {host}:{port}")
    except socket.error as e:
        print(f"Failed to connect to PostgreSQL: {e}")


if __name__ == "__main__":
    check_postgresql_connection(HOST, PORT)
