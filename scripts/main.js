require.config({
  shim: {
  },

 paths: {
    jquery: '../../components/jquery/jquery',

    hm: 'vendor/hm',
    esprima: 'vendor/esprima',
    jquery: 'vendor/jquery.min',
    weather: 'vender/simpleweather.min'
  }
});

 
require(['app'], function(app) {
  // use app here
  console.log(app);
});
