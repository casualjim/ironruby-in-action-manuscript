var helloWorld = function(){
    this.message = "Hello, World!!!";
};

helloWorld.prototype = {
    print: function(){
        return this.message;
    }
};