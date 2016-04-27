!function ($) {

    "use strict";

    // PROGRESSBAR CLASS DEFINITION
    // ============================

    var Progressbar = function (element) {
        this.$element = $(element);
    }

    Progressbar.prototype.update = function (value) {
        var $div = this.$element.find('div');
        $div.attr('aria-valuenow', value);
        $div.css('width', value + '%');
        $div.text(value + '%');
    }

    Progressbar.prototype.finish = function () {
        this.update(100);
    }

    Progressbar.prototype.reset = function () {
        this.update(0);
    }

    Progressbar.prototype.run = function (duration) {
        var instance = this;
        var counter = 0;
        var step_ms = Number.parseInt(duration) * 1000 / 100;
        var update_progress = function() {
          setTimeout(function() {
            instance.update(counter);
            if(counter<100) {
              counter++;
              update_progress();
            }
          }, step_ms);
        };
        update_progress();
    }

    // PROGRESSBAR PLUGIN DEFINITION
    // =============================

    $.fn.progressbar = function (option, args) {
        return this.each(function () {
            var $this = $(this),
                data = $this.data('lck.progressbar');

            if (!data) $this.data('lck.progressbar', (data = new Progressbar(this)));
            if (typeof option == 'string') data[option](args);
            if (typeof option == 'number') data.update(option);
        })
    };

    // PROGRESSBAR DATA-API
    // ====================

    $(document).on('click', '[data-toggle="progressbar"]', function (e) {
        var $this = $(this);
        var $target = $($this.data('target'));
        var duration = $this.data('duration'); // in seconds

        e.preventDefault();

        $target.progressbar("run", duration);
    });

}(window.jQuery);