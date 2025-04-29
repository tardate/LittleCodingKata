extern crate cursive;

use cursive::views::{Dialog, TextView};
use cursive::event::Key;

fn main() {
    let mut siv = cursive::crossterm();
    let cat_text = "
{message}
\\
 \\
   /\\_/\\
  ( {eye}.{eye} )
   > ^ <";

    let cat_template = cat_text.replace("{message}", "Meow!");
    let cat_template = cat_template.replace("{eye}", "o");

    siv.add_layer(
        Dialog::around(TextView::new(cat_template))
            .title("The cat says...")
            .button("OK", |s| s.quit())
    );

    siv.add_global_callback(Key::Esc, |s| s.quit()); // listen for ESC key and quit

    siv.run();
}
