'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"version.json": "49e831e27c56c959fbcb9f0cebb2b70e",
"index.html": "2940618389efda4c9591f9e5c55f0ca1",
"/": "2940618389efda4c9591f9e5c55f0ca1",
"main.dart.js": "5dd09696640227fd54fae1f049d26686",
"flutter.js": "c71a09214cb6f5f8996a531350400a9a",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "f908c9b9f07efc2cbcf750c35a3c0ccb",
"assets/AssetManifest.json": "369054cfdd6c39cecb28b5c8dbd4c685",
"assets/NOTICES": "dd236ff0a740b1c26f0ed2da50b69ef0",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.bin.json": "7ff6464df07ebfe09c1079aa56a7386d",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "8bc2a8229f25cbee54bef2185b22bed4",
"assets/fonts/MaterialIcons-Regular.otf": "0b84f2b96a5f58dacb7385ed2cac5ee7",
"assets/assets/biru/image_14.jpg": "2bbcb9d4cedb918113df55909e441a0d",
"assets/assets/biru/image_13.jpg": "53f6ff23bb965019b9db448972335654",
"assets/assets/biru/image_12.jpg": "5a38b90ae2c01a8a098412dcd676daeb",
"assets/assets/biru/image_10.jpg": "13d3ae2b87481e5c2e2eb2271e49b63c",
"assets/assets/biru/image_11.jpg": "e0c4789add9bf30866731ad023f2252d",
"assets/assets/biru/image_8.jpg": "1e175faa32c64836e29967a75c443042",
"assets/assets/biru/image_9.jpg": "f6637c328f0381b6f8686d0cd53cc55e",
"assets/assets/biru/image_2.jpg": "d3b8dc353686b90167a3fb70de136efb",
"assets/assets/biru/card2.png": "7ab347a5534229fb3d789b5ae415f898",
"assets/assets/biru/image_3.jpg": "f0d6cf7496841bc9616dd7ad0640a7c8",
"assets/assets/biru/image_1.jpg": "69163e83f61ab8dc60f62dd3b81a2478",
"assets/assets/biru/card1.png": "f320d63434489f1481b496702ee353f3",
"assets/assets/biru/image_0.jpg": "800fd3369b8ba1b7ac79dd896c249557",
"assets/assets/biru/image_4.jpg": "d18f361bd2d25d948464bc98357c1567",
"assets/assets/biru/image_5.jpg": "31824cb92fb1c875f1e1653537156e9a",
"assets/assets/biru/profile.jpg": "973e93dcf30a033ca571071cd6b15bdc",
"assets/assets/biru/image_7.jpg": "001d2fad6a01fe8294d7fba013407a2f",
"assets/assets/biru/image_6.jpg": "c96317ecd675683ae857cc32ee0bf55e",
"assets/assets/biru/place_image.jpg": "334f1d384abbc2f8de5b7ef09ff6457e",
"assets/assets/aadi/Card.png": "7569ee808614cd44eaf5737ee4d6bf13",
"assets/assets/aadi/009c6f93041c8ca8665bdf8ea43b48c7.jpeg": "560a73df1a5fa4e6bdee92ca4735bf74",
"assets/assets/aadi/default-header-mobile.jpg": "632132e78877f780308ad2669f79020d",
"assets/assets/aadi/sri-lanka-photos-8716.jpg": "3b86732eaba50d52f87d20c804cd4167",
"assets/assets/aadi/Poppins-Medium.ttf": "bf59c687bc6d3a70204d3944082c5cc0",
"assets/assets/aadi/1684306263-web-platinum-card.webp": "24f013eff27504a05b1d811736dd9b1a",
"assets/assets/aadi/IMG_3860_11zon.jpg": "c6e2faf77559d8a5a0d2d4075e5f0f80",
"assets/assets/aadi/db2f5d7d548f69a33beaf7af503c9abe.png": "e7f2128e43a688e68641b555f92b1cce",
"assets/assets/aadi/world-mastercard-card_1280x720.jpg": "9949c62f209c9300c234f11aea80e274",
"assets/assets/aadi/Unknown.png": "6de6f6907e3cd750ae8cb141845aa68d",
"assets/assets/aadi/20dc041d0a52add5a92e63d8ec71eacb.jpeg": "e8f91e11ff0b939741d26c7ac7aff5e7",
"assets/assets/aadi/paypal-3384015_1280.png": "d0d6dcc6d61cbd16115f9607d290300a",
"assets/assets/aadi/sri-lanka-photos-0251.jpg": "e25ad9e355fe04fdcdae54d2b4669dae",
"assets/assets/aadi/d627e4d2d0fd4aa38c13b92e4e1e00c3.jpeg": "2b3b6f84714ceb54a29d647b74d19c8f",
"assets/assets/aadi/Gear-Sony-A7IV.jpg.webp": "38bb14fce49b51d61114d27118d33646",
"assets/assets/aadi/apple-pay-og-twitter.jpg": "0f6c545a832b7a2a55cabd381f4e2171",
"assets/assets/aadi/f58b16235864c72499340999e4f54f48.png": "0386ccce11d33f26f3c996aae08c0dfc",
"assets/assets/aadi/9ZXV8w6NKbLhhp6nvqMRef-1200-80.jpg": "e98e78876746a6635725436eb948f6a0",
"assets/assets/aadi/Screenshot%25202024-04-11%2520at%252017.48.28.png": "c98586471f814cade4bcf61869ec14d6",
"assets/assets/aadi/abb688983c8ce242aaf4c7c73c132360.jpeg": "03f7fae174481f8bffc21b7d2dc17008",
"assets/assets/aadi/Unknown.jpeg": "f6f4ed64acf4da7fb3fb6c4b370c7346",
"assets/assets/aadi/d1aaa004c036511f92907b8504fdc84f.jpeg": "9858b6f84ff1d767331a082f27d9bdcb",
"assets/assets/aadi/kayaking-and-boating.jpg": "1c164e123d7a7f4f5ffd9e643f567900",
"assets/assets/varun/otp_image.png": "e97438dd8b965dccb578f1639a12d586",
"assets/assets/varun/traveling.jpg": "9abf55809492e40b4761d0e76f616154",
"assets/assets/varun/Speech_Varun.png": "f3531b3f8e7f6ebaab03637cca98307b",
"assets/assets/varun/password.png": "c0d044fdfb82daef55f0e722f1bfa53f",
"assets/assets/varun/google_logo.png": "ff629c02385f2f3a199b7e0b3065d077",
"assets/assets/varun/otp_image2.png": "bdd1998eb49c4e5cc2da26d2cb842578",
"assets/assets/varun/middle.jpg": "82c808fc98a75a8c971293e2ca00d049",
"assets/assets/vimosh/c8.jpg": "aa26735d5df679c01a4b9b6761d2b261",
"assets/assets/vimosh/x2.jpg": "2784d70afff95126bb8063b7b92d9eb7",
"assets/assets/vimosh/card.jpg": "31db855a57cc1e47b7cc40cd0267d1de",
"assets/assets/vimosh/x3.jpg": "2e0827258831cfbad01f3557bbf1217b",
"assets/assets/vimosh/a1.jpg": "5ccd1108452ae9861c95f6e6b22e140a",
"assets/assets/vimosh/a3.jpg": "d7faa9c99518ec133304c9dd3ea458e6",
"assets/assets/vimosh/x1.png": "ca63f069c821ff9d60b1f171497824ea",
"assets/assets/vimosh/a2.jpg": "7130a716ad9719754a5d4750e6892bf5",
"assets/assets/vimosh/a6.jpg": "98c6785351f812ce79b550d3bf282a9c",
"assets/assets/vimosh/x4.jpg": "6b88fae523482dd11852395bd9baede5",
"assets/assets/vimosh/l.png": "ba6e465b453f2e58b0cafc03c2631dfd",
"assets/assets/vimosh/x5.jpg": "629117b696616ed9e805c0c5a5e753d8",
"assets/assets/vimosh/a7.jpg": "f688dd6daff504838a6238fc45f34fad",
"assets/assets/vimosh/a5.jpg": "2f8e6c8bd2a141297219734b035ba8b6",
"assets/assets/vimosh/x7.png": "bc27745d08e7c61ba6f168498fb06c19",
"assets/assets/vimosh/x6.jpg": "beed6d25cda0b778a084be841d3606d8",
"assets/assets/vimosh/a4.jpg": "df18f25ce4202293b79bf31b5e63d4b3",
"assets/assets/vimosh/g3.jpg": "42b8bd49daa5d45c90fd2a85e4d2d7c9",
"assets/assets/vimosh/g2.jpg": "a17d4b77418a6eefb63e50844ae6145e",
"assets/assets/vimosh/map.png": "59be33c98d538de6498172abb8d26435",
"assets/assets/vimosh/banner1.jpg": "9bafb3757012d241a6e2eff48c610196",
"assets/assets/vimosh/c3.jpeg": "1516899bd7197cde9b942e1d2915501c",
"assets/assets/vimosh/g1.jpg": "073eb12ee014e948d91c950ef1b4db3e",
"assets/assets/vimosh/g5.jpg": "6ff64d9161743cee4cec3e00f8492faf",
"assets/assets/vimosh/g4.jpg": "7ee353f409a94c7db43c4cb0aa65fcf0",
"assets/assets/vimosh/g6.JPG": "e8f91e11ff0b939741d26c7ac7aff5e7",
"assets/assets/vimosh/g7.png": "d4993f6a2a784687c6b6b888b2be3446",
"assets/assets/vimosh/h5.jpg": "079338651a60efcd118ea46b4f0e8117",
"assets/assets/vimosh/reciept.png": "1152c7d1198bec148f4defc6867f9b71",
"assets/assets/vimosh/card3.png": "1f849c7b342b8b06517f984a8d111ef6",
"assets/assets/vimosh/card2.png": "3dfd2de8fbaf6501dc0ad161afb78cd8",
"assets/assets/vimosh/h4.jpg": "e96ed8b2f5c0a8d0e27b69979c494786",
"assets/assets/vimosh/e1.jpg": "d71987229dc47b0d6d01e7d556cbd744",
"assets/assets/vimosh/h6.jpg": "3a1ca83e83be7f97667b6174d31aad2b",
"assets/assets/vimosh/done.png": "f6e9fba06f31d20504265dc3cc860f58",
"assets/assets/vimosh/card1.png": "57ec40747c668377d6784abd249b30c3",
"assets/assets/vimosh/h3.jpg": "d82fd4cec7144c87f8a55b0d413ab0ae",
"assets/assets/vimosh/h2.jpg": "2f690cc553fcf177ebba7ddbd70f08d4",
"assets/assets/vimosh/h1.jpg": "d776c3a1324ef8a9d4b6465f494b7edc",
"assets/assets/vimosh/qr.png": "3fa3468e49f4bb27bbc3e442c8f0ae54",
"assets/assets/vimosh/c1.png": "34bde8fd62eb1494b94be9ee2c6e593c",
"assets/assets/vimosh/c2.jpg": "cb1aca9c6e30de1aab240f107ef95fff",
"assets/assets/vimosh/x8.jpg": "c57caa61c5660993a9b9ca634034248d",
"assets/assets/vimosh/c7.jpg": "9e5e0e34fa3cf9f032bd6ff101951c74",
"assets/assets/vimosh/w2.jpg": "593947fef7d991512777d2d33051459d",
"assets/assets/vimosh/w3.jpg": "e60f2b2e2bf1ffb9284b9bf1f1b2f526",
"assets/assets/vimosh/c4.jpg": "659b197ffd7ef5616dac529b7b820a7f",
"assets/assets/vimosh/w1.jpg": "7a84fb96bc9d53e1e7756aa8c5cfcaee",
"assets/assets/vimosh/image.png": "225655f5ce8918db77c41b27d0ade2aa",
"assets/assets/vimosh/c6.jpeg": "d623e19b5cdfc947b5330b48e275c584",
"assets/assets/vimosh/c5.jpg": "dce4893112bf7ef13d7320133ea8f8a8",
"canvaskit/skwasm.js": "445e9e400085faead4493be2224d95aa",
"canvaskit/skwasm.js.symbols": "741d50ffba71f89345996b0aa8426af8",
"canvaskit/canvaskit.js.symbols": "38cba9233b92472a36ff011dc21c2c9f",
"canvaskit/skwasm.wasm": "e42815763c5d05bba43f9d0337fa7d84",
"canvaskit/chromium/canvaskit.js.symbols": "4525682ef039faeb11f24f37436dca06",
"canvaskit/chromium/canvaskit.js": "43787ac5098c648979c27c13c6f804c3",
"canvaskit/chromium/canvaskit.wasm": "f5934e694f12929ed56a671617acd254",
"canvaskit/canvaskit.js": "c86fbd9e7b17accae76e5ad116583dc4",
"canvaskit/canvaskit.wasm": "3d2a2d663e8c5111ac61a46367f751ac",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
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
