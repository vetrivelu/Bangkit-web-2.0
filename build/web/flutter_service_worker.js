'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "add_adun.dart": "d7ba395fb4cda4893eb38e5df74ecb6e",
"add_agency.dart": "7d68d85db1966f8eb14ee6c68ba20e37",
"add_ngo.dart": "1936ca448be006b74b0ac12640175206",
"add_post.dart": "66dd02ea2ceb7fd0711cb0264fc75325",
"add_rebuild.dart": "28b297c91785e073832dc7d20fb94a34",
"add_service.dart": "c05a4bbf2453e6f79880a26130e99ad6",
"assets/AssetManifest.json": "859aa5092165bcdad81b90bbd592db18",
"assets/assets/2.png": "ea92f8f31c2971e40521477f6c1d5374",
"assets/assets/3.png": "8174f6b92ab10e77a345cd79623e0626",
"assets/assets/aa.png": "2702b430a58be56d85e8ea0a26c2a379",
"assets/assets/adun.png": "23c5f58776ee96274a10170539214528",
"assets/assets/aid.png": "35eafc35f46536fc85692f7414656136",
"assets/assets/aidgranticon.webp": "281eef51598b3e35f4cde464e3d12d50",
"assets/assets/architect.png": "6c72488cbd3f7bd0b7b630248eda5fd0",
"assets/assets/bina.png": "37e209ffde033b16e3f14777d0e1e099",
"assets/assets/blueDot.png": "3c60f907408537cbad0af5431c05b087",
"assets/assets/crowdfunding.png": "51d582943a00074cbd8286a8da8cc1ea",
"assets/assets/dam.jpeg": "662fdd793e317bcf96955e8ccaea3ed1",
"assets/assets/emergency.png": "f154c30df9b73f36ef6b519adb8c3b20",
"assets/assets/feedback.png": "b077475e183fca42eaef368aae3e7da1",
"assets/assets/flood%25202.png": "ea8b13abb00f621b5c2f03848f4b7a99",
"assets/assets/flood.png": "2f6d2074934dd2ef0ff47adb4a864788",
"assets/assets/floodarea.png": "1b39d16a4045b415bde2883db8c18ff3",
"assets/assets/FloodIcon.png": "4fb24bd340b6951299a913e4fd234dfe",
"assets/assets/floodMarker%2520(1).png": "63cd8fccdecf2f1e3f48b0b7591c8bf2",
"assets/assets/floodMarker.png": "ad95a735f2f62a2a4bf64a1990ef54a8",
"assets/assets/floodrelief.png": "c7759388b88d20d8411901ced7138fca",
"assets/assets/healthcare.png": "44f31b5ae9d8e4b69e3c094526d244a1",
"assets/assets/logo%2520option%2520eclipse%2520(1).png": "1262cdc371549860d3c4e5d32d7c36d1",
"assets/assets/logo%2520option%2520square%2520(1).jpg": "b9326b22afd61b37dfd67c1c46cb49da",
"assets/assets/logo%2520option%2520square%2520transparent%2520(1).png": "e80bee9c4ee2fa827571f0c002c235cf",
"assets/assets/malasian%2520flood.png": "8b45ba6219e85bc014e1e8c3babf9795",
"assets/assets/man%2520(1).png": "c9ac9c1a4b7b76db5e8a3764c869a782",
"assets/assets/man%2520(2).png": "bdd9aaee8c129b1d0a7180512c6f7ae5",
"assets/assets/man.png": "dc5161dd5e36744d184e0b98e97d31ba",
"assets/assets/network.png": "76872bfcea7cfbdaf93664c4c4a947f3",
"assets/assets/ngologo.png": "787407bcfa2a3e27f0d8ec1b72b9ec90",
"assets/assets/physical-abuse.png": "a2e802d8116c2e8d466e3037ba6b5018",
"assets/assets/play.jpeg": "33dce59b34e9452053d08314fd431322",
"assets/assets/play.jpg": "ca7f5c9038b3b2c029284c78c8e016d2",
"assets/assets/play.png": "fc4feaca9db14611d8a7ab0d8782e8a1",
"assets/assets/police.png": "d52b63174760730b9ce8623b11d20e89",
"assets/assets/policeman.png": "5b1c83556723a27cdfa8dc5d759f000a",
"assets/assets/politician.png": "a4b9c291d445aa5cee37a49e207c6b52",
"assets/assets/pond.png": "56fe3a786adcc9a56709275a3171f422",
"assets/assets/PondIcon.png": "98378fccb440f2feea1b7aea01ee2e65",
"assets/assets/poor.png": "5e5b4271a3d04c9990be4864758f9f6c",
"assets/assets/Rebuild.png": "6f5be7c2f493688be5346e29dcbb2eed",
"assets/assets/red_wavy_with_halftone_background.jpg": "ab008829df7e7cfb1cce689177255d23",
"assets/assets/reserve.png": "dd92148806da71c4942ee07a6dc3edfb",
"assets/assets/ReserveIcon.png": "cd2cd5de8fbdfaad87a7580479e01b91",
"assets/assets/reserveMArker.png": "bb60912efe2ceea97b13a2db676c089f",
"assets/assets/saving.png": "0d66b40c4911eb6f432e6ddf1c34f42e",
"assets/assets/Screenshot_20220102-230458_myCuaca.jpg": "b958da03a13b28a7b9267b4be6fa6774",
"assets/assets/Subscribe%2520-%252041554.mp4": "9e0fa48ef8274f255c44ad2372b5e60f",
"assets/assets/teams_1.4.00.26453_amd64.deb": "0b3446fbcce9cf3bfd8d982937238c62",
"assets/assets/volunteer.png": "bcc46cfbb20dafe751ca5e6c99c17ccb",
"assets/assets/weather.png": "083a9cfad6f7c5876cf5b6c165bba1bd",
"assets/assets/WhatsApp%2520Image%25202022-01-04%2520at%25201.43.34%2520PM.jpeg": "f9c0f2a1f8e8918fb7707913b13fa775",
"assets/FontManifest.json": "5a32d4310a6f5d9a6b651e75ba0d7372",
"assets/fonts/MaterialIcons-Regular.otf": "7e7a6cccddf6d7b20012a548461d5d81",
"assets/NOTICES": "c2084f957686b76bee04e5b58d640acc",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/packages/flutter_inappwebview/t_rex_runner/t-rex.css": "5a8d0222407e388155d7d1395a75d5b9",
"assets/packages/flutter_inappwebview/t_rex_runner/t-rex.html": "16911fcc170c8af1c5457940bd0bf055",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "b37ae0f14cbc958316fac4635383b6e8",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "5178af1d278432bec8fc830d50996d6f",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "aa1ec80f1b30a51d64c72f669c1326a7",
"assets/packages/youtube_player_flutter/assets/speedometer.webp": "50448630e948b5b3998ae5a5d112622b",
"canvaskit/canvaskit.js": "c2b4e5f3d7a3d82aed024e7249a78487",
"canvaskit/canvaskit.wasm": "4b83d89d9fecbea8ca46f2f760c5a9ba",
"canvaskit/profiling/canvaskit.js": "ae2949af4efc61d28a4a80fffa1db900",
"canvaskit/profiling/canvaskit.wasm": "95e736ab31147d1b2c7b25f11d4c32cd",
"edit_post.dart": "a9c84cd319174e40a5e3fb60c927781c",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"home.dart": "d41d8cd98f00b204e9800998ecf8427e",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "0312458b463c3d350de1432c64f8b1a4",
"/": "0312458b463c3d350de1432c64f8b1a4",
"main.dart.js": "de4df3dfbf9b8b83693b9f1f1af05d9c",
"manifest.json": "83759d7e63d6356c70fc6615ab3e5493",
"version.json": "cfa32e56181536dc5bb725d4de86012a"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
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
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
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
