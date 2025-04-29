use gtk4 as gtk;
use gtk::prelude::*;
use gtk::{glib, Application, ApplicationWindow, Box, Image, Label};

fn main() -> glib::ExitCode {
    let app = Application::builder()
        .application_id("org.example.HelloWorld")
        .build();

    app.connect_activate(|app| {
        // We create the main window.
        let window = ApplicationWindow::builder()
            .application(app)
            .default_width(320)
            .default_height(200)
            .title("Hello, World!")
            .build();

        // Create a vertical box layout.
        let vbox = Box::new(gtk::Orientation::Vertical, 0);

        // Add a message label
        let label = Label::new(Some("Meow!"));
        vbox.append(&label);

        // Load the image from the file and display it in the window.
        if let Ok(pixbuf) = gdk_pixbuf::Pixbuf::from_file("./images/cat.png") {
            let image = Image::from_pixbuf(Some(&pixbuf));
            image.set_size_request(pixbuf.width(), pixbuf.height());
            vbox.append(&image);
        } else {
            eprintln!("Failed to load image: ./images/cat.png");
        }

        // add the box layout to the window
        window.set_child(Some(&vbox));

        // Show the window.
        window.present();
    });

    app.run()
}
