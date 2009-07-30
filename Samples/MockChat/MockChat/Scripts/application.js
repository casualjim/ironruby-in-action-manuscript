$(document).ready(function(){
    if($("#chat-list").length > 0){
        $.messagePoller.set({}, function(){});

        $('form.ajax-form').ajaxForm();

        $(".subject").editInPlace({
            url: '/chat/change_subject'
        });
    }
});

$.messagePoller = {
    options: {
		url: "/chat",
		delay: 5000,
		target: "#chat-list"
    },
	beatfunction:  function(){
	},
	timeoutobj:  {
		id: -1
	},
    set: function(options, onbeatfunction) {
		if (this.timeoutobj.id > -1) {
			clearTimeout(this.timeoutobj);
		}
        if (options) {
            $.extend(this.options, options);
        }
        if (onbeatfunction) {
            this.beatfunction = onbeatfunction;
        }

		this.timeoutobj.id = setTimeout("$.messagePoller.beat();", this.options.delay);
    },
    beat: function() {
        $(this.options.target).load(this.options.url);
		this.timeoutobj.id = setTimeout("$.messagePoller.beat();", this.options.delay);
        this.beatfunction();
    }
};
