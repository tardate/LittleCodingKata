use std::io::{self, Write};
use serde::Deserialize;

pub fn csv_to_list_default(filename: String, writer: Option<&mut dyn Write>) -> io::Result<()>  {
    let mut default_writer;
    let selected_writer: &mut dyn Write = match writer {
        Some(w) => w,
        None => {
            default_writer = io::stdout();
            &mut default_writer
        }
    };
    let mut rdr = csv::Reader::from_path(filename).expect("Cannot open file");
    writeln!(selected_writer, "`")?;
    for result in rdr.records() {
        let record = result.expect("Error reading record");
        writeln!(selected_writer, "- {}, age {}, from {}", record.get(0).unwrap_or(""), record.get(1).unwrap_or(""), record.get(2).unwrap_or(""))?;
    }
    writeln!(selected_writer, "`")?;
    Ok(())
}

#[derive(Debug, Deserialize)]
struct PersonRecord {
    name: String,
    age: u8,
    city: String,
}

pub fn csv_to_list_serde(filename: String, writer: Option<&mut dyn Write>) -> io::Result<()>  {
    let mut default_writer;
    let selected_writer: &mut dyn Write = match writer {
        Some(w) => w,
        None => {
            default_writer = io::stdout();
            &mut default_writer
        }
    };
    let mut rdr = csv::Reader::from_path(filename).expect("Cannot open file");
    writeln!(selected_writer, "`")?;
    for result in rdr.deserialize::<PersonRecord>() {
        let record = result.expect("Error reading record");
        writeln!(selected_writer, "- {}, age {}, from {}", record.name, record.age, record.city).expect("Error writing record");
    }
    writeln!(selected_writer, "`")?;
    Ok(())
}

#[cfg(test)]
mod tests {
    use super::*;
    use std::io::Cursor;
    use std::str;

    #[test]
    fn test_csv_to_list_default() {
        let mut buffer = Cursor::new(Vec::new());
        let result = csv_to_list_default("../data_eg1.csv".to_string(), Some(&mut buffer));

        assert!(result.is_ok());
        let output_bytes = buffer.into_inner();
        let captured_output = str::from_utf8(&output_bytes).expect("Output was not valid UTF-8");
        let captured_lines: Vec<&str> = captured_output.trim().lines().collect();
        assert_eq!(captured_lines.len(), 4);
        assert_eq!(captured_lines[0], "`");
        assert_eq!(captured_lines[1], "- Ryu, Mi-yeong, age 30, from Seoul");
        assert_eq!(captured_lines[2], "- Zoey, age 24, from Burbank");
        assert_eq!(captured_lines[3], "`");
    }

    #[test]
    fn test_csv_to_list_serde() {
        let mut buffer = Cursor::new(Vec::new());
        let result = csv_to_list_serde("../data_eg1.csv".to_string(), Some(&mut buffer));

        assert!(result.is_ok());
        let output_bytes = buffer.into_inner();
        let captured_output = str::from_utf8(&output_bytes).expect("Output was not valid UTF-8");
        let captured_lines: Vec<&str> = captured_output.trim().lines().collect();
        assert_eq!(captured_lines.len(), 4);
        assert_eq!(captured_lines[0], "`");
        assert_eq!(captured_lines[1], "- Ryu, Mi-yeong, age 30, from Seoul");
        assert_eq!(captured_lines[2], "- Zoey, age 24, from Burbank");
        assert_eq!(captured_lines[3], "`");
    }
}
