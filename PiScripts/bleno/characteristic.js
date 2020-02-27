var util = require('util');
var bleno = require('bleno');
var BlenoCharacteristic = bleno.Characteristic;

var fs = require('fs');
var weight = 0;

var CustomCharacteristic = function() {
    CustomCharacteristic.super_.call(this, {
        uuid: 'fd758b93-0bfa-4c52-8af0-85845a74a606',
        properties: ['read', 'write', 'notify'],
    });
    this._value = new Buffer(0);
    this._updateValueCallback = null;
};
util.inherits(CustomCharacteristic, BlenoCharacteristic);
module.exports = CustomCharacteristic;

// read
CustomCharacteristic.prototype.onReadRequest = function (offset, callback) {
    console.log('CustomCharacteristic onReadRequest');
    var data = new Buffer(4);
    getWeight();
    data.writeUInt32BE(weight);
    callback(this.RESULT_SUCCESS, data);
};

// write
CustomCharacteristic.prototype.onWriteRequest = function(data, offset, withoutResponse, callback) {
    this._value = data;
    console.log('CustomCharacteristic - onWriteRequest: value = ' +       this._value.toString('hex'));
    callback(this.RESULT_SUCCESS);
};

//Call python to get weight
getWeight = function(){
	weight = fs.readFileSync('../weightStore.txt', 'utf8');
	console.log(weight);
};
