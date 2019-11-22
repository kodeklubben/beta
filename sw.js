importScripts("/precache-manifest.303388bd494faddc17ab87d8e8a9eb00.js", "https://storage.googleapis.com/workbox-cdn/releases/4.3.1/workbox-sw.js");

/* eslint-disable */

workbox.precaching.precacheAndRoute(self.__precacheManifest);

addEventListener('message', event => {
  if (event.data && event.data.type === 'SKIP_WAITING') {
    skipWaiting();
  }
});

