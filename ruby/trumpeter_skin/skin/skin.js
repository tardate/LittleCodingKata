(function() {
  var root;

  root = typeof exports !== "undefined" && exports !== null ? exports : this;

  root.CatalogController = (function() {
    function CatalogController(catalog_table) {
      this.catalog_table = catalog_table;
      this.loadCatalog();
      this.hookActions();
      this.external_base_url = 'http://www.trumpeter-china.com';
    }

    CatalogController.prototype.applyFilter = function() {
      var instance;
      instance = this;
      var keyword_contains = $('input#keyword_contains').val();
      if (scale != '') {
        instance.catalog_table.DataTable().search(
          keyword_contains, true, true
        ).draw();
      }

      var scale = $('select#scale_equals', 'form.search').val();
      instance.catalog_table.DataTable().column(1).search(
        scale, false, false
      ).draw();

      var category = $('select#category_equals', 'form.search').val();
      instance.catalog_table.DataTable().column(3).search(
        category, false, false
      ).draw();

    };

    CatalogController.prototype.hookActions = function() {
      var instance;
      instance = this;

      $('input#keyword_contains', 'form.search').on( 'keyup click', function () {
        instance.applyFilter();
      });
      $('select', 'form.search').on( 'change', function () {
        instance.applyFilter();
      });
    };

    CatalogController.prototype.loadCatalog = function() {
      var instance;
      instance = this;

      return instance.catalog_table.DataTable({
        autoWidth: false,
        ajax: {
          url: './cache/product_table.json',
          dataSrc: ''
        },
        columns: [
          {
            data: 'name'
          }, {
            data: 'scale'
          }, {
            data: 'code', visible: false
          },
          {
            data: 'category', visible: false
          },
        ],
        dom: "<'row'<'col-sm-6'l><'col-sm-6'p>>" +
          "<'row'<'col-sm-12'tr>>" +
          "<'row'<'col-sm-5'i><'col-sm-7'p>>",
        order: [[0, 'asc']],
        searching: true,
        initComplete: function(settings, json) {
          instance.applyFilter();
        },
        rowCallback: function(row, data, index) {
          var base_name;
          var cell, main_cell, description_cell;
          var description, category_array, category_labels;

          project_url = instance.external_base_url + data.url;
          local_image_url = 'cache/images/' + data.code + '.jpg';
          product_search_term = ('Trumpeter ' + data.code + ' ' + data.name).replace(' ', '+');
          aliexpress_url = 'https://www.aliexpress.com/wholesale?catId=0&SearchText=' + product_search_term;
          google_url = 'https://www.google.com/search?q=' + product_search_term;
          scalemates_url = 'https://www.scalemates.com/search.php?fkSECTION[]=Kits&q=Trumpeter+' + data.code;

          description = '';

          description_cell = '<div class="row"> \
            <div class="col-md-8 product-media"> \
              <a href="' + project_url + '" target="_blank"> \
                <img class="media-object" src="' + local_image_url + '" alt=""> \
              </a> \
            </div> \
            <div class="col-md-4"> \
              <h4 class="media-heading">' + data.name + '</h4> \
              <div class="text-muted">' + description + '</div> \
              <div> \
                <span class="label label-success">' + data.code + '</span> \
                <span class="label label-primary">' + data.category + '</span> \
              </div>  \
              <br/> \
              <div class="btn-group btn-group-sm" role="group" aria-label="..."> \
                <a href="' + project_url + '" target="_blank" class="btn btn-default"><i class="fa fa-link" aria-hidden="true"></i></a> \
                <a href="' + project_url + '" target="_blank" type="button" class="btn btn-default">Trumpeter</a> \
                <a href="' + scalemates_url + '" target="_blank" type="button" class="btn btn-default">Scalemates</a> \
                <a href="' + aliexpress_url + '" target="_blank" type="button" class="btn btn-default">AliExpress</a> \
                <a href="' + google_url + '" target="_blank" type="button" class="btn btn-default">Google</a> \
              </div> \
            </div> \
          </div>';

          cell = $('td:eq(0)', row)
          cell.attr('data-url', project_url)
          cell.html(description_cell);
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
