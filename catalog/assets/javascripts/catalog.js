(function() {
  var root;

  root = typeof exports !== "undefined" && exports !== null ? exports : this;

  root.CatalogController = (function() {
    function CatalogController(catalog_table) {
      this.catalog_table = catalog_table;
      this.loadCatalog();
      this.hookActions();
      this.github_base_url = 'https://github.com/tardate/LittleCodingKata/blob/master/';
      this.pages_base_url = 'https://codingkata.tardate.com/';
    }

    CatalogController.prototype.hookActions = function() {
      $('body').on('click', '[data-url]', function(e) {
        var url, target;
        e.preventDefault();
        url = $(e.target).parents('[data-url]').data('url');
        if (url) location.href = url;
        return false;
      });
    };

    CatalogController.prototype.loadCatalog = function() {
      var instance;
      instance = this;
      return this.catalog_table.DataTable({
        autoWidth: false,
        ajax: {
          url: './catalog/catalog.json',
          dataSrc: ''
        },
        columns: [
          {
            data: 'name'
          }, {
            data: 'description',
            visible: false
          }, {
            data: 'categories',
            visible: false
          },
        ],
        order: [[0, "asc"]],
        rowCallback: function(row, data, index) {
          var base_name;
          var id_link, id_cell;
          var description, hero_image_url, category_array, category_labels;

          category_array = data.categories.split(',');

          base_name = data.relative_path.split('/').pop();
          project_url = instance.github_base_url + data.relative_path
          hero_image_url = project_url + '/assets/' + base_name + '_build.jpg';

          category_labels = '';
          for (var cat = 0; cat < category_array.length; cat++) {
            category_labels += '<span class="label label-primary">' + category_array[cat] + '</span> ';
          }

          description = '<div class="media"> \
            <div class="media-body"> \
              <div class="pull-right"> \
                <div>' + category_labels + '</div>  \
              </div> \
              <h4 class="media-heading">' + data.name + '</h4> \
              <div class="text-muted">' + data.description + '</div> \
            </div> \
          </div>';

          cell = $('td:eq(0)', row)
          cell.addClass('xleap-link')
          cell.attr('data-url', project_url)
          cell.html(description);
          return cell
        }
      });
    };

    return CatalogController;

  })();

  jQuery(function() {
    return new root.CatalogController($('#catalog-table'));
  });

}).call(this);
