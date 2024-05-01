'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "da84445bf7f822bedf7201238d4b5b3b",
"assets/AssetManifest.bin.json": "6e771afc2f05d0e0b9b7fef59c9eb232",
"assets/AssetManifest.json": "cce6b34ac49837ab433e63bd6bd82ab3",
"assets/assets/icons/facebook.png": "01d7fe99cc6c29a1e0858f11cd0290fe",
"assets/assets/icons/google.png": "94d8a00b46e520820085e1969e2848d7",
"assets/assets/icons/instagram.png": "6d502e87783d611f2d606d55d541e139",
"assets/assets/icons/linkedin.png": "75d2ca104a1903bc305fa6eed718012d",
"assets/assets/icons/R-streaming-TEXT-logo.png": "40aab4d162e46b75d43c22cacff2a053",
"assets/assets/icons/RStream.png": "f3077347c11cf5b42b0d2d4381c9965c",
"assets/assets/icons/threads.png": "464b885f6954759036bcf773713f6aba",
"assets/assets/icons/twitter.png": "6352d995b0c2a0f882503daa1d99a2e7",
"assets/assets/icons/whatsapp.png": "ec69d1fab1d1b2bd76ab53aab8e982e2",
"assets/assets/img1.png": "64f5018be19f96d65c8874c69843302c",
"assets/assets/movies.json": "55d8c518286bc77828989515c7dc998a",
"assets/assets/Posters/adityaBirhade.jpg": "5962a3c9ddff81f5e9cca59176f548d9",
"assets/assets/Posters/adityaSharma.jpg": "6b6413d40dfb58ff061b781913b55820",
"assets/assets/Posters/Asur2.jpg": "5246ed3a5b2888744a0a0f779db380ee",
"assets/assets/Posters/AvengesEndGame.jpg": "f987be53c660e3f038d4f1e63c8b8749",
"assets/assets/Posters/dabangi.jpg": "3b187d1b7c99e588efaebeb23fe23b4e",
"assets/assets/Posters/gauravNath.jpg": "0af0b8fa2525296d8eb38093865fb7a6",
"assets/assets/Posters/gods.jpg": "7c028e7001de1e4579688ce358af956d",
"assets/assets/Posters/in-searcht.jpg": "dc64003998aa3736645cb26a58cab4c0",
"assets/assets/Posters/IronMan.jpeg": "f6bc7aca05e904d96b1012c894cd367b",
"assets/assets/Posters/jeep.jpg": "a644a9997791aa884ee608538b70e12d",
"assets/assets/Posters/parrot.jpeg": "f816c111b599510a28e9c1a0dae31755",
"assets/assets/Posters/Pavankhind.jpg": "35314b2d66949b9668fa32faa02184cf",
"assets/assets/Posters/pramod.jpg": "b9f83c1a224355f545bb74fdb2053c8a",
"assets/assets/Posters/ramayan.jpg": "16e9c2b9452778fa9746c2e5a6590b31",
"assets/assets/Posters/reindeer.jpg": "415f3ada1dcb5e9d2777e75756e6dcef",
"assets/assets/Posters/Scam1992.jpg": "8416b9938fab7c08cd85671d89d67d39",
"assets/assets/Posters/school%2520certificate%2520ganesh.pdf": "4e32cc9435728981b18397b0e9d43ef9",
"assets/assets/Posters/splash.mp4": "72a4cbe1b68cb5ed68e172fe2eac511e",
"assets/assets/Posters/starry.jpg": "329bab2ece375ade8c2653925ace9e31",
"assets/assets/Posters/URI.jpg": "e09c1402b1cad007856dcfed9c8d25d6",
"assets/assets/Posters/zebra.jpg": "e46e9bd5589cec93e61df73ecd1e8008",
"assets/assets/video/video.mp4": "ad0dbc12ae9a2ac42e46ee98d9d7aeea",
"assets/assets/WebSeries.json": "716cf3e99f71c408c8ad2fc6714a81e3",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "06083de9bf91b977d49b9e71cb9a1a11",
"assets/lib/aboutus.dart": "d73123d6a517b5205d9668c2157542a2",
"assets/lib/Activity.dart": "24f3510a2f8d2846e550fc3419d545c4",
"assets/lib/ApiProvider.dart": "1c5cd0ea12bc4b8b3722e44a234926f1",
"assets/lib/apitrial.dart": "8a34c63f4a05215cd3c476f42643f401",
"assets/lib/auth_page.dart": "768beff44b9ff2cf7638653486ba708a",
"assets/lib/auth_service.dart": "546dd01efa75dc84080bd54a388c024d",
"assets/lib/contact.dart": "f51a3eeebfda68c7f2b7146d304fcb25",
"assets/lib/favorites.dart": "6680c7843ade91938e727960ce48b028",
"assets/lib/favorites_utils.dart": "5da81c28ec1bd7ceb1880509d4d31424",
"assets/lib/firebase_options.dart": "bbb34000407204ecd21c95ebca0fae37",
"assets/lib/fire_Function.dart": "e08579e9b9b95ea1fcbc9ecbb45f3487",
"assets/lib/google_sign_in.dart": "d41d8cd98f00b204e9800998ecf8427e",
"assets/lib/home.dart": "fe83b6c2be05ed1edff9d9ef15c202a5",
"assets/lib/images/google.png": "ca2f7db280e9c773e341589a81c15082",
"assets/lib/main.dart": "9b725a1150b70bf6aec466d84aefe69b",
"assets/lib/movieInfo.dart": "4b59d0aa7a4968e83445e9a935be7423",
"assets/lib/node.dart": "cd2ba23477aea6e72fddcd704aa96cd6",
"assets/lib/otp.dart": "784d0ee56133da2fba4eec73f3bb8dec",
"assets/lib/phone.dart": "7b3f7479910c0b3fdb52ee35d1b0a463",
"assets/lib/privacypolicy.dart": "763cbc20c57a9a992f62d8469b60f1eb",
"assets/lib/search.dart": "4a934b20596de51386006b507e0625d2",
"assets/lib/settings.dart": "34cd9b3eb75bdeb716c8d3cda2bca297",
"assets/lib/sharedpreferenceutil.dart": "464c499c616c4c14b5067eaa68746da8",
"assets/lib/SplashScreen.dart": "a38db83e59acf51079c12fa90e9ba1ab",
"assets/lib/stream.dart": "126cc832f7adab31da115a94a3da7650",
"assets/lib/videoplayer.dart": "e4bf3119926debde5daa9e06e1fa3462",
"assets/lib/watch_history.dart": "d48ffe5d3a13a620765ac13e65f5b6a6",
"assets/NOTICES": "55887fdb0bfa55ed7963db54942cde33",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "89ed8f4e49bcdfc0b5bfc9b24591e347",
"assets/packages/inditrans/assets/inditrans.wasm": "52f317e4c7dc9e3c21c0e2ba08c0ef42",
"assets/shaders/ink_sparkle.frag": "4096b5150bac93c41cbc9b45276bd90f",
"canvaskit/canvaskit.js": "eb8797020acdbdf96a12fb0405582c1b",
"canvaskit/canvaskit.wasm": "73584c1a3367e3eaf757647a8f5c5989",
"canvaskit/chromium/canvaskit.js": "0ae8bbcc58155679458a0f7a00f66873",
"canvaskit/chromium/canvaskit.wasm": "143af6ff368f9cd21c863bfa4274c406",
"canvaskit/skwasm.js": "87063acf45c5e1ab9565dcf06b0c18b8",
"canvaskit/skwasm.wasm": "2fc47c0a0c3c7af8542b601634fe9674",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"favicon.ico": "ee4c48129d14d5d1f05e98881e003266",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "59a12ab9d00ae8f8096fffc417b6e84f",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "f4147ecedda3b9d782f3485f3163effc",
"/": "f4147ecedda3b9d782f3485f3163effc",
"main.dart.js": "cd52b45d02872e1169620922cff7a12b",
"manifest.json": "93898acff27fe81646b86868f1286c7d",
"version.json": "8309c3bcb98dfa31a04b3fbda5568f10"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
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
