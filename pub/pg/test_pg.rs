use std::net::{TcpStream, ToSocketAddrs};

fn check_postgresql_connection(host: &str, port: u16) {
    let address = format!("{}:{}", host, port);
    if let Ok(mut addrs) = address.to_socket_addrs() {
        if let Some(socket_addr) = addrs.next() {
            match TcpStream::connect(socket_addr) {
                Ok(_) => println!("Connected to PostgreSQL on {}:{}", host, port),
                Err(e) => println!("Connection failed: {}", e),
            }
        } else {
            println!("No addresses resolved for {}", host);
        }
    } else {
        println!("Failed to resolve {}", host);
    }
}

fn main() {
    check_postgresql_connection("sub.domain.com", 5432);
    check_postgresql_connection("1.2.3.4", 5432);
}
