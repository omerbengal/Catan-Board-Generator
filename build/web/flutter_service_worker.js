'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "7afaf845ead813eb9e6908ae513756df",
"version.json": "9ec7522e798ed7c71ae759f901cc86c5",
"index.html": "55d54126811044d371baa3436c03cf10",
"/": "55d54126811044d371baa3436c03cf10",
"main.dart.js": "99dbfd6604e31da8be44cb455ac73e38",
"flutter.js": "4b2350e14c6650ba82871f60906437ea",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "e92f251e99ceb923f731520aeac869b5",
"assets/AssetManifest.json": "bf6649e6a3fbc6001d5f7c306f78dd15",
"assets/NOTICES": "52715c5db94d5c7d2453d3e04d3a1a5d",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.bin.json": "5b5dbd6d985a88747416a0d3e8d70f87",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "1f77a9eb6d721a42ffcade7b0d3a701e",
"assets/fonts/MaterialIcons-Regular.otf": "fe9063eb119457cf9379bfeb4ab26d04",
"assets/assets/images/Desert.png": "4f543decf0936bdfc64f3a83a7343144",
"assets/assets/images/Ore.png": "2d60bd0c6c71969702d51ef0e9442c92",
"assets/assets/images/fullBoard.png": "f586ee2029f0f03dcc07771d3eb349e4",
"assets/assets/images/Wheat.png": "2be90fbb3b4feee3e4e7a7f0490d437a",
"assets/assets/images/Number5.png": "922c8f1c0e318e457871aea36f2e1ac8",
"assets/assets/images/Number4.png": "c505163f531d947a1a0ad054194450ae",
"assets/assets/images/Sheep.png": "00da474357786e4cd04c162374022138",
"assets/assets/images/Number6.png": "f82d0141747c5525e9421599c473cda6",
"assets/assets/images/Number11.png": "f60de5dbc1038d9586923debb9cfb4e5",
"assets/assets/images/Number3.png": "42120065a167925375298ff837ccb5e2",
"assets/assets/images/Numberd.png": "5d3958e097322961811439ac3597f4ba",
"assets/assets/images/Number2.png": "7e8aa4faa9ae506a610a5bd9f5e902da",
"assets/assets/images/Number10.png": "efbfe62fc64b7ec03d12cd5159ddd1ec",
"assets/assets/images/Wood.png": "4b8823867b65f783f22f6d3ad5e3ab5b",
"assets/assets/images/Number12.png": "af72f626f2aa53e4cb2e604308e32016",
"assets/assets/images/Number9.png": "3ecf07a3a44e3132d60be6175bcc38fe",
"assets/assets/images/Number8.png": "b6c264e2045d5f3f764f8ea0e9b515ca",
"assets/assets/images/Tit.png": "9f314116d5b6aa0bb29b0eeea1c31b1b",
"assets/assets/sounds/button3.mp3": "3219419957b7d03578da90e20d8a7401",
"assets/assets/sounds/button4.mp3": "24081d080e2ee831f9d76b110659d43a",
"assets/assets/sounds/button.wav": "774e5ae4c2f52bf71be548d99707dab3",
"assets/assets/sounds/button2.wav": "9764c06439a718709ce647a73a28d3d1",
"assets/assets/expansion/extensionFullBoard.png": "8936a74e595cf3b121be2ef4906e9afa",
"assets/assets/expansion/extensionFullBoard-original.jpg": "0ef5fc0c0c914826cc9051b0c0111b24",
"assets/assets/expansion/board1.jpg": "772894292d0e23031534d83d48a3ebdf",
"assets/assets/expansion/board3.jpg": "d87e5482b8cdc147508c1869b73361f3",
"assets/assets/expansion/board2.jpg": "957e541507697a8cb23892122ab31b9e",
"assets/assets/expansion/extensionFullBoard-bg-removed.png": "6be7423ea11eef25e66c11e9a68ef16d",
"assets/assets/expansion/board4.jpg": "305a9331e253c7ceac40f91c25841d89",
"assets/assets/new/expansionFullBoard-bg-removed.png": "6be7423ea11eef25e66c11e9a68ef16d",
"assets/assets/new/fullBoard2-original.png": "cf8ca275dda28b25e4041fe84de51797",
"assets/assets/new/diceIcon.png": "b7cd43b765a42ddbce6b79917fc23c03",
"assets/assets/new/expansionFullBoard.png": "8936a74e595cf3b121be2ef4906e9afa",
"assets/assets/new/fullBoard2-try.png": "039df561833ef86871d8d648cab9a7d7",
"assets/assets/new/dice1.png": "39a0e51926b3a7f392cd90acace89d05",
"assets/assets/new/expansionFullBoard-original.jpg": "0ef5fc0c0c914826cc9051b0c0111b24",
"assets/assets/new/fullBoard2-cropped.png": "10fd3bddfd1a6dbb7ca4075ce5aa1c90",
"assets/assets/new/dice3.png": "58bf237a7b219eac30cf4daedd7d3e48",
"assets/assets/new/dice2.png": "dcd88919ea165a5ee1dbaf9a09842f22",
"assets/assets/new/expansionFullBoard-bg-removed-and-cropped.png": "8d0f7f488698d88a232418d0c73f76f3",
"assets/assets/new/dice6.png": "fe3d55a6f26110403bf396cd5c4ada72",
"assets/assets/new/fullBoard2.png": "8f8d838878ba4a05631ba8ef4c8e20bf",
"assets/assets/new/dice5.png": "6cb9a0ad4855d8870480472d8d07e442",
"assets/assets/new/dice4.png": "d877f96528ddbfd3bad82b2e58571c05",
"assets/assets/new/fullBoard2-cropped-and-bg-removed.png": "83bea860011a7b6c48113ff3583c0376",
"canvaskit/skwasm.js": "ac0f73826b925320a1e9b0d3fd7da61c",
"canvaskit/skwasm.js.symbols": "96263e00e3c9bd9cd878ead867c04f3c",
"canvaskit/canvaskit.js.symbols": "efc2cd87d1ff6c586b7d4c7083063a40",
"canvaskit/skwasm.wasm": "828c26a0b1cc8eb1adacbdd0c5e8bcfa",
"canvaskit/chromium/canvaskit.js.symbols": "e115ddcfad5f5b98a90e389433606502",
"canvaskit/chromium/canvaskit.js": "b7ba6d908089f706772b2007c37e6da4",
"canvaskit/chromium/canvaskit.wasm": "ea5ab288728f7200f398f60089048b48",
"canvaskit/canvaskit.js": "26eef3024dbc64886b7f48e1b6fb05cf",
"canvaskit/canvaskit.wasm": "e7602c687313cfac5f495c5eac2fb324",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c"};
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
