<template>
  <main>
    <section v-if="!(isLoggedIn)">
      <div class="overlay_content">
        <p class="question">Inicia sesión</p>
        <form @submit.prevent>
          <label for="userEmail">E-mail</label>
          <input type="email" name="userEmail" autocomplete="email">
          <label for="userPassword">Contraseña</label>
          <input type="password" name="userPassword" autocomplete="current-password">
          <input class="cta" type="submit" value="Iniciar Sesión">
        </form>
        <p>Para acceder a esta sección tenes que ser colaborador en News.</p>
      </div>
    </section>

    <!--If user is logged in and has writer/artist access let them see the profile-->
    <section> <!--v-else-->

      <section id="profile">
          <div class="ctn_subtitle">
            <div>
              <p> // Editar perfil</p>
            </div>
          </div>
          <button @click="editProfile()">
            <img src="../assets/editIcon.svg" alt="">
            Editar
          </button>
      </section>

      <section id="writeArticle">
          <div class="ctn_subtitle">
            <div>
              <p> // Escribir artículo</p>
            </div>
          </div>
        <WriteArticle></WriteArticle>
      </section>

    </section>
  </main>
</template>

<script setup lang="ts">
  import WriteArticle from '@/components/WriteArticle.vue'
  import { onBeforeMount, ref } from 'vue';
  
  const outstandingarticles = ref([])
  const isLoggedIn = ref(false)
      
  function editProfile() {
    console.log('edit')
  }
</script>

<style>
@import '@/assets/styles/profile.css';
</style>