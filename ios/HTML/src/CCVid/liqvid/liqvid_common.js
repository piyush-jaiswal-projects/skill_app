/*
liqvid common javascript code library
(c) Liqvid E-Learning Services Pvt. Ltd. 2014-15
*/
LiqCommon = {
    isUndefined : function(obj) {
        return (typeof obj == 'undefined' || obj== undefined);
    },
    isDefined : function(obj) {
        return !(typeof obj == 'undefined' || obj== undefined);
    },

    trigger: function(obj) {
        var eventName = obj.event;
        var eventData = obj.eventData;
        $(document).trigger(eventName,eventData);
    },

    registerEvent : function(eventName, handlerFoo) {
        $(document).on(eventName,handlerFoo);
    }
};

String.prototype.toProperCase = function () {
    return this.replace(/\w\S*/g, function(txt){return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();});
};

