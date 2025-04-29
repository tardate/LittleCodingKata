use gtk4 as gtk;
use gtk::prelude::*;
use gtk::Application;


fn build_ui(app: &gtk::Application) {
    let glade_src = include_str!("../layout.glade");
    let builder = gtk::Builder::from_string(glade_src);

    let window: gtk::Window = builder.object("applicationwindow1").unwrap();
    window.set_application(Some(app));

    // Inputs
    let message_input: gtk::Entry = builder.object("message_input").unwrap();
    let is_dead_switch: gtk::Switch = builder.object("is_dead_switch").unwrap();

    // Submit button
    let button: gtk::Button = builder.object("generate_btn").unwrap();

    // Outputs
    let message_output: gtk::Label = builder.object("message_output").unwrap();
    let image_output: gtk::Image = builder.object("image_output").unwrap();
    let image_output_clone = image_output.clone();

    button.connect_clicked(move |_| {
        message_output.set_text(&format!(
            "{}\n     \\\n      \\",
            message_input.text().as_str()
        ));

        let is_dead = is_dead_switch.is_active();
        if is_dead {
            image_output_clone.set_from_file(Some("./images/cat_dead.png"))
        } else {
            image_output_clone.set_from_file(Some("./images/cat.png"))
        }
        image_output_clone.set_size_request(200, 289);
        image_output_clone.show();
    });

    window.present();
    image_output.hide();
}

fn main() {
    let application = Application::builder()
        .application_id("lck.gui.catsay")
        .build();

    application.connect_activate(|app| {
        build_ui(app);
    });

    application.run();
}
