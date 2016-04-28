!function ($) {

    "use strict";

    // PROGRESSBAR CLASS DEFINITION
    // ============================

    var Progressbar = function (element) {
        this.$element = $(element);
        // this.$bar = $(element).find('.progress-bar');
    }

    Progressbar.prototype.update = function (value) {
        var $div = this.$element.find('[role="progressbar"]');
        $div.attr('aria-valuenow', value);
        $div.css('width', value + '%');
        $div.text(value + '%');
    }

    Progressbar.prototype.setTransition = function (value) {
        var $div = this.$element.find('[role="progressbar"]');
        $div.css('transition', value);
    }

    Progressbar.prototype.finish = function () {
        this.update(100);
    }

    Progressbar.prototype.reset = function () {
        this.setTransition('none');
        this.update(0);
    }

    Progressbar.prototype.animateWithTimeouts = function (duration) {
        var instance = this;
        var counter = 0;
        var step_ms = Number.parseInt(duration) * 1000 / 100;
        instance.reset();
        instance.setTransition('width 0.1s ease 0s');
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

    Progressbar.prototype.animateWithJquery = function (duration) {
        var instance = this;
        var counter = 0;
        var duration_ms = Number.parseInt(duration) * 1000 ;

        instance.reset();

        var progress_bar = instance.$element.find('[role="progressbar"]');
        progress_bar.animate({
          width: "100%"
        }, {
          duration: duration_ms,
          easing: 'linear',
          step: function( now, fx ) {
            var current_percent = Math.round(now);
            progress_bar.attr('aria-valuenow', current_percent);
            progress_bar.text(current_percent+ '%');
          },
          complete: function() {
            // do something when the animation is complete
          }
        });

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
        var method = $this.data('method');

        e.preventDefault();

        $target.progressbar(method, duration);
    });

}(window.jQuery);