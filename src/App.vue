<script setup>
  import NavBar from './components/NavBar.vue'
  import Footer from './components/Footer.vue'
/*
  import { initializeApp } from "firebase/app";
  import { getAnalytics } from "firebase/analytics";

  const firebaseConfig = {
    apiKey: import.meta.env.VUE_APIKEY,
    authDomain: import.meta.env.VUE_AUTHDOMAIN,
    databaseURL: import.meta.env.VUE_databaseURL,
    projectId: import.meta.env.VUE_PROJECTID,
    storageBucket: import.meta.env.VUE_STORAGEBUCKET,
    messagingSenderId: import.meta.env.VUE_MESSAGESENDERID,
    appId: import.meta.env.VUE_APPID,
    measurementId: import.meta.env.VUE_measurementId
  };

  const app = initializeApp(firebaseConfig);
  const analytics = getAnalytics(app);*/
</script>

<template>
  <NavBar/>
  <main>
      <RouterView />
  </main>
  <Footer/>
</template>

<style>
@import '@/assets/styles/base.css';
</style>
