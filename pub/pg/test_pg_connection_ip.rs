use std::net::{TcpStream, SocketAddr};
use std::time::Duration;

const HOST: &str = "1.2.3.4";

const PORT:u16 = 5432; 


fn check_postgresql_connection(host: &str, port: u16) {
    // Construct a proper SocketAddr
    let address = format!("{}:{}", host, port);
    let socket_addr: SocketAddr = address.parse().expect("Invalid address");

    // Try connecting to the PostgreSQL server
    match TcpStream::connect_timeout(&socket_addr, Duration::from_secs(5)) {
        Ok(_) => {
            println!("Successfully connected to PostgreSQL on {}:{}", host, port);
        }
        Err(e) => {
            println!("Failed to connect to PostgreSQL: {}", e);
        }
    }
}

fn main() {
    
    check_postgresql_connection(HOST, PORT);
}
