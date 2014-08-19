var request = require('request');
var express = require('express');

var app = express();


app.get('/routes', function(req, res){
	var busURL = 'http://mbus.doublemap.com/map/v2/routes';

	request(busURL, function(err, resp, body){
		var obj = JSON.parse(body);

		for(var i in obj){
			obj[i].path = "";
			obj[i].schedule="";
			obj[i].description="";
		}
		res.header('Access-Control-Allow-Origin', '*');	
		res.send(obj);
	})

})


app.get('/stops', function(req, res){
	var routeURL = 'http://mbus.doublemap.com/map/v2/routes';
	var stopURL = 'http://mbus.doublemap.com/map/v2/stops';

	var activeStops = [];

	request(routeURL, function(err, resp, body){
		var obj = JSON.parse(body);

		for(var i in obj){
			obj[i].path = "";
			obj[i].schedule="";
			obj[i].description="";

			for(var x in obj[i].stops){
				activeStops.push(obj[i].stops[x])
			}

		}


		request(stopURL, function(err, resp, body){
			var obj = JSON.parse(body);

			for(var i in obj){
				if(activeStops.indexOf(obj[i].id) != -1){
					obj[i].active = true;
				}

				else obj[i].active = false;
			}

			res.header('Access-Control-Allow-Origin', '*');
			res.send(obj);
		})


		
	})	

})



app.get('/eta/stop=:id', function(req, res){
	var id = req.params.id;

	var url = 'http://mbus.doublemap.com/map/v2/eta?stop='+id;

	request(url, function(err, resp, body){
		res.header('Access-Control-Allow-Origin', '*');
		res.send(body);
	})

	//req.pipe(request(url)).pipe(res)
})





app.get('*', function(req, res){
	res.send('Hello World');
})

console.log('Running on port 8001');
app.listen(8001);
