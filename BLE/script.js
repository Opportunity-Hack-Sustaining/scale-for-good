var bleno = require('../..');

var Descriptor = bleno.Descriptor;
var descriptor = new Descriptor({
	uuid: '2901',
	value: 'value'
});

var Characteristic = bleno.Characteristic;
var characteristic = new Characteristic({
	uuid: 'fff1',
	properties: [ 'read', 'write', 'writeWithoutResponse' ],
	value: 'ff',
	descriptors: [ descriptor ]
});

var PrimaryService = bleno.PrimaryService;
var primaryService = new PrimaryService({
	uuid: 'fffffffffffffffffffffffffffffff0',
	characteristics: [ characteristic ]
});

var services = [ primaryService ];
bleno.on('advertisingStart', function(err) {
	bleno.setServices( services );
});

bleno.on( 'stateChange', function(state) {
	console.log('BLE stateChanged to: ' + state);
	if(state === 'poweredOn') {
		bleno.startAdvertising('PiForDays', ['fffffffffffffffffffffffffffffff0']);
	} else {
		bleno.stopAdvertising();
	}
});
