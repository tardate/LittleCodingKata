extern crate cursive;

use cursive::views::TextView;

fn main() {
    let mut siv = cursive::crossterm();
    let cat_text = "{message}
\\
 \\
   /\\_/\\
  ( {eye}.{eye} )
   > ^ <";

    let cat_template = cat_text.replace("{message}", "Meow!");
    let cat_template = cat_template.replace("{eye}", "o");
    siv.add_layer(TextView::new(cat_template));

    siv.run();
}
