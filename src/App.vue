<script setup>
  import NavBar from './components/NavBar.vue'

  import { initializeApp } from "firebase/app";
  import { getAnalytics } from "firebase/analytics";

  const firebaseConfig = {
    apiKey: "AIzaSyDkf6uGtLZJZpjFhdW7upAgrtRvFye_-H0",
    authDomain: "newsmagazine-b803d.firebaseapp.com",
    databaseURL: "https://newsmagazine-b803d-default-rtdb.firebaseio.com",
    projectId: "newsmagazine-b803d",
    storageBucket: "newsmagazine-b803d.appspot.com",
    messagingSenderId: "341014684432",
    appId: "1:341014684432:web:7720936b67631c13db7b95",
    measurementId: "G-GC8RY23KWL"
  };

  const app = initializeApp(firebaseConfig);
  const analytics = getAnalytics(app);
</script>

<template>
  <NavBar/>
  <main>
      <RouterView />
  </main>
</template>

<style>
@import '@/assets/styles/base.css';
</style>
