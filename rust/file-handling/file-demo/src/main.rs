use std::fs;
use std::io::{Write, Read};

fn create_file(filename: &str, content: &str) -> std::io::Result<()> {
    println!("# creating file: {}", filename);
    let mut file = fs::File::create(filename)?;
    file.write_all(content.as_bytes())?;
    Ok(())
}

fn append_to_file(filename: &str, content: &str) -> std::io::Result<()> {
    println!("# appending to file: {}", filename);
    let mut file = fs::OpenOptions::new().append(true).open(filename)?;
    file.write_all(content.as_bytes())?;
    Ok(())
}

fn read_file(filename: &str) -> std::io::Result<String> {
    println!("# reading from file: {}", filename);
    let mut file = fs::File::open(filename)?;
    let mut contents = String::new();
    file.read_to_string(&mut contents)?;
    Ok(contents)
}

fn delete_file(filename: &str) -> std::io::Result<()> {
    println!("# deleting file: {}", filename);
    fs::remove_file(filename)?;
    Ok(())
}

fn main() -> std::io::Result<()> {
    let filename = "example.txt";

    create_file(&filename, "Hello World!\n")?;
    println!("{}", read_file(&filename)?);
    append_to_file(&filename, "Appended content to the file.\n")?;
    println!("{}", read_file(&filename)?);
    delete_file(&filename)?;

    Ok(())
}
