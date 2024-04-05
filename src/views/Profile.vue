<template>
  <section id="profile">
      <div class="ctn_subtitle">
        <div>
          <p> // Editar perfil</p>
        </div>
      </div>
      <button @click="this.editProfile()">
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
</template>

<script>
import WriteArticle from '@/components/WriteArticle.vue'
export default {
  data() {
    return {
      outstandingArticles: []
    }
  },
  components: {
    WriteArticle
  },
  methods: {
    editProfile() {
    }
  }
}
</script>

<style scoped>
</style>