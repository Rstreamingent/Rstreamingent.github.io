'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "19bd25412400a0673c17346a5d5fa1c2",
"assets/AssetManifest.bin.json": "c9e7c93c3f62baebc6c6700d1615e1a5",
"assets/AssetManifest.json": "e3762728a5e46d4f900f8deacb804ddd",
"assets/assets/icons/facebook.png": "01d7fe99cc6c29a1e0858f11cd0290fe",
"assets/assets/icons/google.png": "94d8a00b46e520820085e1969e2848d7",
"assets/assets/icons/instagram.png": "6d502e87783d611f2d606d55d541e139",
"assets/assets/icons/linkedin.png": "75d2ca104a1903bc305fa6eed718012d",
"assets/assets/icons/Load%2520more-cuate.png": "5a9792273edaad77273cbc9cd75dda15",
"assets/assets/icons/no_internet.png": "158c402e690d1b0a7ea6705581ec3998",
"assets/assets/icons/R-streaming-TEXT-logo.png": "40aab4d162e46b75d43c22cacff2a053",
"assets/assets/icons/RStream.png": "f3077347c11cf5b42b0d2d4381c9965c",
"assets/assets/icons/threads.png": "464b885f6954759036bcf773713f6aba",
"assets/assets/icons/twitter.png": "6352d995b0c2a0f882503daa1d99a2e7",
"assets/assets/icons/WhatsApp%2520Image%25202024-06-02%2520at%252022.49.27_bf67af14.jpg": "87dc71d9a58e1cbf0bf5618e48229b59",
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
"assets/assets/video/video.mp4": "262286c836e0000b7da2172585bcbcbd",
"assets/assets/WebSeries.json": "716cf3e99f71c408c8ad2fc6714a81e3",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "93ced08ff4b55e488ed2209ad874af50",
"assets/lib/aboutus.dart": "09de68806a60aebbe10253f4f21b6aa3",
"assets/lib/Activity.dart": "24f3510a2f8d2846e550fc3419d545c4",
"assets/lib/ApiProvider.dart": "1c5cd0ea12bc4b8b3722e44a234926f1",
"assets/lib/apitrial.dart": "8a34c63f4a05215cd3c476f42643f401",
"assets/lib/auth_page.dart": "768beff44b9ff2cf7638653486ba708a",
"assets/lib/auth_service.dart": "546dd01efa75dc84080bd54a388c024d",
"assets/lib/contact.dart": "c3539f80cd67a56c0a3506108559e550",
"assets/lib/favorites.dart": "cdf63c2e9058a9b8c8ef2c4363d7fb5b",
"assets/lib/favorites_utils.dart": "e44bcbf40d061516cfb37aa8d38a22ba",
"assets/lib/fireAPI.dart": "4ba2c0724af0aba0c9611b948f9dfc59",
"assets/lib/firebase_options.dart": "bbb34000407204ecd21c95ebca0fae37",
"assets/lib/fire_Function.dart": "e08579e9b9b95ea1fcbc9ecbb45f3487",
"assets/lib/google_sign_in.dart": "d41d8cd98f00b204e9800998ecf8427e",
"assets/lib/help.dart": "9fe0683df40b6d18abbf45828802a9a0",
"assets/lib/home.dart": "4976897f1e428ddf913b528f619b8aca",
"assets/lib/images/google.png": "ca2f7db280e9c773e341589a81c15082",
"assets/lib/main.dart": "3fcb32f5655ddd421df64de950c425d3",
"assets/lib/movieInfo.dart": "46c1dde0929ee616b2776fc7c36afa31",
"assets/lib/node.dart": "cd2ba23477aea6e72fddcd704aa96cd6",
"assets/lib/otp.dart": "784d0ee56133da2fba4eec73f3bb8dec",
"assets/lib/phone.dart": "7b3f7479910c0b3fdb52ee35d1b0a463",
"assets/lib/privacypolicy.dart": "763cbc20c57a9a992f62d8469b60f1eb",
"assets/lib/search.dart": "4a934b20596de51386006b507e0625d2",
"assets/lib/settings.dart": "25f5c63be04a0db2831b6d3b9ca27ecd",
"assets/lib/sharedpreferenceutil.dart": "387f54be75535bc82ac5742fc77934e5",
"assets/lib/SplashScreen.dart": "b33e6dc44656e824c307d0da7ff6ee5e",
"assets/lib/stream.dart": "8883a0fc685000788700a70acf77d5c0",
"assets/lib/videoplayer.dart": "425a21fe2f1de1a53885a3cb82291dca",
"assets/lib/watch_history.dart": "a54cc134b682ede52cda9f41fd617b6a",
"assets/NOTICES": "adc8366c50c81b8d1f52ff0d9cc2a9e4",
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
"firebase-messaging-sw.js": "119c9fab4e6f9a6f85ba5ab1f443d757",
"flutter.js": "59a12ab9d00ae8f8096fffc417b6e84f",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "5a8d0c361790de8f1ae0f571ee615cda",
"/": "5a8d0c361790de8f1ae0f571ee615cda",
"main.dart.js": "80eae271d2e1534a342b8c11ad2c42dc",
"manifest.json": "93898acff27fe81646b86868f1286c7d",
"splash/img/dark-1x.png": "84b54a5b99a3c9033b924b88f3692309",
"splash/img/dark-2x.png": "e62d64106bd1f687fdd4b30f5744f10b",
"splash/img/dark-3x.png": "aa2aec4462918b6d23e6279275394f0d",
"splash/img/dark-4x.png": "de660e5156c4bfacdf915922118a7758",
"splash/img/light-1x.png": "84b54a5b99a3c9033b924b88f3692309",
"splash/img/light-2x.png": "e62d64106bd1f687fdd4b30f5744f10b",
"splash/img/light-3x.png": "aa2aec4462918b6d23e6279275394f0d",
"splash/img/light-4x.png": "de660e5156c4bfacdf915922118a7758",
"version.json": "d0c18ab2d2bd44ae1a0efb0ed8a9d340"};
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
