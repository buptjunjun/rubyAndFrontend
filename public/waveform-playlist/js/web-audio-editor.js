var playlist = WaveformPlaylist.init({
  samplesPerPixel: 256,
  mono: false,
  waveHeight: 100,
  container: document.getElementById("playlist"),
  state: 'cursor',
  colors: {
      waveOutlineColor: '#E0EFF1',
      timeColor: 'grey',
      fadeColor: 'black'
  },
  timescale: true,
  controls: {
    show: true, //whether or not to include the track controls
    width: 300 //width of controls in pixels
  },
  zoomLevels: [256,512, 1024, 2048, 4096,9192,18384]
});

playlist.load([
  {
    "src": "xkf.mp3",
    "name": "Vocals"
  },

]).then(function() {
  //can do stuff with the playlist.
});