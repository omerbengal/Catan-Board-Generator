'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter.js": "f31737fb005cd3a3c6bd9355efd33061",
"assets/assets/sounds/button4.mp3": "24081d080e2ee831f9d76b110659d43a",
"assets/assets/sounds/button.wav": "774e5ae4c2f52bf71be548d99707dab3",
"assets/assets/sounds/button3.mp3": "3219419957b7d03578da90e20d8a7401",
"assets/assets/sounds/button2.wav": "9764c06439a718709ce647a73a28d3d1",
"assets/assets/new/fullBoard2-cropped.png": "10fd3bddfd1a6dbb7ca4075ce5aa1c90",
"assets/assets/new/dice3.png": "58bf237a7b219eac30cf4daedd7d3e48",
"assets/assets/new/fullBoard2-try.png": "039df561833ef86871d8d648cab9a7d7",
"assets/assets/new/expansionFullBoard-bg-removed-and-cropped.png": "8d0f7f488698d88a232418d0c73f76f3",
"assets/assets/new/dice6.png": "fe3d55a6f26110403bf396cd5c4ada72",
"assets/assets/new/expansionFullBoard-original.jpg": "0ef5fc0c0c914826cc9051b0c0111b24",
"assets/assets/new/dice1.png": "39a0e51926b3a7f392cd90acace89d05",
"assets/assets/new/diceIcon.png": "b7cd43b765a42ddbce6b79917fc23c03",
"assets/assets/new/dice5.png": "6cb9a0ad4855d8870480472d8d07e442",
"assets/assets/new/fullBoard2-cropped-and-bg-removed.png": "83bea860011a7b6c48113ff3583c0376",
"assets/assets/new/expansionFullBoard-bg-removed.png": "6be7423ea11eef25e66c11e9a68ef16d",
"assets/assets/new/dice4.png": "d877f96528ddbfd3bad82b2e58571c05",
"assets/assets/new/expansionFullBoard.png": "8936a74e595cf3b121be2ef4906e9afa",
"assets/assets/new/fullBoard2.png": "8f8d838878ba4a05631ba8ef4c8e20bf",
"assets/assets/new/dice2.png": "dcd88919ea165a5ee1dbaf9a09842f22",
"assets/assets/new/fullBoard2-original.png": "cf8ca275dda28b25e4041fe84de51797",
"assets/assets/expansion/board4.jpg": "305a9331e253c7ceac40f91c25841d89",
"assets/assets/expansion/extensionFullBoard-original.jpg": "0ef5fc0c0c914826cc9051b0c0111b24",
"assets/assets/expansion/board1.jpg": "772894292d0e23031534d83d48a3ebdf",
"assets/assets/expansion/extensionFullBoard.png": "8936a74e595cf3b121be2ef4906e9afa",
"assets/assets/expansion/board3.jpg": "d87e5482b8cdc147508c1869b73361f3",
"assets/assets/expansion/extensionFullBoard-bg-removed.png": "6be7423ea11eef25e66c11e9a68ef16d",
"assets/assets/expansion/board2.jpg": "957e541507697a8cb23892122ab31b9e",
"assets/assets/images/fullBoard.png": "f586ee2029f0f03dcc07771d3eb349e4",
"assets/assets/images/Number3.png": "42120065a167925375298ff837ccb5e2",
"assets/assets/images/Number12.png": "af72f626f2aa53e4cb2e604308e32016",
"assets/assets/images/Number6.png": "f82d0141747c5525e9421599c473cda6",
"assets/assets/images/Sheep.png": "00da474357786e4cd04c162374022138",
"assets/assets/images/Desert.png": "4f543decf0936bdfc64f3a83a7343144",
"assets/assets/images/Ore.png": "2d60bd0c6c71969702d51ef0e9442c92",
"assets/assets/images/Numberd.png": "5d3958e097322961811439ac3597f4ba",
"assets/assets/images/Wheat.png": "2be90fbb3b4feee3e4e7a7f0490d437a",
"assets/assets/images/Wood.png": "4b8823867b65f783f22f6d3ad5e3ab5b",
"assets/assets/images/Number5.png": "922c8f1c0e318e457871aea36f2e1ac8",
"assets/assets/images/Number4.png": "c505163f531d947a1a0ad054194450ae",
"assets/assets/images/Number10.png": "efbfe62fc64b7ec03d12cd5159ddd1ec",
"assets/assets/images/Number8.png": "b6c264e2045d5f3f764f8ea0e9b515ca",
"assets/assets/images/Number9.png": "3ecf07a3a44e3132d60be6175bcc38fe",
"assets/assets/images/Number11.png": "f60de5dbc1038d9586923debb9cfb4e5",
"assets/assets/images/Tit.png": "9f314116d5b6aa0bb29b0eeea1c31b1b",
"assets/assets/images/Number2.png": "7e8aa4faa9ae506a610a5bd9f5e902da",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.bin": "d6c12a0eaeafdb89b191822aa4b4be81",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/NOTICES": "6079041bdd99a3fa2074c3d47597efd8",
"assets/AssetManifest.json": "c5813261e373668a0fa7b1325261a3b4",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/AssetManifest.bin.json": "bca6419259870d4992acff96cd3e76bf",
"assets/fonts/MaterialIcons-Regular.otf": "fe9063eb119457cf9379bfeb4ab26d04",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"flutter_bootstrap.js": "65666f2337513bc6d4d6f6e434b94617",
"version.json": "9ec7522e798ed7c71ae759f901cc86c5",
"canvaskit/canvaskit.js": "5fda3f1af7d6433d53b24083e2219fa0",
"canvaskit/skwasm.js": "9fa2ffe90a40d062dd2343c7b84caf01",
"canvaskit/canvaskit.wasm": "1f237a213d7370cf95f443d896176460",
"canvaskit/skwasm.js.symbols": "262f4827a1317abb59d71d6c587a93e2",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"canvaskit/canvaskit.js.symbols": "48c83a2ce573d9692e8d970e288d75f7",
"canvaskit/chromium/canvaskit.js": "87325e67bf77a9b483250e1fb1b54677",
"canvaskit/chromium/canvaskit.wasm": "b1ac05b29c127d86df4bcfbf50dd902a",
"canvaskit/chromium/canvaskit.js.symbols": "a012ed99ccba193cf96bb2643003f6fc",
"canvaskit/skwasm.wasm": "9f0c0c02b82a910d12ce0543ec130e60",
"index.html": "55d54126811044d371baa3436c03cf10",
"/": "55d54126811044d371baa3436c03cf10",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"main.dart.js": "dfdecdf5eab1f0514c33f543bf93d41b",
"manifest.json": "e92f251e99ceb923f731520aeac869b5"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
