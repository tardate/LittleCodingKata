# #221 bootstrap

About Bootstrap.

## Notes

### Bootstrap v3 Packaging Options

Official [download and Installation options](https://getbootstrap.com/docs/3.4/getting-started/#download)

* Compiled CSS and JS (direct download or CDN via jsDelivr)
* Source files (LESS) to compile Bootstrap with your own asset pipeline
* Source files ported to SASS to compile Bootstrap with your own asset pipeline
* Package managers
    * bower
    * npm
    * Composer (PHP)
    * bundler: official bootstrap Sass gem (Bootstrap 3)
        * [rubygems](https://rubygems.org/gems/bootstrap-sass)
        * [github](https://github.com/twbs/bootstrap-sass)

Unofficial options:

* less-rails-bootstrap - The less-rails-bootstrap project hooks into less-rails and less.rb, making Bootstrap's source LESS files, compiled CSS, and JavaScript files available in the Rails 3.x and 4.x asset pipeline.
    * [rubygems](https://rubygems.org/gems/less-rails-bootstrap)
    * [github](https://github.com/metaskills/less-rails-bootstrap)

### Bootstrap v4 Packaging Options

Official [download and Installation options](https://getbootstrap.com/docs/4.6/getting-started/download/)

* Compiled CSS and JS (direct download or CDN via jsDelivr)
* Source files (LESS) to compile Bootstrap with your own asset pipeline
* Source files ported to SASS to compile Bootstrap with your own asset pipeline
* Package managers
    * npm
    * yarn
    * Composer (PHP)
    * NuGet (.NET)
    * bundler: official bootstrap Sass gem (Bootstrap 4)
        * `gem 'bootstrap', '~> 4.6.1'`
        * [rubygems](https://rubygems.org/gems/bootstrap)
        * [github](https://github.com/twbs/bootstrap-rubygem)

### Bootstrap v5 Packaging Options

Official [download and Installation options](https://getbootstrap.com/docs/5.1/getting-started/download/):

* Compiled CSS and JS (direct download or CDN via jsDelivr)
* Source files (SASS) to compile Bootstrap with your own asset pipeline
* Package managers
    * npm
    * yarn
    * Composer (PHP)
    * NuGet (.NET)
    * bundler: official bootstrap gem (Bootstrap 4 and 5)
        * [rubygems](https://rubygems.org/gems/bootstrap)
        * [github](https://github.com/twbs/bootstrap-rubygem)

### Difference between Bootstrap v3 and Bootstrap v4

| Component            | Bootstrap v3 | Bootstrap v4 | Bootstrap v5 |
|----------------------|--------------|--------------|--------------|
| CSS source file      | LESS         | SASS         | SASS |
| CSS  Unit            | px           | rem          | |
| Font Size            | 14px         | 16px         | |
| Grid System          | It is based on 4 tier grid system (xs, sm, md, lg)               | It is based on 5 tier grid system (xs, sm, md, lg, xl) | It has 6 tier (xs, sm, md, lg, xl, xxl). |
| Color                | It has limited colors.                 | It has limited colors. | Extra colors added with the looks, A card improved color palette. there are various shades available to choose. |
| Jquery               | It has jquery and all related plugins. | It has jquery and all related plugins. | Jquery is removed and switched to vanilla JS with some working plugins |
| Internet Explorer    |              | supports both IE 10 and 11 | doesn’t support IE 10 and 11 |
| Form elements        |              | Radio buttons, checkboxes have different look in different OS and browsers. The form uses whatever default browsers provide. | The look of form elements will not change, on different OS or browser. The forms can be customized and form controls can be added, they would not depend on browser.  |
| Utilities API        |              | We cannot modify utilities in bootstrap 4 | Bootstrap 5 gave freedom to modify and also create our own utility |
| Gutter               |              | We use .glutter with fontsize in px | We use .g* with fontsize in rem |
| Vertical Classes     |              | Columns can be positioned relative | Columns cannot be positioned relative |
| Bootstrap Icons      | glyphicons   | doesn’t have its own SVG icons, we have to use font-awesome for icons | have its own SVG icons |
| Panels/Cards         | panels, thumbnails and wells | The card deck is used to create an isset of cards with equal width and height. | Card deck class in removed in bootstrap |
| Static Site Generator|              |uses Jekyll software | uses Hugo software as it is fast static site generator |
| Dropdown Structure   | Created using `<ul>` and `<li>`                                      | Created with `<ul>` or `<div>`                             | |
| Images class         | .img-responsive                                                  | .img-fluid                                             | |
| flexbox grid         |              | this makes easier to implement vertical designs, and the columns and rows can easily be implemented. the classes justify-center-content can directly be used to align according to the requirement | advanced grid system is made available , also columns don’t have relative positions. |
| Tables               | use .table-responsive class in `<div>` tag                         | use .table-responsive class in `<table>` tag             | |
| Offsetting Columns   | col-md-offset-4                                                  | offset-md-4                                            | |
| Form Control Size    | .input-lg increases size while .input-sm decreases size          | .form-control-lg increases size while .form-control-sm decreases size               | |
| Button Sizes         | .btn-xs class is available                                       | .btn-sm and .btn-lg classes are there and the .btn-xs class is not                  | |
| Jumbotron Full Width | .jumbotron-fluid class is not used on full-width jumbotrons      | .jumbotron-fluid class for full-width jumbotrons is used in this                    | It doesn’t support jumbotron. |
| Carousel Item        | carousel items are arranged using .item class                    | It uses .carousel-item class for arranging carousel items.                          | |
| Navbar               |              | We have inline-block property and we will get white dropdown as default for dropdown-menu-dark class. | Inline-block property is removed and we will get black dropdown as default for dropdown-menu-dark class. |
| Inline Navs          | Do not have .nav-inline class                                    | Inline navs are displayed by using the .nav-inline class                            | |
| Styles               | It has .btn-default and .btn-info available classes for buttons  | Have different classes for buttons like: .btn-secondary, .btn-light and . btn-dark. | |
| Checkboxes and Radio Buttons | .radio, .radio-inline, .checkbox, or .checkbox-inline classes are available for radio and checkbox. | .form-check, .form-check-label, .form-check-input, or .form-check-inline are the classes used to display radio and checkbox. | |

## Credits and References

* [getbootstrap](https://getbootstrap.com/)
* [Difference between Bootstrap 3 and Bootstrap 4](https://www.geeksforgeeks.org/what-is-the-difference-between-bootstrap-v3-and-v4)
* [Difference between Bootstrap 4 and Bootstrap 5](https://www.geeksforgeeks.org/difference-between-bootstrap-4-and-bootstrap-5/)
