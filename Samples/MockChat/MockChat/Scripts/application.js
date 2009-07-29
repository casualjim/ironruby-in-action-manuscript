$(document).ready(function(){
    $.messagePoller.set({}, function(){});
    $("button[type=submit]").click(function(){
        console.log("in button click");
        var data = $("form").serialize();
        $.post("/chat/add_message", data);
        return false;
    });
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