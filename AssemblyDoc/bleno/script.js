var bleno = require('bleno') ;
var BlenoPrimaryService = bleno.PrimaryService;

bleno.on('stateChange', function(state) {
console.log('on -> stateChange: ' + state);
    if (state === 'poweredOn') {
        console.log("request startAdvertising");
        bleno.startAdvertising('Scale For Good', ['27cf08c1-076a-41af-becd-02ed6f6109b9']);
    } else {
        console.log("request stopAdvertising");
        bleno.stopAdvertising();
    }
});

// characteristic
var CustomCharacteristic = require('./characteristic');
bleno.on('advertisingStart', function(error) {
    console.log('on -> advertisingStart: ' + (error ? 'error ' + error : 'success'));
     if (!error) {
        bleno.setServices([
            new BlenoPrimaryService({
                uuid: '27cf08c1-076a-41af-becd-02ed6f6109b9',
                characteristics: [
                    new CustomCharacteristic()
                ]
            })
        ]);
    }
});
