<template>
  <button @click="$emit('closePopUp')">Close</button>
  <article>
    <section id="article_header">
      <div class="ctn_subtitle">
          <div>// {{this.article.type}}</div>
          <div>{{ this.article.tags  }}</div>
      </div>
      <div id="ctn_article"><h1>{{this.article.title}}</h1></div>
      <div class="title_authorArtist">
        <p>Por <span>{{ this.article.writer }}</span></p>
        <p id="separator">//</p>
        <p>Arte <span>{{ this.article.imageArtist }}</span></p>
      </div>
      <div id="coverImg">
        <img :src="'../src/assets/images/article/' + this.article.id + '/cover.jpg'" :alt="this.article.imageDescription">
      </div>
      <div id="articleDate">
        <p>{{ this.article.date }}</p>
      </div>
    </section>
    <section id="contents">
      <summary id="summary">
        <p>{{ this.article.summary }}</p>
      </summary>
      <div id="content_body"></div>
      <div id="goToTop">
        <a href="#article_header"><img src="../assets/arrowUpIcon.svg" alt="">Ir arriba</a>
      </div>
    </section>
  </article>
</template>
  
<script>  
  export default {
    props: {
      article: {
        type: Object,
        required: true
      }
    },
    mounted() {
      document.getElementById("content_body").innerHTML = this.article.body;
    }
  }
</script>
  
<style scoped>
  @import '@/assets/styles/article.css';
</style>